Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUEKOiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUEKOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbUEKOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:38:16 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:4764 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264766AbUEKOiK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:38:10 -0400
Message-Id: <200405111335.i4BDZeca030441@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Richard A Nelson <cowboy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?) 
In-Reply-To: Your message of "Mon, 10 May 2004 21:06:50 EDT."
             <200405110106.i4B16o97010526@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet>
            <200405110106.i4B16o97010526@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1589911483P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 09:35:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1589911483P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 21:06:50 EDT, Valdis.Kletnieks@vt.edu said:

> > : Unable to handle kernel NULL pointer dereference at virtual address 0000000

> > :  [show_stack+122/144] show_stack+0x7a/0x90
> > :  [show_registers+324/432] show_registers+0x144/0x1b0
> > :  [die+153/272] die+0x99/0x110
> > :  [do_page_fault+485/1327] do_page_fault+0x1e5/0x52f
> > :  [error_code+45/56] error_code+0x2d/0x38
> > :  [sysfs_rename_dir+193/224] sysfs_rename_dir+0xc1/0xe0
> > :  [kobject_rename+33/64] kobject_rename+0x21/0x40
> > :  [class_device_rename+56/80] class_device_rename+0x38/0x50
> > :  [dev_change_name+315/448] dev_change_name+0x13b/0x1c0
> > :  [dev_ioctl+339/704] dev_ioctl+0x153/0x2c0
> > :  [inet_ioctl+154/176] inet_ioctl+0x9a/0xb0
> > :  [sock_ioctl+239/656] sock_ioctl+0xef/0x290
> > :  [sys_ioctl+261/608] sys_ioctl+0x105/0x260
> > :  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
> 
> Am seeing this as  well, while running 'nameif' to rename real Ethernet interfaces.

In case nobody shot this bug overnight... More info

The problem is in one of the sysfs-backing-store patches.  I backed out the 6
sysfs-leaves-* patches and my system boots OK. (My kernel *does* still have
fix-sysfs-symlinks on).  It won't be till late afternoon before I have time to
play binary-search on the 6 remaining..


--==_Exmh_-1589911483P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoNarcC3lWbTT17ARAnbmAJ9dyr1kwVrorxzUOwbEGdRFQ9bXMgCfYiwd
N8YFCXtCwmOQrGjw2/vyHbc=
=0NjM
-----END PGP SIGNATURE-----

--==_Exmh_-1589911483P--
