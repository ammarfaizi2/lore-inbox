Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbSJDRbf>; Fri, 4 Oct 2002 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSJDRbf>; Fri, 4 Oct 2002 13:31:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55588 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262791AbSJDRbc>; Fri, 4 Oct 2002 13:31:32 -0400
Date: Fri, 4 Oct 2002 13:36:57 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004133657.B17216@devserv.devel.redhat.com>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de> <20021003235022.GA82187@compsoc.man.ac.uk> <mailman.1033691043.6446.linux-kernel2news@redhat.com> <200210040403.g9443Vu03329@devserv.devel.redhat.com> <20021003233221.C31444@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003233221.C31444@openss7.org>; from bidulock@openss7.org on Thu, Oct 03, 2002 at 11:32:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 3 Oct 2002 23:32:21 -0600
> From: "Brian F. G. Bidulock" <bidulock@openss7.org>

> > GPLed code has no problem linking with sys_call_table.

> The code in question (LiS) is LGPL and open source.  The iBCS
> packge is GPL and open source.

I looked at the code scene a little here, and I do not think
there's anything that needs the syscall table.

The oprofile author seems to have things fixed already,
though the change did not filter down yet. He's also thin
skinned and was fuming a little, but I expect technical merit
to take the upper hand in his clueful head. I remember being
seriously rattled by DaveM in similar circumstances, and coming
out just fine.

LiS is crap and has to die, so it's not a problem. We actually
had a *very* big customer who used it, got a relatively decent
performance too (as much as could be expected from, ahem, the
framework :-), but it kept crashing all the time. Took a little
work to move them off LiS, but it was worth it.

iBCS is interesting for vendors, which I think, are cool with
shipping a patch. That's something SCO will happily sell to you
if you want to run old binaries casually. A standalone person who
risks running complicated UNIX binaries and debugs when they fail
can do the patch too, there's no chilling effect.

This leaves syscalltrack, which is pretty interesting in general,
but I think Mulix suffers from CVS mentality a little here.
He should aim at getting the hooking mechanism into the kernel.
I do not think his attempts to act remora and make it transparent
are safe. Anyway, it's a code which needs to mature and sort it
out with other hooking mechanisms, we already have dozens of them.
Let the Darwinean process to work here a little, then we'll see.

> And what about AFS?  I see that it uses a sys_ni_syscall slot as
> well...

Dhowell's kafs will take care of it. It should not need to overwrite
syscalls anyway.

-- Pete
