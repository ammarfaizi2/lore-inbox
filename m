Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVAHGhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVAHGhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVAHGg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:36:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:17030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261930AbVAHFsr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:47 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632671745@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <1105163268703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.37, 2004/12/17 15:41:32-08:00, greg@kroah.com

[PATCH] USB: fix up some sparse warnings in the new garmin_gps driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/garmin_gps.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff -Nru a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
--- a/drivers/usb/serial/garmin_gps.c	2005-01-07 15:44:39 -08:00
+++ b/drivers/usb/serial/garmin_gps.c	2005-01-07 15:44:39 -08:00
@@ -343,7 +343,7 @@
 static struct garmin_packet *pkt_pop(struct garmin_data * garmin_data_p)
 {
 	unsigned long flags;
-	struct garmin_packet *result = 0;
+	struct garmin_packet *result = NULL;
 
 	spin_lock_irqsave(&garmin_data_p->lock, flags);
 	if (!list_empty(&garmin_data_p->pktlist)) {
@@ -359,7 +359,7 @@
 static void pkt_clear(struct garmin_data * garmin_data_p)
 {
 	unsigned long flags;
-	struct garmin_packet *result = 0;
+	struct garmin_packet *result = NULL;
 
 	dbg("%s", __FUNCTION__);
 
@@ -737,10 +737,9 @@
  */
 static void gsp_next_packet(struct garmin_data * garmin_data_p)
 {
-	struct garmin_packet *pkt = 0;
+	struct garmin_packet *pkt = NULL;
 
-	while ((pkt = pkt_pop(garmin_data_p)) != 0)
-	{
+	while ((pkt = pkt_pop(garmin_data_p)) != 0) {
 		dbg("%s - next pkt: %d", __FUNCTION__, pkt->seq);
 		if (gsp_send(garmin_data_p, pkt->data, pkt->size) > 0) {
 			kfree(pkt);
@@ -1428,7 +1427,7 @@
 {
 	int status = 0;
 	struct usb_serial_port *port = serial->port[0];
-	struct garmin_data * garmin_data_p = 0;
+	struct garmin_data * garmin_data_p = NULL;
 
 	dbg("%s", __FUNCTION__);
 

