Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbQLRM3q>; Mon, 18 Dec 2000 07:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbQLRM3h>; Mon, 18 Dec 2000 07:29:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25619 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129480AbQLRM3a>; Mon, 18 Dec 2000 07:29:30 -0500
Subject: Re: 2.4.0-test13-pre3: Makefile problem in drivers/video
To: nbreun@gmx.de
Date: Mon, 18 Dec 2000 12:01:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, peter@cadcamlab.org (Peter Samuelson),
        djurfeldt@nada.kth.se (Mikael Djurfeldt)
In-Reply-To: <00121808022301.00937@nmb> from "Norbert Breun" at Dec 18, 2000 08:02:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147yz1-0005Ss-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you may be right there is no module "video.o". The problem is, there should 
> be a directory "media" under /lib/modules/2.4.0-test12.old/kernel/drivers/ 
> and this is missing in test13pre2 and test13pre3. The modules are not built.

Its a small makefile error again. The directories are not listed as containing
modules. Fix that and they are happy.

--- drivers/media/Makefile~	Sun Dec 17 21:28:20 2000
+++ drivers/media/Makefile	Mon Dec 18 10:59:25 2000
@@ -10,6 +10,7 @@
 #
 
 subdir-y     := video radio
+mod-subdirs  := video radio
 
 O_TARGET     := media.o
 obj-y        := $(join $(subdir-y),$(subdir-y:%=/%.o))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
