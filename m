Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUFQBfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUFQBfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUFQBfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:35:17 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:12049 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S264526AbUFQBfK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:35:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 18:35:08 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B6@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.7] new NVIDIA libata SATA driver
Thread-Index: AcRUCYmfmagUoC7nQC29WaNqQkOVsgAAO54g
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@pobox.com] 

> If silicon isn't available yet, let's just remove those PCI 
> IDs.  That way we can ensure that these are libata only, 
> without two drivers sharing the same PCI ids.

If that's the case, I'd rather the CK804 and MCP04 SATA device IDs be
added to sata_nv, since we want distributions to support these SATA
controllers when silicon does become available.

> > > Removing IDs from amd74xx.c is a bad idea,
> > > it breaks boot on systems already using these IDs.
> > 
> > I assume these systems will be able to boot using the libata 
> > subsystem. Is that a bad assumption?
> 
> They can, but consider a system that uses 2.6.7 (IDE driver) 
> then boots into 2.6.8 (libata driver):  the drives move from 
> /dev/hdX to /dev/sdX. That breaks stuff not using LABEL= in 
> bootloader config and fstab.

That's true.  I kinda chalk this up as an inevitable kernel upgrade
issue (they'll be getting support for NVIDIA SATA under libata with
eventual device hotplug support, at the cost of some system
reconfiguration).  Is there a good solution?
