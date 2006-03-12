Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWCLQ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWCLQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCLQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:28:13 -0500
Received: from nef2.ens.fr ([129.199.96.40]:41745 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750814AbWCLQ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:28:12 -0500
Date: Sun, 12 Mar 2006 17:28:25 +0100
From: Eric.Brunet@lps.ens.fr
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Problem with a CD
Message-ID: <20060312162825.GA16993@platane.lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 12 Mar 2006 17:28:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In short: I have a CD that windows XP can read but that linux cannot.

I have a mini-CD (with a diameter of 8 cm) that I am trying to read. I
have tried two computers:

#1 an i386 desktop PC with an up to date FC4 (kernel 2.6.15-1.1833) and
an internal LG optical drive (CD and DVD reader/burner)

#2 an i386 laptop PC with a not so up to date FC4 (kernel 2.6.14-1.1637)
and an external (USB) ASUS optical drive (combo CD burner/DVD reader)

On both machines, under linux, I can mount the CD (iso9660 filesystem),
read the directory structure, and read all the files except two, the two
largest ones:

eric sur esquilin ~ % ls -l /media/cdrom/*/*
-r-xr-xr-x  1 root root   1315168 avr  6  2005 /media/cdrom/cdi/cdi_imag.rtf
-r-xr-xr-x  1 root root     13616 avr  6  2005 /media/cdrom/cdi/cdi_text.fnt
-r-xr-xr-x  1 root root    102400 avr  6  2005 /media/cdrom/cdi/cdi_vcd.app
-r-xr-xr-x  1 root root       193 avr  6  2005 /media/cdrom/cdi/cdi_vcd.cfg
-r-xr-xr-x  1 root root     65536 avr  6  2005 /media/cdrom/ext/lot_x.vcd
-r-xr-xr-x  1 root root        24 avr  6  2005 /media/cdrom/ext/psd_x.vcd
-r-xr-xr-x  1 root root      3606 avr  6  2005 /media/cdrom/ext/scandata.dat
-r-xr-xr-x  1 root root 192632832 avr  6  2005 /media/cdrom/mpegav/avseq01.dat
-r-xr-xr-x  1 root root      2048 avr  6  2005 /media/cdrom/vcd/entries.vcd
-r-xr-xr-x  1 root root      2048 avr  6  2005 /media/cdrom/vcd/info.vcd
-r-xr-xr-x  1 root root     65536 avr  6  2005 /media/cdrom/vcd/lot.vcd
-r-xr-xr-x  1 root root        24 avr  6  2005 /media/cdrom/vcd/psd.vcd

eric sur esquilin ~ % md5sum /media/cdrom/*/*
md5sum: /media/cdrom/cdi/cdi_imag.rtf: Erreur d'entrée/sortie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
0ce73ce9f0954193b1e406f194ae7935  /media/cdrom/cdi/cdi_text.fnt
acd74f592e10c130b1e16fb6987062bc  /media/cdrom/cdi/cdi_vcd.app
15b32fe29124c25c7218f350b9520e29  /media/cdrom/cdi/cdi_vcd.cfg
47ee5405eb0879a36aea7d5a420d9f3a  /media/cdrom/ext/lot_x.vcd
b6219264a400936865906b925c33dcd6  /media/cdrom/ext/psd_x.vcd
c3278fbe658bf842e14ff2f33967b064  /media/cdrom/ext/scandata.dat
md5sum: /media/cdrom/mpegav/avseq01.dat: Erreur d'entrée/sortie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
44f826b52e69fdd0398b05f06ef2ce62  /media/cdrom/vcd/entries.vcd
227a64758dcd545157873494b5cd7d8f  /media/cdrom/vcd/info.vcd
47ee5405eb0879a36aea7d5a420d9f3a  /media/cdrom/vcd/lot.vcd
b6219264a400936865906b925c33dcd6  /media/cdrom/vcd/psd.vcd


I have error messages in my logs:
on computer #1, they look like:
|hdc: command error: status=0x51 { DriveReady SeekComplete Error }
|hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
|ide: failed opcode was: unknown
|end_request: I/O error, dev hdc, sector 5008
|Buffer I/O error on device hdc, logical block 1252
on computer #2, they are simpler:
|end_request: I/O error, dev sr0, sector 5008
|Buffer I/O error on device sr0, logical block 1252

On both computers, I have the errors on the same sectors/blocks.

For the two offending files, the errors already occur on the beginings of
the files.

Of course, all of this point to a defective CD, except that on both
computers, I can read the files without any problem with windows XP
(well, actually, I have only read avseq01.dat, which is a video file. I
haven't tried the other troublesome file.)

What could be the problem ?

Éric
