Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbREOVUs>; Tue, 15 May 2001 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbREOVUi>; Tue, 15 May 2001 17:20:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261534AbREOVU0>; Tue, 15 May 2001 17:20:26 -0400
Message-ID: <3B019D8A.86C18D1C@transmeta.com>
Date: Tue, 15 May 2001 14:20:10 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Tim Fletcher <tim@parrswood.manchester.sch.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Device Numbers, LILO
In-Reply-To: <Pine.LNX.4.33.0105152156200.4099-100000@redwood.parrswood.manchester.sch.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Fletcher wrote:
> 
> > It's in, but for some strange reason you have to ask for it explicitly
> > with the "lba32" option.
> 
> Because the 32bit bios calls lilo uses in lba32 mode can cause problems
> with broken or old bios's hence is defaults to a safe option, and if you
> can't boot without it (over 1023 cylinders) then you turn it on at your
> own risk.
> 
> I know this from the experiance of breaking lilo on my workstation :)
> 

The problem is that LILO tries one or the other, instead of dynamically
using whichever one it needs.  Heck, you may not be able to make that
decision until boot time anyway!  You can then either always try LBA
calls and see if they are available, or default to CHS calls unless
cylinder > 1023.

LILO tries to do *way* too much at install time.  The fact that you have
to specify "linear" explicitly is a joke -- there is no excuse for
!linear.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
