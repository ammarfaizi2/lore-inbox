Return-Path: <linux-kernel-owner+w=401wt.eu-S1751527AbWLLQ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWLLQ1p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWLLQ1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:27:44 -0500
Received: from alnrmhc11.comcast.net ([206.18.177.51]:48390 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbWLLQ1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:27:41 -0500
Message-ID: <457ED87A.5@comcast.net>
Date: Tue, 12 Dec 2006 11:27:38 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: libata and sata?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A while back my distro moved to libata for sata_via.  I was since
confused; my disk seemed a lot slower, and it looked like DMA was off.
I'm not sure how SATA works; is it even possible to enable/disable
32-bit IO and DMA?  Or are those just on?

sata_via               11524  4
libata                112660  3 ata_generic,pata_via,sata_via

~$ sudo hdparm -d1 -c1 -u1 /dev/sda

/dev/sda:
 setting 32-bit IO_support flag to 1
 HDIO_SET_32BIT failed: Invalid argument
 setting unmaskirq to 1 (on)
 HDIO_SET_UNMASKINTR failed: Inappropriate ioctl for device
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Inappropriate ioctl for device
 IO_support   =  0 (default 16-bit)

I no longer have two kernels to test through; I can't tell if the speed
is back or not.  Nothing in dmesg tells me if SATA is using DMA or
32-bit IO support though, so I don't know... lack of knowledge over here
is killing me for troubleshooting this on my own.

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRX7YeAs1xW0HCTEFAQIZ5w/9GCEP1LMCqTAa366wSg6WcwomBL1fsSik
xrZJ2ZGAzKyAkKA6DLDKjJ12fG1Pueri5qj7Cx8iRgPOFTnXg3+zNdC26uWJ2cSR
hlXI/GkjMAaB2yXidPHkfpsh1fROQoiWPy+wQ8ppXVfW/xwgFUPFst5OWoU/HSbn
8Y72tUDgsj5QjWtn6XendpND8kq59Aqw4A+WG8ThW5FyRNXa5zyd8IW6bSmLGKAa
+/PCp937aK6us8LAqlkjqHaqN+JavS+lTxFXb0ZhStKteoGo0z79IvuwnRbNtJR5
XwDBzWhic1IDTV5NOyxDQ0fBoVTllIKeY55v84lzbRrYJOIiKaze1dyDPPT/nAlo
2nS1rXP+X+3RxqUrD5kXorGSHdTqVQoBINfnntrKTkNqAKUNQ4YxlBmwzsoYsIHO
/h0hCEFoIp1wFokKEP6/Dz6TM63G3m+tadPLpSbQ2u4yEg8N8vSZeix61EieNoAU
nR8YZW52BK6rGc0/IrJRE2fVd90gxSjvN2T3o3Du+cjPHdYQhlvV3GFcIsFVIp3Y
GkXO9T29HwgZO/KuA02vhjqgP2WvC5qeV4ansbukGBBi8jaanm6qf7PcsN0/1bNr
bWqYCfzvIuIg/FPiK7XzkmVJ6cipBbCHEGqBQiQn6D0lpA715Me+T8uTH3HPUX4l
oclOnqemO+w=
=TU0m
-----END PGP SIGNATURE-----
