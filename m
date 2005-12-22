Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVLVP0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVLVP0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLVP0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:26:46 -0500
Received: from francis.fzi.de ([141.21.7.5]:54573 "EHLO francis.fzi.de")
	by vger.kernel.org with ESMTP id S1751109AbVLVP0p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:26:45 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: MPC5200 Cache issue with Bestcomm
Date: Thu, 22 Dec 2005 16:26:39 +0100
Message-ID: <EE3E34EBE104B24DA5DF5DBC1EA998D5287FED@loretta.fzi.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MPC5200 Cache issue with Bestcomm
Thread-Index: AcYHDBqSmsZlku8HSEOBuGNu4zoXwg==
From: "Amir Bukhari" <Bukhari@fzi.de>
To: <linux-kernel@vger.kernel.org>
X-Assp-Spam-Prob: 0.00000
X-Assp-Envelope-From: Bukhari@fzi.de
X-OriginalArrivalTime: 22 Dec 2005 15:26:44.0579 (UTC) FILETIME=[1DB12B30:01C6070C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this question is not related to linux kernel, but I can't find any
sources which I can find any tipps for the issue I encoured.
I write a standalone application with TCP stack (I use lwip stack). I am
want to enable the cache to increase performance of my application.

------------------------
Here is my configuration of various registers:

#define CORE_HID0_INIT                    0x8010C000
#define CORE_HID2_INIT                    0x00000000
#define CORE_IBAT0U_INIT                  0x000007FF
#define CORE_IBAT0L_INIT                  0x00000001

#define CORE_DBAT0U_INIT                  0x000007FF
#define CORE_DBAT0L_INIT                  0x00000052
#define CORE_DBAT1U_INIT                  0xF000000F  // for MBAR
#define CORE_DBAT1L_INIT                  0xF000002A  // for MBAR
#define CORE_DBAT2U_INIT                  0x40001FFF
#define CORE_DBAT2L_INIT                  0x40000022  // for PCI
#define CORE_DBAT3U_INIT                  0x50001FFF  //
#define CORE_DBAT3L_INIT                  0x50000022  //

XLARB configuration is :
#define XLARB_CONFIG_INIT                 0x8000A006 // snoop window is
enabled
#define XLARB_PRIORITY_ENABLE_INIT        0x0000000F
#define XLARB_PRIORITY_INIT               0x11111010
#define XLARB_SNOOP_WINDOW_INIT           0x00000019 // base address is 0
and 64Mbytes length

----------------

Now as soon as I enable cache the Bestcomm doesn't stop firing me a ethernet
packet receive. It doesn't stop this and this let my system hangs up. When
running the system without cache every thing work well.

I will be happy if someone can give me a tipp if I may missed something!

-Amir
