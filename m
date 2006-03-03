Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWCCV1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWCCV1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWCCV1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:27:55 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:30523 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1750904AbWCCV1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:27:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Fri, 3 Mar 2006 13:27:00 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48CCB0@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Thread-Index: AcY+sk7qsRHy15uzTYWldIVT+A2aDAAVTTjQ
From: "Allen Martin" <AMartin@nvidia.com>
To: "Andi Kleen" <ak@suse.de>, "Chris Wedgwood" <cw@f00f.org>
Cc: "Michael Monnerie" <m.monnerie@zmi.at>, <linux-kernel@vger.kernel.org>,
       <suse-linux-e@suse.com>
X-OriginalArrivalTime: 03 Mar 2006 21:27:02.0146 (UTC) FILETIME=[36185E20:01C63F09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, Mar 02, 2006 at 02:03:48AM +0100, Andi Kleen wrote:
> > 
> > > Nvidia hardware SATA cannot directly DMA to > 4GB, so it has to go
> > > through the IOMMU.
> > 
> > do you know if that is an actual hardware limitation or simply a
> > something we don't know how to do for lack of docs?
> 
> I assume that's a hardware limitation. I guess they'll move to AHCI
> at some point though - that should fix that.

nForce4 has 64 bit (40 bit AMD64) DMA in the SATA controller.  We gave
the docs to Jeff Garzik under NDA.  He posted some non functional driver
code to linux-ide earlier this week that has the 64 bit registers and
structures although it doesn't make use of them.  Someone could pick
this up if they wanted to work on it though.

-Allen
