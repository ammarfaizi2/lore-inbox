Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCZT4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUCZT4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:56:32 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:13069 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261162AbUCZT41 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:56:27 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] WOLK v2.3 for Kernel v2.6.4
Date: Fri, 26 Mar 2004 20:54:55 +0100
User-Agent: KMail/1.6.1
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403262054.56725@WOLK>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

ok, next 2.6-WOLK release. Apply ontop of a vanilla 2.6.4 from kernel.org.

Many thanks to Rik van Ballegooijen and all the other people sending fixes!

... Have fun and a nice weekend :)


BIG NOTE:
- ---------
We now have 5 addons in place, named: grsecurity2, Win4Lin, gobohide, SysTrace
and finally the Staircase Scheduler by Con. I won't merge any of these
patches into mainline 2.6-WOLK in the near future. You have to decide what
addon feature you like to have :) ... Another reason is, I won't break users
of 4g/4g, 4k stacks nor uml-skas3, currently a no-go with grsecurity. Apply
an addon/the addons manually. All five patches are located in the patch itself
in the ./ADDON-patches directory after applying the main patch. Apply as
usual.

wolk2.2 was never released (ok, it was available for some hours but I removed
it because it was broken. Therefore, changelog included too)



KNOWN ISSUES:
- -----------------
- - Loop-AES won't work with per-backing dev unpluggin code in WOLK.
  But fortunately loop-AES coders updated their code. So get the newest
  version before trying loop-AES with WOLK (includes also -mm tree)




Changelog from v2.6.4-wolk2.2 -> v2.6.4-wolk2.3
- -----------------------------------------------
              merged with 2.6.5-rc2				(Linus Torvalds)
              merged with 2.6.5-rc2-mm3				(Andrew Morton)
              - w/o 4k-stacks-always-on.patch (NVIDIA folks)
	      - w/o bk-acpi stuff from 2.6-bk tree (broken)
	      - w/ cpu detection for 2.6.5-rc1-mm2		(Manfred Spraul)
	      - w/ "2.6.5-rc2-mm* machine won't boot" fix	(Andrew Morton)
o   added:    objrmap for file mappings (2.6.5-rc2-aa4)		(Andrea Arcangeli)
o   added:    anon_vma for memory unmapping (2.6.5-rc2-aa4)	(Andrea Arcangeli)
o   added:    prio trees (2.6.5-rc2-aa4)			(Andrea Arcangeli)
o   added:    morse code panic					(Tomas Szepe)
o   added:    VFS: Soft-/Hard Limit of file descriptors		()
o   added:    Maximum amount of unix sockets via sysctl		()
o   added:    Renice processes as a user in a special GID	(me)
o   added:    rICMP support					(Nail)
o   added:    improved fdmap support				(Matt Miller)
o   added:    ADDON: systrace v1.5				(Niels Provos)
o   added:    ADDON: staircase scheduler			(Con Colivas)
                (WOLK port by Rik van Ballegooijen)
o   fixed:    fb colour used to clear top and bottom margins	(Jakub Bogusz)
o   fixed:    fb background used for "clear" terminal commands	(Jakub Bogusz)
o   fixed:    ReiserFS v3 buffer refcount problem		(Chris Mason)
o   fixed:    ReiserFS v3 buffer head leak in invalidatepage	(Chris Mason)
o   fixed:    ReiserFS v3 bogus warning message about locked	(Chris Mason)
                buffers during logging.
o   fixed:    when CONFIG_IP_NMAP_FREAK was not set, the kernel	(anonymous)
                did not reply to any icmp echo requests :(
o   updated:  O(1) Batch scheduler for 2.6			(Rik van Ballegooijen)
o   updated:  ReiserFS v3 extended attributes			(Chris Mason)
o   updated:  ReiserFS v3 POSIX Access Control Lists		(Chris Mason)
o   updated:  ReiserFS v3 Security Labels			(Chris Mason)
o   updated:  ADDON: grsecurity2				(Brad Spengler)
o   updated:  netdev-random: Drivers v2.6.4			(Michal Purzynski)
o   changed:  max loop devices to 32 (from 8)			(me)
o   changed:  max msg queue identifiers to 512 (from 16)	(me)
o   changed:  max semaphore identifiers to 1024 (from 128)	(me)
o   removed:  stupid/nonsense warning in Supermount		(Rik van Ballegooijen)



Changelog from v2.6.4-wolk2.1 -> v2.6.4-wolk2.2
- -----------------------------------------------
              merged with 2.6.5-rc1-mm2				(Andrew Morton)
              - w/o 4k-stacks-always-on.patch
              - w/ "anti 2.6.5-rc1-mm2-is-dog-slow-patch" ;)	(Jens Axboe)
o   added:    O(1) Batch scheduler for 2.6			(Con Kolivas)
                (WOLK port by Rik van Ballegooijen)
o   added:    O(1) ISO scheduler for 2.6			(Con Kolivas)
o   fixed:    classic OOM killer (the default) compile error	(Robert Führicht)
o   fixed:    compile warning in rc-update.h with gcc 3.4	(Robert Führicht)
o   fixed:    compile problems with gcc 2.95.x			(me)
o   fixed:    bootsplash breakage				(Rik van Ballegooijen)
o   fixed:    shfs compilation error				(Rik van Ballegooijen)
o   fixed:    PRAMfs compilation error				(Rik van Ballegooijen)
o   fixed:    SCSI oops() in -mm tree				(Kai Makisara)
o   fixed:    compile problems on ppc64				(Paul Mackerras)
o   removed:  some SATA fixes (did not really fix anything)







Todo
- ----
o  /proc restrictions w/o the need for grsecurity2 addon
o  madwifi
o  Linux Trustees
o  rsbac as an addon
o  menu cleanups
o  DRBD once it's ported to 2.6
o  Bind Bount Extensions 0.05
o  vservers for 2.6 once Herbert comes up with a patch
o  probably changing O(1) Scheduler addons to a config option
o  _____ <add more things if you want>




md5sums:
- --------
02d50db9872e44f686dcc21361d019d3  linux-2.6.4-wolk2.3.patch.bz2
6fe224fd75e3c15b776b87a810dec2d4  linux-2.6.4-wolk2.3.patch.gz


- --
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint:  3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://pgp.mit.edu. Encrypted e-mail preferred
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: !! No Risk - No Fun !! - Try to crack this ;-)

iD8DBQFAZIqPVp3i49tEGhYRAiTxAJ9FcVnDVEOjsf7NcEgamoTy3PzcbgCdGYPW
s22a478UkeLo4ki/g9Uvaug=
=hsR2
-----END PGP SIGNATURE-----
