Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWDKSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWDKSwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWDKSwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:52:43 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:57729 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750971AbWDKSwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:52:42 -0400
Date: Tue, 11 Apr 2006 15:52:41 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ftdi_sio: Adds support for iPlus device.
Message-ID: <20060411155241.72242b56@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.16; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Adds support in ftdi_sio usbserial driver for USB modems sold by
Plus GSM Company in Poland.

Signed-off-by: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>

---

 drivers/usb/serial/ftdi_sio.c |    1 +
 drivers/usb/serial/ftdi_sio.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

cdb05e70295196f5ab2f19c415239b6f1c3be764
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f3af81b..8a81e51 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -308,6 +308,7 @@ static struct ftdi_sio_quirk ftdi_HE_TIR
 
 static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_IPLUS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_ALT_PID) },
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 8da773c..d703b80 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -39,6 +39,9 @@
 /* www.thoughttechnology.com/ TT-USB provide with procomp use ftdi_sio */
 #define FTDI_TTUSB_PID 0xFF20 /* Product Id */
 
+/* iPlus device */
+#define FTDI_IPLUS_PID 0xD070 /* Product Id */
+
 /* www.crystalfontz.com devices - thanx for providing free devices for evaluation ! */
 /* they use the ftdi chipset for the USB interface and the vendor id is the same */
 #define FTDI_XF_632_PID 0xFC08	/* 632: 16x2 Character Display */
-- 
1.2.4

-- 
Luiz Fernando N. Capitulino
