Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVLUHui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVLUHui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVLUHui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:50:38 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:5133 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932309AbVLUHui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:50:38 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as
 non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
	<87d5jru67j.fsf@amaterasu.srvr.nix>
	<20051220155839.GA9185@mars.ravnborg.org>
	<87irtjslxx.fsf@amaterasu.srvr.nix>
	<20051220202559.GK27946@ftp.linux.org.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Wed, 21 Dec 2005 07:49:20 +0000
In-Reply-To: <20051220202559.GK27946@ftp.linux.org.uk> (Al Viro's message of
 "20 Dec 2005 20:26:33 -0000")
Message-ID: <87psnqnb3z.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2005, Al Viro wrote:
> On Tue, Dec 20, 2005 at 05:44:10PM +0000, Nix wrote:
>> > 4) Builds for several architectures from same source base
>> 
>> cp -al
>> 
>> > 5) Builds for several different configurations
>> 
>> cp -al
> 
> ... apply a patch and watch the resync hell.  That really, really doesn't
> work well enough for use when doing any kind of development.

Well, personally I handle patch-application in cp -al'ed trees by doing
cp -al via a script, and repatching all currently hardlinked trees
(obviously if they are very divergent some patches will fail and I'll
have to fix them up by hand).

It works for me well enough to keep hardlinked branches going for in
some cases years without problems.

(On top of that, I've sometimes considered a switch to patch(1) that
switches to truncate-and-rewrite rather than unlink-and-replace. Haven't
implemented it yet though.)


(And if you're using this to maintain development branches, then you
have resync and conflict-management problems *anyway*, which this makes
no worse.)

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
