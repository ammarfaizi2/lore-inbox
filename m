Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUGLNLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUGLNLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266815AbUGLNLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:11:51 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:51736 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S266813AbUGLNLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:11:48 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: HDIO_SET_DMA failed on a Dell Latitude C400 Laptop
Date: Mon, 12 Jul 2004 14:07:14 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407121407.14428.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I've just burnt a cd for the first time on a Dell Latitude C400 laptop and I 
noticed that the system was quite sluggish while the burn was happening. 
(mouse pointer erratic, window redraw slow etc).

Remembering a similar issue with a desktop system, I did the following to 
enable DMA on the hard drive (hdparm was giving ~3MB/sec read)

# hdparm -c1 -d1 /dev/hda

/dev/hda
 setting 32-bit IO_support flag to 1
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 IO_support   =  1 (32-bit)
 using_dma   =  0 (off)


hdparm now reports ~7MB/sec which is better but still prety poor.


Any ideas why I couldn't set DMA on the drive?


CPU = Mobile Pentum 3 @1.2GHz (800MHz when booted with no power cord)
Ram = 256MB
HDD = IBM Travelstar (IC25N020ATDA04-0) 20GB
BIOS Rev = A12


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8o0CBn4EFUVUIO0RAtrMAKCW7sohHS2muGZjJ8rqTEuCOMlD7wCfRB4T
D+rI56ie5zpMtj/ed7Bz78g=
=z33I
-----END PGP SIGNATURE-----
