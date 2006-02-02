Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWBBOg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWBBOg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBBOg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:36:28 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:14794 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751093AbWBBOg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:36:27 -0500
Date: Thu, 02 Feb 2006 09:36:23 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.15-mm3 hang with raid-1
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20060202143623.GC1188@pool-71-123-118-13.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=8GpibOaaTibBMecb
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Running 2.6.15-mm3 PREEMPT on an Athlon XP, Asus motherboard with
VT8366/A/7 chipset.

I have a 240GB raid0 on hda3 and hdc1 containing a reiser3
filesystem. It works fine.

I have a 40GB raid1 on hda2 and hdd1, which is giving me problems. I
can write to all of hda2 and hdd1 (before creating the array) without
error, and mdadm seems to create the array all right.

However, just after the array finishes synchronizing (either after
creation or messy reboot), all new commands hang (I can still type at
existing shells, but as soon as I try to run a program, it becomes
unresponsive). While hung, disk activity light is off. On reboot, the
array is detected as clean, no synchronization is done, and my system
works (until I try to use the raid1 array).

mkreiserfs /dev/md0 also causes the hang, when it syscalls fsync().

My system disk is hda1, so I don't know if all disks are hung up, or
just all of hda.

I'm doing all this at the console, and I see no error messages.

The computer keeps performing NAT, and alt-sysrq-b works.

What can I do to fix or help debug this problem?

-Eric

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFD4hjnce4O6PAsbIkRAgGQAJ9KScOYtj/HhxOWwGMIh23OeKB7dwCfWFw9
F95c4oevFXumno93LLTEltU=
=AVaU
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
