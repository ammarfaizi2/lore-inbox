Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWFMPls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFMPls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWFMPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:41:48 -0400
Received: from ns.sick.de ([62.180.123.243]:12813 "EHLO csmailwak.sick.de")
	by vger.kernel.org with ESMTP id S932148AbWFMPlr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:41:47 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] com20020_cs, kernel 2.6.17-rc6
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OF865DF58A.2630C431-ONC125718C.0054E44A-C125718C.00563612@sick.de>
From: Marc Sowen <Marc.Sowen@ibeo-as.de>
Date: Tue, 13 Jun 2006 17:40:45 +0200
X-MIMETrack: Serialize by Router on IBAMF01.iba.de.internal/SRV/SICK(Release 6.5.4|March
 27, 2005) at 06/13/2006 05:40:46 PM,
	Serialize complete at 06/13/2006 05:40:46 PM
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

this patch enables the com20020_cs arcnet driver to see the SoHard (now 
Mercury Computer Systems Inc.) SH ARC-PCMCIA card. I haven't tested it 
thoroughly yet, though. Hopefully, Lotus Notes doesn't screw up this 
patch. Otherwise I will try to send it at home with my private email 
account.

Marc

--- a/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-06 
02:57:02.000000000 +0200
+++ b/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-13 
17:10:03.000000000 +0200
@@ -388,6 +388,7 @@

 static struct pcmcia_device_id com20020_ids[] = {
        PCMCIA_DEVICE_PROD_ID12("Contemporary Control Systems, Inc.", 
"PCM20 Arcnet Adapter", 0x59991666, 0x95dfffaf),
+       PCMCIA_DEVICE_PROD_ID12("SoHard AG", "SH ARC PCMCIA", 0xf8991729, 
0x69dff0c7),
        PCMCIA_DEVICE_NULL
 };
 MODULE_DEVICE_TABLE(pcmcia, com20020_ids);

-- 
Marc Sowen
Research Department

Ibeo Automobile Sensor GmbH
Fahrenkrön 125
22179 Hamburg, Germany

Phone: +49 (0)40 64587-224
Facsimile: +49 (0)40 64587-109

EMail: marc.sowen@ibeo-as.de
