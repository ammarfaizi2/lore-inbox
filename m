Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVLHOyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVLHOyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLHOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:54:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:2468 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932149AbVLHOyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:54:37 -0500
Subject: Re: [ACPI] Re: RFC: ACPI/scsi/libata integration and hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20051208144329.GA21946@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org>
	 <20051208091542.GA9538@infradead.org>
	 <20051208132657.GA21529@srcf.ucam.org>
	 <20051208133308.GA13267@infradead.org>
	 <20051208133945.GA21633@srcf.ucam.org>
	 <20051208135225.GA13122@havoc.gtf.org>
	 <1134050863.17102.5.camel@localhost.localdomain>
	 <43983FC6.6050108@pobox.com>
	 <1134052257.17102.13.camel@localhost.localdomain>
	 <20051208144329.GA21946@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Dec 2005 14:53:17 +0000
Message-Id: <1134053597.17102.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 14:43 +0000, Matthew Garrett wrote:
> ACPI methods belong to SATA/PATA targets, not PCI devices. The 
> notification you get is something of the form
> 
> \SB.PCI.IDE0.SEC.MASTER


That is fine. Given struct ata_port * you can get

channel = ap->hard_port_no
pci device ptr = to_pci(ap->host_set->dev)

And from the struct ata_device *

slave = (adev->devno == 1)


