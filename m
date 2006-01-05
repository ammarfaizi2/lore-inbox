Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWAETHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWAETHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWAETHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:07:36 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:18050 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750982AbWAETHg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:07:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ipw2200] add monitor and qos entries to Kconfig
Date: Thu, 5 Jan 2006 13:07:32 -0600
Message-ID: <F265D57E1F28274EA189ED0566D227DE8B4666@PGJEXC01.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ipw2200] add monitor and qos entries to Kconfig
Thread-Index: AcYSJ7Lqlb8ImIFJTSy364AHfZE3GAAAsi8g
From: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
To: "Andreas Happe" <andreashappe@snikt.net>, <jketreno@linux.intel.com>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jan 2006 19:07:35.0272 (UTC) FILETIME=[4980F680:01C6122B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I believe that people had decided not to incorporate this
feature. Basically the IPW2200 will get too many firmware restarts on
rfmon, making the feature unusable. I don't think we want this option at
all so far. (Until there's a valid fix for the problem)

Alejandro Bonilla

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org 
|[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andreas Happe
|Sent: Thursday, January 05, 2006 12:40 PM
|To: jketreno@linux.intel.com
|Cc: jgarzik@pobox.com; linux-kernel@vger.kernel.org
|Subject: Re: [ipw2200] add monitor and qos entries to Kconfig
|
|I have made a stupid copy&paste error: QoS option is named IPW_QOS not 
|IPW2200_MONITOR. Spotted by Daniel Paschka, thanks.
|
|Add the following config entries for the ipw2200 driver to 
|drivers/net/wireless/Kconfig
| * IPW2200_MONITOR
|   enables Monitor mode
| * IPW_QOS
|   enables QoS feature - this is under development right now, 
|so it depends 
|upon EXPERIMENTAL
|
|Signed-off-by: Andreas Happe <andreashappe@snikt.net>
|--- drivers/net/wireless/Kconfig.orig	2006-01-05 
|18:30:10.000000000 +0100
|+++ drivers/net/wireless/Kconfig	2006-01-05 
|18:30:13.000000000 +0100
|@@ -217,6 +217,19 @@ config IPW2200
|           say M here and read 
|<file:Documentation/modules.txt>.  The module
|           will be called ipw2200.ko.
| 
|+config IPW2200_MONITOR
|+        bool "Enable promiscuous mode"
|+        depends on IPW2200
|+        ---help---
|+	  Enables promiscuous/monitor mode support for the 
|ipw2200 driver.
|+	  With this feature compiled into the driver, you can switch to 
|+	  promiscuous mode via the Wireless Tool's Monitor 
|mode.  While in this
|+	  mode, no packets can be sent.
|+
|+config IPW_QOS
|+        bool "Enable QoS support"
|+        depends on IPW2200 && EXPERIMENTAL
|+
| config IPW_DEBUG
| 	bool "Enable full debugging output in IPW2200 module."
| 	depends on IPW2200
|-
|To unsubscribe from this list: send the line "unsubscribe 
|linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/
|
