Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKRPCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKRPCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKRPCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:02:31 -0500
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:7440 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1750772AbVKRPCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:02:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: bug in drivers/pci/hotplug/ibmphp_pci.c
Date: Fri, 18 Nov 2005 09:58:50 -0500
Message-ID: <5E735516D527134997ABD465886BBDA61ABFA7@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: bug in drivers/pci/hotplug/ibmphp_pci.c
Thread-Index: AcXsUJYN1wzRPMxXQzSbdCk2ifNqXA==
From: "Jordan, William P" <William.Jordan@unisys.com>
To: <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2005 14:58:51.0820 (UTC) FILETIME=[969AE6C0:01C5EC50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed what appears to be a cut/paste error in
drivers/pci/hotplug/ibmphp_pci.c:

***************
*** 969,975 ****
  			debug ("io 32\n");
  			need_io_upper = TRUE;
  		}
! 		if ((io_base & PCI_PREF_RANGE_TYPE_MASK) ==
PCI_PREF_RANGE_TYPE_64) {
  			debug ("pfmem 64\n");
  			need_pfmem_upper = TRUE;
  		}
--- 969,975 ----
  			debug ("io 32\n");
  			need_io_upper = TRUE;
  		}
! 		if ((pfmem_base & PCI_PREF_RANGE_TYPE_MASK) ==
PCI_PREF_RANGE_TYPE_64) {
  			debug ("pfmem 64\n");
  			need_pfmem_upper = TRUE;
  		}

I've verified that the bug still exists in 2.6.15-rc1

Bill Jordan
Unisys Corporation
