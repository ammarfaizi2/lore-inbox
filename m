Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHDNwN>; Sun, 4 Aug 2002 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHDNwN>; Sun, 4 Aug 2002 09:52:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34288 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315690AbSHDNwM>; Sun, 4 Aug 2002 09:52:12 -0400
Date: Sun, 4 Aug 2002 15:55:40 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30-dj1 (sort of)
In-Reply-To: <20020802171252.M25761@suse.de>
Message-ID: <Pine.NEB.4.44.0208041553410.1422-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the PCI_DEVICE_ID_AL_M1671_0 entry that is added by your patch needs the
following obvious fix to compile:

--- drivers/char/agp/agp.c.old	Sun Aug  4 15:52:02 2002
+++ drivers/char/agp/agp.c	Sun Aug  4 15:52:13 2002
@@ -818,7 +818,7 @@
 		.device_id	= PCI_DEVICE_ID_AL_M1671_0,
 		.vendor_id	= PCI_VENDOR_ID_AL,
 		.chipset	= ALI_M1671,
-		.vendor_name	= "Ali"
+		.vendor_name	= "Ali",
 		.chipset_name	= "M1671",
 		.chipset_setup	= ali_generic_setup,
 	},

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

