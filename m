Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758359AbWK2WM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbWK2WM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758380AbWK2WM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:12:26 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:33179 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1758352AbWK2WMZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:12:25 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: PCI: check szhi when sz is 0 when 64 bit iomem bigger than
 4G
Date: Wed, 29 Nov 2006 14:08:50 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907254@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI: check szhi when sz is 0 when 64 bit iomem bigger than
 4G
Thread-Index: AccUAM2i9dAkAT41TdOsAZN69urr4AAAOUlw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: "Greg KH" <greg@kroah.com>, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       myles@mouselemur.cs.byu.edu
X-OriginalArrivalTime: 29 Nov 2006 22:08:51.0929 (UTC)
 FILETIME=[F3FD1C90:01C71402]
X-WSS-ID: 6970DB740T01732106-11-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, November 29, 2006 1:53 PM

>It has no changelog.  We're still waiting for a complete description of
the
>patch: why it is needed, what it does, how it does it.  Please provide
>that.

-----------------
For pci mem resource that size is bigger than 4G, the sz returned by
pc_size will be 0.
So that resource is skipped, and register contained hi address will be
treated as another 32bit
resource. We need to use sz64 and pci_sz64 for 64 bit resource for clear
logical.
Typical usages for this: Opteron system with co-processor and the
co-processor could take
more than 4G RAM as pre-fetchable mem resource.
-----------------

YH


