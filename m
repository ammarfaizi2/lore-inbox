Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWCXTq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWCXTq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWCXTq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:46:57 -0500
Received: from keetweej.vanheusden.com ([213.84.46.114]:28545 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932648AbWCXTq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:46:57 -0500
Date: Fri, 24 Mar 2006 20:46:55 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: info@papouch.com, linux-kernel@vger.kernel.org, bryder@sgi.com
Subject: Papouch USB thermometer support
Message-ID: <20060324194655.GY4124@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Fri Mar 24 09:46:53 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch against 2.6.15 adds support for the www.Papouch.com
USB thermometer by adding the appropriate vendor and product id.


Signed off: Folkert van Heusden <folkert@vanheusden.com

diff -uNrbBd old/ftdi_sio.c new/ftdi_sio.c
--- old/ftdi_sio.c      2006-03-24 20:36:19.000000000 +0100
+++ new/ftdi_sio.c      2006-03-24 20:33:20.000000000 +0100
@@ -307,6 +307,7 @@


 static struct usb_device_id id_table_combined [] = {
+       { USB_DEVICE(PAPOUCHE_VENDOR, PAPOUCHE_THEM_PROD) },
        { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
        { USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
        { USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
diff -uNrbBd old/ftdi_sio.h new/ftdi_sio.h
--- old/ftdi_sio.h      2006-03-24 20:36:19.000000000 +0100
+++ new/ftdi_sio.h      2006-03-24 20:37:35.000000000 +0100
@@ -20,8 +20,13 @@
  * Philipp Gühring - pg@futureware.at - added the Device ID of the USB relais
  * from Rudolf Gugler
  *
+ * Folkert van Heusden - folkert@vanheusden.com - added the device id of the
+ * temperature sensor from www.papouch.com
  */

+#define PAPOUCHE_VENDOR 0x5050
+#define PAPOUCHE_THEM_PROD 0x0400
+
 #define FTDI_VID       0x0403  /* Vendor Id */
 #define FTDI_SIO_PID   0x8372  /* Product Id SIO application of 8U100AX  */
 #define FTDI_8U232AM_PID 0x6001 /* Similar device to SIO above */


Folkert van Heusden

-- 
www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
