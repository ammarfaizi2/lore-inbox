Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVIVE2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVIVE2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVE2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:28:21 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:36121 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S965225AbVIVE2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:28:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
Date: Wed, 21 Sep 2005 21:28:20 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1D6A@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
Thread-Index: AcW/HnUE/TubLzDqSdmVxJyjuzsIJwADy5MA
From: "Andy Currid" <ACurrid@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2005 04:28:21.0002 (UTC) FILETIME=[10226EA0:01C5BF2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff

It fixes something if you apply the entire patch that I posted. I
changed the #defines for MCP55_SATA and MCP55_SATA2 in pci_ids.h.

The patch didn't appear word-wrapped in what I saw get reflected back to
me from LKML. Andrew Morton accepted it without comment.

Let me now if you want me to resubmit.

Thanks

Andy

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Wednesday, September 21, 2005 19:37
> To: Andy Currid
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2.6.14-rc1] Fix broken NVIDIA device ID in sata_nv
> 
> Andy Currid wrote:
> > Please apply this patch that corrects an NVIDIA SATA device ID in
> > 2.6.14-rc1.
> 
> > @@ -158,6 +158,8 @@ static struct pci_device_id nv_pci_tbl[]
> >  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
> >  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
> >  		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
> > +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
> > +		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
> >  	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> >  		PCI_ANY_ID, PCI_ANY_ID,
> >  		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
> 
> I am applying this patch, but note that it does not "fix" 
> anything.  It 
> simply adds a new PCI ID, for additional hardware support.
> 
> 	Jeff
> 
> 
> 
