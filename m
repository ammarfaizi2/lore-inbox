Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSE2WOB>; Wed, 29 May 2002 18:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSE2WOA>; Wed, 29 May 2002 18:14:00 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:46084 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315547AbSE2WOA>; Wed, 29 May 2002 18:14:00 -0400
Date: Thu, 30 May 2002 00:13:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.2.21 sparc] raid(-1|0) boot support lost in time?
Message-ID: <20020529221347.GA2591@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9 SMP
X-Architecture: sparc
X-Uptime: 2:47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I believe the following to have been forgotten about somehow.
Or is it omitted on purpose for some reason that I've missed?

T.


diff -urN linux-2.2.21.vanilla/arch/sparc/config.in linux-2.2.21/arch/sparc/config.in
--- linux-2.2.21.vanilla/arch/sparc/config.in	Sun Mar 25 18:37:30 2001
+++ linux-2.2.21/arch/sparc/config.in	Thu May 30 00:05:31 2002
@@ -93,6 +93,9 @@
   tristate '   RAID-1 (mirroring) mode' CONFIG_MD_MIRRORING
   tristate '   RAID-4/RAID-5 mode' CONFIG_MD_RAID5
 fi
+if [ "$CONFIG_MD_LINEAR" = "y" -o "$CONFIG_MD_STRIPED" = "y" ]; then
+  bool '      Boot support (linear, striped)' CONFIG_MD_BOOT
+fi
 
 tristate 'RAM disk support' CONFIG_BLK_DEV_RAM
 if [ "$CONFIG_BLK_DEV_RAM" = "y" -o "$CONFIG_BLK_DEV_RAM" = "m" ]; then
