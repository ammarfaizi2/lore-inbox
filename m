Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310789AbSCSLqy>; Tue, 19 Mar 2002 06:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310829AbSCSLqo>; Tue, 19 Mar 2002 06:46:44 -0500
Received: from pD9E53E9A.dip.t-dialin.net ([217.229.62.154]:48356 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S310789AbSCSLqa>;
	Tue, 19 Mar 2002 06:46:30 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: SysRq question
In-Reply-To: <Pine.LNX.4.33L2.0203180922230.2434-100000@dragon.pdx.osdl.net>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Tue, 19 Mar 2002 12:45:56 +0100
Message-ID: <m3pu20hjbf.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:
> On Mon, 18 Mar 2002, David Woodhouse wrote:
>
> | rddunlap@osdl.org said:
> | >  I've seen a couple of cheapo keyboards where some Alt-SysRq-key
> | > combinations don't generate anything from the keyboard.  (I'm typing
> | > on one of them right now.) For example, Alt-SysRq-5|6 works, but
> | > 1,2,3,4,7,8,9 don't.
> |
> | Try using the other Alt key.
>
> Same result with either Alt key.

BTW that's not the problem I'm seeing, Alt-SysRq-*ANYTHING* is not
caught from any of the offending keyboards because (IIRC) they send
Alt-SysRq as a two-code sequence, with the (apparently) Alt-Down code
repeated before the command keycode - thus, all the command keycode
parser sees (it seems it looks only at the first byte after Alt-SysRq)
is the Alt-Down keycode, which is not a command.

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
