Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbUKLVxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUKLVxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUKLVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:51:27 -0500
Received: from mms3.broadcom.com ([63.70.210.38]:16403 "EHLO mms3.broadcom.com")
	by vger.kernel.org with ESMTP id S262632AbUKLVtm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:49:42 -0500
X-Server-Uuid: 062D48FB-9769-4139-967C-478C67B5F9C9
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Fri, 12 Nov 2004 13:49:18 -0800
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3C9D@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTI+fGdqpUFp6tLQ2WKk7FB6UY/cgABIlww
From: "Michael Chan" <mchan@broadcom.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-WSS-ID: 6D8BF0551TG2713095-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, 13:55:09 -0700, Grant Grundler wrote:

> Yes. I found it on page 5 of PciEx_ECN_MMCONFIG_040217.pdf. 
> AFAICT, this section only applies to "systems that implement 
> a processor-architecture-specific firmware interface 
> standard". e.g. ia64 SAL calls.
> 

Hi Grant,

I disagree with your interpretations of the ECN. Here's my
interpretations:

1. PC-compatible systems or systems that do not implement a
processor-architecture-specific firmware interface must implement
mmconfig as specified in the ECN.

2. mmconfig implementation must provide a method for software to
guarantee that the config access has completed before software execution
continues. In Implementation Note, it provides some examples on how to
do this. One example is to make mmconfig non-posted. But there are other
examples.

In short, I believe mmconfig is allowed to be posted or non-posted. If
it is posted, there must be a method to allow software to flush it.

Michael


