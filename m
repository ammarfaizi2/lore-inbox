Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267885AbUHEXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267885AbUHEXWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267924AbUHEXWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:22:52 -0400
Received: from mms2.broadcom.com ([63.70.210.59]:15624 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S267885AbUHEXWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:22:51 -0400
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: MMCONFIG violates pci power mgmt spec
Date: Thu, 5 Aug 2004 16:22:17 -0700
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3BBB@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: MMCONFIG violates pci power mgmt spec
thread-index: AcR7O6c6zKBHrKTrSLa52smZyNRZggAAXxvA
From: "Michael Chan" <mchan@broadcom.com>
To: "Andi Kleen" <ak@muc.de>
cc: linux-kernel@vger.kernel.org, "Steve Lindsay" <slindsay@broadcom.com>,
       "Marcus Calescibetta" <marcusc@broadcom.com>
X-WSS-ID: 6D0C1EA215C5119413-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > For example, if the device is transitioning into or out of 
> D3hot, the 
> > spec requires a delay of 10 msec before any accesses can be made to 
> > the device. The dummy read in pci_mmcfg_write violates the delay 
> > requirements even though pci_set_power_state has all the necessary 
> > delays.
> 
> Interesting. What happens? Hangs? 
> 

What happens depends on the system/chipset/bios. Sometimes we see an
NMI, sometimes nothing bad happens.

> 
> Reading is the official way to flush.
> 

The MMCONFIG ECN document from pcisig below gives a few examples on how
the mmconfig write can be flushed. The exact mechanism of course is
implemention specific.

http://www.pcisig.com/specifications/pciexpress/specifications

Michael

