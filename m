Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSJLSSH>; Sat, 12 Oct 2002 14:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSJLSSH>; Sat, 12 Oct 2002 14:18:07 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:18102 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261326AbSJLSSG>; Sat, 12 Oct 2002 14:18:06 -0400
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
References: <Pine.LNX.4.44.0210121145510.17947-100000@chaos.physics.uiowa.edu>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sat, 12 Oct 2002 20:23:30 +0200
Message-ID: <87smzbv7ml.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai-germaschewski@uiowa.edu> writes:

> On Sat, 12 Oct 2002, Olaf Dietsche wrote:
>
>> When building 2.5.42 UML it fails with:
>> [...]
>
> Okay, so here's a patch which fixes the UML build for me (i386) -
> generally, UML could use some more kbuild work, but I'll leave that for
> post-freeze ;)
>
> --Kai
>
>
> Pull from http://linux-isdn.bkbits.net/linux-2.5.make
>
> (Merging changesets omitted for clarity)
>
> -----------------------------------------------------------------------------
> ChangeSet@1.784, 2002-10-12 11:47:37-05:00, kai@tp1.ruhr-uni-bochum.de
>   kbuild: Fix UML build
>   
>   Not perfectly clean yet, but uses the standard way to descend into subdirs
>   and gives me working vmlinux and linux targets without spurious rebuilds.
>
>  ----------------------------------------------------------------------------
>  Makefile               |   33 ++++++++++++++++++++-------------
>  Makefile-i386          |   35 ++++++++++++++++-------------------
>  sys-i386/util/Makefile |   14 ++++++++------
>  util/Makefile          |   18 +++++++++---------
>  4 files changed, 53 insertions(+), 47 deletions(-)
>
> =============================================================================
> unified diffs follow for reference
> =============================================================================
[...]

Thanks! I was still trying to figure out, how all this is supposed to
work :-).

Though, it still gives one error right at the beginning:

  gcc -E -Wp,-MD,arch/um/.uml.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -nostdinc -iwithprefix include   -Ui386 -DSTART=$((0xc0000000 - ((0 + 1) * 0x20000000))) -DELF_ARCH=i386 -DELF_FORMAT=\"elf32-i386\" -P -C -Uum   -o arch/um/uml.lds.s arch/um/uml.lds.S 
/bin/sh: scripts/fixdep: No such file or directory
make: *** [arch/um/uml.lds.s] Error 1

Regards, Olaf.
