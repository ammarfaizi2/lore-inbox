Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRCNAgd>; Tue, 13 Mar 2001 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131277AbRCNAgX>; Tue, 13 Mar 2001 19:36:23 -0500
Received: from nets5.rz.RWTH-Aachen.DE ([137.226.144.13]:36484 "EHLO
	nets5.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S131276AbRCNAgL>; Tue, 13 Mar 2001 19:36:11 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB Support for Casio QV Digital Still Cameras, kernel 2.4.2-ac20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: Harald Schreiber <harald@harald-schreiber.de>
Date: 14 Mar 2001 01:33:42 +0100
Message-ID: <m3vgpdur2x.fsf@harald-schreiber.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch adds USB support for the Casio QV series of
digital still cameras by adding an entry to the list of unusual
devices of the USB mass storage driver. The patch applies to
kernel 2.4.2-ac20.

--- linux-2.4.2-ac20-vanilla/drivers/usb/storage/unusual_devs.h	Wed Mar 14 01:04:39 2001
+++ linux-2.4.2-ac20/drivers/usb/storage/unusual_devs.h	Tue Mar 13 19:53:01 2001
@@ -241,3 +241,9 @@
 		US_FL_START_STOP ),
 #endif
 
+UNUSUAL_DEV( 0x07cf, 0x1001, 0x9009, 0x9009,
+                "Casio",
+                "QV DigitalCamera",
+                US_SC_8070, US_PR_CB, NULL,
+                US_FL_FIX_INQUIRY ),
+


-- 
-------------------------------------------------------------------
Dipl.-Math. Harald Schreiber, Nizzaalle 26, D-52072 Aachen, Germany
Phone/Fax: +49-241-9108015/6      mailto:harald@harald-schreiber.de
-------------------------------------------------------------------
