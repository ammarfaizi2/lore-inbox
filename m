Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUFQB3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUFQB3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUFQB3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:29:02 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:43016 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264522AbUFQB26 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:28:58 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 18:28:47 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B5@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.7] new NVIDIA libata SATA driver
Thread-Index: AcRUCT6xRyDNbGYVSLWT3mqyo5dHHAAALJJQ
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 17, 2004 at 03:12:42AM +0200, Bartlomiej 
> Zolnierkiewicz wrote:
> > Removing IDs from amd74xx.c is a bad idea,
> > it breaks boot on systems already using these IDs.

> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> (FWIW for Andrew)
> 
> I'm going to apply Andrew's patch, but without the PCI id removals.
> 
> Then, I'll apply a patch that adds Kconfig questions
> 
> 	Include hardware that conflicts with libata SATA driver?
> 	(in drivers/ide)
> and
> 	Include hardware that conflicts with IDE driver?
> 	(in libata, drivers/scsi)
> 
> and apply the associated ifdefs to the low-level drivers.
> 
> This is necessary to both enable conflict prevention, and 
> also make sure we don't break existing setups in the move to 
> libata for SATA stuff.

So the amd74xx driver won't be able to coexist with the sata_nv driver?
If the sata_nv driver is used (and amd74xx is not), then there won't be
a driver controlling the NVIDIA IDE controllers.
