Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVCVCNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVCVCNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVCVCNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:13:24 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62346 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262316AbVCVBew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:52 -0500
Message-Id: <20050322013456.473803000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:49 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttusbdec-ohci-compat.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 16/48] ttusb_dec: use alternative interface to save bandwidth
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use alternative interface.  Asks for less bandwidth and therefore works with
OHCI as well as UHCI (Alex Woods)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 ttusb_dec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-22 00:15:50.000000000 +0100
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(output_pva, "Output PVA
 
 #define ISO_BUF_COUNT		0x04
 #define FRAMES_PER_ISO_BUF	0x04
-#define ISO_FRAME_SIZE		0x03FF
+#define ISO_FRAME_SIZE		0x0380
 
 #define	MAX_PVA_LENGTH		6144
 
@@ -781,7 +781,7 @@ static int ttusb_dec_set_interface(struc
 							b, NULL, NULL);
 			if (result)
 				return result;
-			result = usb_set_interface(dec->udev, 0, 7);
+			result = usb_set_interface(dec->udev, 0, 8);
 			break;
 		case TTUSB_DEC_INTERFACE_OUT:
 			result = usb_set_interface(dec->udev, 0, 1);

--

