Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277766AbRJIPGG>; Tue, 9 Oct 2001 11:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277768AbRJIPF4>; Tue, 9 Oct 2001 11:05:56 -0400
Received: from bellini.kjist.ac.kr ([203.237.41.6]:1668 "EHLO
	bellini.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S277766AbRJIPFl>; Tue, 9 Oct 2001 11:05:41 -0400
Date: Wed, 10 Oct 2001 00:06:08 +0900
Message-Id: <200110091506.f99F68P12059@bellini.kjist.ac.kr>
From: "G. Hugh Song" <hugh@bellini.kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: VM-related freeze of UP2000SMP using 2.4.11-pre3aa1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My UP2000 SMP running SuSE-7.1 with two 21264s with 2GB memory and 
5GB swap space has got a VM-related trouble since I updated the 
kernel to 2.4.11-pre3aa1.

When the main memory is fully utilized and the swap space starts to be
used, the machine freezes.  The machine can be pinged.  But all 
other activities are dead silent with no message in /var/log/messages.

This happens every night around 0:15AM /etc/cron.daily/* is being scanned.

The version I had used before the last kernel update was
2.4.10-pre8aa*, and had had no apparent problem.

I wish I could confirm that the current problem is due to the new 
kernel.  Was there any known vm-related bug in 2.4.11-pre3aa1?

I reviewed "patch-2.4.11.log" which contained :

=========c=========c============c==========c=========
pre6:
 - various: fix some module exports uncovered by stricter error checking
 - Urban Widmark: make smbfs use same error define names as samba and win32
 - Greg KH: USB update
 - Tom Rini: MPC8xx ppc update
 - Matthew Wilcox: rd.c page cache flushing fix
 - Richard Gooch: devfs race fix: rwsem for symlinks
 - Björn Wesen: Cris arch update
 - Nikita Danilov: reiserfs cleanup
 - Tim Waugh: parport update
 - Peter Rival: update alpha SMP bootup to match wait_init_idle fixes
 - Trond Myklebust: lockd/grace period fix

pre5:
 - Keith Owens: module exporting error checking
 - Greg KH: USB update
 - Paul Mackerras: clean up wait_init_idle(), ppc prefetch macros
 - Jan Kara: quota fixes
 - Abraham vd Merwe: agpgart support for Intel 830M
 - Jakub Jelinek: ELF loader cleanups
 - Al Viro: more cleanups
 - David Miller: sparc64 fix, netfilter fixes
 - me: tweak resurrected oom handling

pre4:
 - Al Viro: separate out superblocks and FS namespaces: fs/super.c fathers
   fs/namespace.c
 - David Woodhouse: large MTD and JFFS[2] update
 - Marcelo Tosatti: resurrect oom handling
 - Hugh Dickins: add_to_swap_cache racefix cleanup
 - Jean Tourrilhes: IrDA update
 - Martin Bligh: support clustered logical APIC for >8 CPU x86 boxes
 - Richard Henderson: alpha update

=======c==========c===========c==========c===========c============

I am not that knowledgeable about the vm-things.
So far, Andrea has not produced his patch set for pre4 -- pre6 yet.
His most up-to-date is 2.4.11-pre3aa1.

For Alpha/Linux, I have been using -aa versions all along.  How much 
do I lose by using original Linus versions?

Thank you.

Best regards,

G. Hugh Song
