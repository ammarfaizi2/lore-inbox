Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315381AbSDWXHI>; Tue, 23 Apr 2002 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315382AbSDWXHH>; Tue, 23 Apr 2002 19:07:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20631 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315381AbSDWXHG>; Tue, 23 Apr 2002 19:07:06 -0400
Date: Tue, 23 Apr 2002 18:07:04 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- Build error -- scsidrv.o: In function `ahc_linux_halt':
 undefined reference to `ahc_tailq'
In-Reply-To: <1019529784.24480.14.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.LNX.4.44.0204231806090.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2002, Miles Lane wrote:

> drivers/scsi/scsidrv.o: In function `ahc_linux_halt':
> drivers/scsi/scsidrv.o(.text+0x78cd): undefined reference to `ahc_tailq'
> drivers/scsi/scsidrv.o(.text+0x78e2): undefined reference to
> `ahc_shutdown'
> drivers/scsi/scsidrv.o: In function `ahc_linux_detect':
> drivers/scsi/scsidrv.o(.text+0x7fb7): undefined reference to `ahc_tailq'
> drivers/scsi/scsidrv.o: In function `ahc_linux_register_host':
> drivers/scsi/scsidrv.o(.text+0x80c6): undefined reference to
> `ahc_set_unit'
> drivers/scsi/scsidrv.o(.text+0x8109): undefined reference to
> `ahc_set_name'

My bad, sorry.

--Kai

===== Makefile 1.6 vs edited =====
--- 1.6/drivers/scsi/aic7xxx/Makefile	Fri Apr 19 10:00:59 2002
+++ edited/Makefile	Tue Apr 23 18:05:48 2002
@@ -8,7 +8,7 @@
 obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx_mod.o
 
 # Core files
-aix7xxx_mod-objs	+= aic7xxx.o aic7xxx_93cx6.o aic7770.o
+aic7xxx_mod-objs	+= aic7xxx.o aic7xxx_93cx6.o aic7770.o
 
 # Platform Specific Files
 aic7xxx_mod-objs	+= aic7xxx_linux.o aic7xxx_proc.o aic7770_linux.o


