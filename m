Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSKDChV>; Sun, 3 Nov 2002 21:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSKDChV>; Sun, 3 Nov 2002 21:37:21 -0500
Received: from smtp01.fields.gol.com ([203.216.5.131]:30887 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S264622AbSKDChU>; Sun, 3 Nov 2002 21:37:20 -0500
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Jos Hulzink <josh@stack.nl>
In-Reply-To: <20021103193734.GC2516@pasky.ji.cz>
References: <20021103193734.GC2516@pasky.ji.cz> <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz>
Subject: Re: Petition against kernel configuration options madness...
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 04 Nov 2002 11:43:18 +0900
Message-ID: <87y98a6omx.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis <pasky@ucw.cz> writes:
> > Too bad you don't have any suggestions. I completely agree this should
> > be simplified, while I wouldn't be happy to lose the possibility of not
> > compiling AT keyboard support in.
>
> Well, why can't it be enabled by default? Other options are as well, and it's
> IMHO sane to enable keyboard and mice support by default. It should clear up
> the initial confusion as well.

Keep in mind that All the World's Not a PC.  No doubt those options are
enabled on the majority of kernels, by number, but linux supports many,
many types of systems, and I'll bet on fair number of them, it doesn't
make much sense to enable psaux mouse support!

So ... instead of saying `default y' for these options, how about saying
`default IM_ON_A_PC' where IM_ON_A_PC is defined somehow.  How, I don't
know; it could be a separate config question in a very obvious place,
perhaps itself having `default X86'.

Perhaps this should really be two flags, one IM_ON_A_PC meaning `typical
i386 pc with legacy devices', and the other, more general, being
something like IM_ON_A_WORKSTATION.  Then wierd things like psaux would
say `default IM_ON_A_PC', but more general things like keyboards would
say `default IM_ON_A_WORKSTATION'.

[Yeah, those names are sucky, I know...]

Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 
