Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTBAA5K>; Fri, 31 Jan 2003 19:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTBAA5K>; Fri, 31 Jan 2003 19:57:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53567 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264630AbTBAA5J>; Fri, 31 Jan 2003 19:57:09 -0500
Date: Fri, 31 Jan 2003 20:06:33 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302010106.h1116XP08674@devserv.devel.redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Perl in the toolchain
In-Reply-To: <mailman.1044055681.1939.linux-kernel2news@redhat.com>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org> <mailman.1044055681.1939.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact of the matter is, the area of build tools matters most to 
> people who cross-compile their kernels, because every tool is generally 
> hand-built rather than automatically installed on their Linux system. 
> For this audience, as well as the typical non-cross-compiling kernel 
> developer, Perl is on their system.

Sure, but I want to self-host, too. I can cross-compile kernels,
but cross-compiling modutils is an insane pain, for example,
so to this day I never ever used Rusty's new shiny module loader,
and thus I never got around to fix dots in export symbols.

For the record, the userland which I posess does have a somewhat
working Perl RPM, which originates from Red Hat 5.2, I believe.
So, I cannot invoke "missing perl" argument in good conscience.
However, I shudder to think what happens if I need to rebuild it
for some reason.

> However, that fact is less significant than the more basic and core 
> argument:
> 
> klibc uses perl for text munging.  i.e. one of Perl's acknowledged 
> strengths.  This is not a case of choosing a favorite script language, 
> but instead a case of choosing "the right tool for the job."  Regardless 
> of whether you think Perl is line noise :) or not, from a technical 
> basis Perl is clearly superior to sed+awk in this case.

I hear you. Actually, your argument comes in force only after a
non-trivial amount of mungling, but to slay your argument
I need to see your klibc stuff first.

> Adding some final thoughts, perl is already used in nooks and crannies 
> in the build system.  Instead of being motivated to stomp those out, 
> please [respectfully!] consider that the Perl scripts might be there 
> because an evaluation of the best tool for the job took place. 
> script_asm.pl in drivers/scsi is a favorite example here.

There's also a subject of a skillset. I know nil about Perl.
(ok, I hacked sirc long ago. I don't think it counts.)
This means I cannot debug and fix your text mungling.
Perl not only has a reputation for being perfect for text
mungling, but also a reputation for being unreadable by anyone
but the author (due to the fact that the same thing can be
expressed in a half a dozen different ways - so says Larry Wall
himself in my Perl book (ok, he actually makes strict subsets
of knowledge, which helps very little in my example ("Programming
Perl", p33 - What You Don't Know...))).

-- Pete
