Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGBCG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGBCG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGBCD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:03:28 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:16364 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261692AbVGBBz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:26 -0400
Message-Id: <20050702015619.011731000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:11 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-pci-name-fix.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 5/8] usb/pci: correct syntax of driver name fields
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Change the name-field of the pci_driver and usb_driver structs to the name of
the module after compilation. It seems that this field is used in some places
where special characters are not allowed.
Thanks to Alan Halverson for finding this problem.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/b2c2/flexcop-pci.c    |    2 +-
 drivers/media/dvb/b2c2/flexcop-usb.c    |    2 +-
 drivers/media/dvb/dvb-usb/a800.c        |    2 +-
 drivers/media/dvb/dvb-usb/cxusb.c       |    2 +-
 drivers/media/dvb/dvb-usb/dibusb-mb.c   |    2 +-
 drivers/media/dvb/dvb-usb/dibusb-mc.c   |    2 +-
 drivers/media/dvb/dvb-usb/digitv.c      |    2 +-
 drivers/media/dvb/dvb-usb/nova-t-usb2.c |    2 +-
 drivers/media/dvb/dvb-usb/umt-010.c     |    2 +-
 drivers/media/dvb/dvb-usb/vp7045.c      |    6 +++---
 10 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/b2c2/flexcop-pci.c	2005-07-02 03:22:30.000000000 +0200
@@ -409,7 +409,7 @@ static struct pci_device_id flexcop_pci_
 MODULE_DEVICE_TABLE(pci, flexcop_pci_tbl);
 
 static struct pci_driver flexcop_pci_driver = {
-	.name     = "Technisat/B2C2 FlexCop II/IIb PCI",
+	.name     = "b2c2_flexcop_pci",
 	.id_table = flexcop_pci_tbl,
 	.probe    = flexcop_pci_probe,
 	.remove   = flexcop_pci_remove,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/b2c2/flexcop-usb.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/b2c2/flexcop-usb.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/b2c2/flexcop-usb.c	2005-07-02 03:22:30.000000000 +0200
@@ -545,7 +545,7 @@ static struct usb_device_id flexcop_usb_
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver flexcop_usb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "Technisat/B2C2 FlexCop II/IIb/III USB",
+	.name		= "b2c2_flexcop_usb",
 	.probe		= flexcop_usb_probe,
 	.disconnect = flexcop_usb_disconnect,
 	.id_table	= flexcop_usb_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/a800.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/a800.c	2005-07-02 03:22:25.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/a800.c	2005-07-02 03:22:30.000000000 +0200
@@ -149,7 +149,7 @@ static struct dvb_usb_properties a800_pr
 
 static struct usb_driver a800_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "AVerMedia AverTV DVB-T USB 2.0 (A800)",
+	.name		= "dvb_usb_a800",
 	.probe		= a800_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= a800_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/cxusb.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/cxusb.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/cxusb.c	2005-07-02 03:22:30.000000000 +0200
@@ -262,7 +262,7 @@ static struct dvb_usb_properties cxusb_p
 
 static struct usb_driver cxusb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "cxusb",
+	.name		= "dvb_usb_cxusb",
 	.probe		= cxusb_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= cxusb_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-07-02 03:22:30.000000000 +0200
@@ -317,7 +317,7 @@ static struct dvb_usb_properties dibusb2
 
 static struct usb_driver dibusb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "DiBcom based USB DVB-T devices (DiB3000M-B based)",
+	.name		= "dvb_usb_dibusb_mb",
 	.probe		= dibusb_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= dibusb_dib3000mb_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dibusb-mc.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dibusb-mc.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dibusb-mc.c	2005-07-02 03:22:30.000000000 +0200
@@ -83,7 +83,7 @@ static struct dvb_usb_properties dibusb_
 
 static struct usb_driver dibusb_mc_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "DiBcom based USB2.0 DVB-T (DiB3000M-C/P based) devices",
+	.name		= "dvb_usb_dibusb_mc",
 	.probe		= dibusb_mc_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= dibusb_dib3000mc_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/digitv.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/digitv.c	2005-07-02 03:22:30.000000000 +0200
@@ -228,7 +228,7 @@ static struct dvb_usb_properties digitv_
 
 static struct usb_driver digitv_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "Nebula Electronics uDigiTV DVB-T USB2.0 device",
+	.name		= "dvb_usb_digitv",
 	.probe		= digitv_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= digitv_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/nova-t-usb2.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/nova-t-usb2.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/nova-t-usb2.c	2005-07-02 03:22:30.000000000 +0200
@@ -203,7 +203,7 @@ static struct dvb_usb_properties nova_t_
 
 static struct usb_driver nova_t_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "Hauppauge WinTV-NOVA-T usb2",
+	.name		= "dvb_usb_nova_t_usb2",
 	.probe		= nova_t_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= nova_t_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/umt-010.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/umt-010.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/umt-010.c	2005-07-02 03:22:30.000000000 +0200
@@ -129,7 +129,7 @@ static struct dvb_usb_properties umt_pro
 
 static struct usb_driver umt_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "HanfTek UMT-010 USB2.0 DVB-T devices",
+	.name		= "dvb_usb_umt_010",
 	.probe		= umt_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table	= umt_table,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/vp7045.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/vp7045.c	2005-07-02 03:22:30.000000000 +0200
@@ -44,7 +44,7 @@ int vp7045_usb_op(struct dvb_usb_device 
 	if (usb_control_msg(d->udev,
 			usb_sndctrlpipe(d->udev,0),
 			TH_COMMAND_OUT, USB_TYPE_VENDOR | USB_DIR_OUT, 0, 0,
-			outbuf, 20, 2*HZ) != 20) {
+			outbuf, 20, 2000) != 20) {
 		err("USB control message 'out' went wrong.");
 		ret = -EIO;
 		goto unlock;
@@ -55,7 +55,7 @@ int vp7045_usb_op(struct dvb_usb_device 
 	if (usb_control_msg(d->udev,
 			usb_rcvctrlpipe(d->udev,0),
 			TH_COMMAND_IN, USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
-			inbuf, 12, 2*HZ) != 12) {
+			inbuf, 12, 2000) != 12) {
 		err("USB control message 'in' went wrong.");
 		ret = -EIO;
 		goto unlock;
@@ -255,7 +255,7 @@ static struct dvb_usb_properties vp7045_
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver vp7045_usb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "dvb-usb-vp7045",
+	.name		= "dvb_usb_vp7045",
 	.probe 		= vp7045_usb_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table 	= vp7045_usb_table,

--

