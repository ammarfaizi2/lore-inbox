Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUCQSnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCQSnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:43:32 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:56585 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261940AbUCQSn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:43:27 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] WOLK v2.1 for Kernel v2.6.4
Date: Wed, 17 Mar 2004 19:36:47 +0100
User-Agent: KMail/1.6.1
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403171936.49727@WOLK>
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

1st maintenance patch for 2nd WOLK edition for 2.6. Apply ontop of a vanilla
2.6.4 from kernel.org.

Tell me what you think, how it works, what I've missed, what should go in bla
bla you know what I mean ;)

Have fun :)


BIG NOTE:
- ---------
I haven't merged grsecurity v2 nor Win4Lin into mainstream WOLK for 2.6.
Currently, I won't break users of 4g/4g, 4k stacks nor uml-skas3, currently a
no-go with grsecurity. Win4Lin is Desktop Usage, so if you want that, apply
it manually. Both patches are located in the patch itself in
the ./ADDON-patches directory after applying the main patch. Apply as usual.


P.S.: I got a couple of requests to merge LIDS into 2.6-WOLK. I won't merge
      LIDS for 2.6. No, no way, never, ever. Merge it yourself if you want to
      use a security system with security holes! ;)




Changelog from v2.6.4-wolk2.0 -> v2.6.4-wolk2.1
- -----------------------------------------------
              merged with 2.6.5-rc1				(Linus Torvalds)
              merged with 2.6.5-rc1-mm1				(Andrew Morton)
              - w/o early-x86-cpu-detection-fix.patch
              - w/o early-x86-cpu-detection.patch
              - w/o 4k-stacks-always-on.patch
              - w/ various fixes
o   added:    modular OOM killer (was in 2.4-WOLK for ages)	(TvrtkoA.Ursulin)
o   added:    "echo off /proc/modules" stops ability to load	Michal Purzynski)
                and unload modules until reboot.
o   added:    orinoco driver monitor mode			()
o   added:    static_routes, alt_routes, nf_reroute (2.6.4-ja1)	(J. Anastasov)
o   added:    conf/*/hidden sysctl support (2.6.4-ja1)		(J. Anastasov)
o   added:    iparp/arprules support (2.6.4-ja1)		(J. Anastasov)
o   added:    conf/*/rp_filter_mask support (2.6.4-ja1)		(J. Anastasov)
o   added:    conf/*/forward_shared support (2.6.4-ja1)		(J. Anastasov)
o   added:    send-to-self-2 (conf/*/loop support) (2.6.4-ja1)	(J. Anastasov)
o   added:    ADDON: grsecurity2: more proc restrictions	(me)
o   added:    ADDON: grsecurity2: ability to debug ACL set	(me)
o   added:    ADDON: grsecurity2: ELF text relocation logging	(solar/gentoo)
o   added:    ADDON: grsecurity2: PaX status /proc/#pid/status	(solar/gentoo)
o   added:    ADDON: grsecurity2: selinux-hooks			(solar/gentoo)
                these allow selinux to hook directly into pax
                for policy enforcement.
o   added:    ADDON: grsecurity2: selinux-ipaddr		(solar/gentoo)
                this allows selinux to track ip address via
                policy.
o   fixed:    memory corruption on hyperthreaded x8664 machines	(S. B. Siddha)
o   fixed:    wait_task_inactive should not return on preempt	(Rusty Russel)
o   fixed:    blkpg ioctl32 handling				(Jeremy Katz)
o   fixed:    cfq io scheduler did not compile on X86_64	(Robert Führicht)
o   fixed:    HZ leaking to userspace in BSD accounting		(Tim Schmielau)
o   fixed:    ADDON grsecurity2: oops() gr_search_connectbind	(Brad Spengler)
o   fixed:    ADDON grsecurity2: oops() with multithreading	(Brad Spengler)
o   fixed:    some other X86_64 compilation problems		(me)
o   fixed:    NFS_ACL and NFSD_ACL needs FS_POSIX_ACL		(me)
o   fixed:    "default n" for many addons			(me)
o   updated:  FireWire IEEE1394 rev1191				(Ben Collins)
o   removed:  Bind mount Extensions (BME) v0.03
                - will re-add once 0.05 is out
o   removed:  Application Layer 7 QoS v0.4.1b
                - deprecated (by request of Matthew Strait)
o   removed:  Prism GT/Duette 802.11(a/b/g) PCI/PCMCIA support
                - merged in Mainline now
o   ADDON:    gobohide 2.6.3					(GoboLinux)



Todo
- ----
o  Linux Trustees
o  menu cleanups
o  DRBD once it's ported to 2.6
o  Bind Bount Extensions 0.05
o  vservers for 2.6 once Herbert comes up with a patch
o  _____ <add more things if you want>



md5sums:
- --------
a8e90b4b3df7455ba2d6cce5c902cc67  linux-2.6.4-wolk2.1.patch.bz2
e3007a63107cc6f76517d8d39f88aabf  linux-2.6.4-wolk2.1.patch.gz


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

iD8DBQFAWJq/Vp3i49tEGhYRAllyAKC7C4haBgg7i2jdhIpEJyhoiQ70wQCgpx7i
QWaSUXjImSWAsVoMaof5QVA=
=wEL0
-----END PGP SIGNATURE-----
