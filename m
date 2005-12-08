Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLHOfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLHOfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVLHOfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:35:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17325 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932125AbVLHOfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:35:14 -0500
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <20051208141811.GB21715@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org>
	 <20051208091542.GA9538@infradead.org>
	 <20051208132657.GA21529@srcf.ucam.org>
	 <20051208133308.GA13267@infradead.org>
	 <20051208133945.GA21633@srcf.ucam.org>
	 <1134050498.17102.2.camel@localhost.localdomain>
	 <20051208141811.GB21715@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Dec 2005 14:33:53 +0000
Message-Id: <1134052433.17102.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 14:18 +0000, Matthew Garrett wrote:
> drivers/pci/pci-acpi.c), with struct device.firmware_data being where 
> the acpi_handle ends up. I guess there's no problem in moving my code 
> out to scsi-acpi.c and adding an arch_initcall for it. Would that be 
> more acceptable? The only problem then is working out a clean way of 
> setting up the notification structure.

I would say your code belongs in the ACPI subtree. At most the core code
wants to have the generic supporting functions for 'do a taskfile' and
if need be to call an arch/platform resume function that any pm system
can sensibly use.

SCSI should not know detail about ACPI, APM or anything of that nature.

Alan

