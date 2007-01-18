Return-Path: <linux-kernel-owner+w=401wt.eu-S932757AbXARX4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbXARX4g (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbXARX4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:56:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:44980 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbXARX4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:56:35 -0500
Date: Thu, 18 Jan 2007 17:56:33 -0600
To: Allexio Ju <allexio.ju@gmail.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Questions on PCI express AER support in HBA driver
Message-ID: <20070118235632.GA7860@austin.ibm.com>
References: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 11:46:21AM -0800, Allexio Ju wrote:
> Hi,
> 
> I've got some questions on supporting PCI Express AER in Linux HBA drivers.
> BTW, I'm developing SCSI HBA driver.
[...]

> What else does SCSI LLD driver need to changed?

There are several scsi controllers that handle pci error recovery.
For example, look at drivers/scsi/ipr.c, search for 
struct pci_error_handlers. The callback routines there deal
with reseting the driver after an error has been found.

I've posted patches in the past for the symbios driver;
I suppose it is time to clean them up and resubmit them
again; they are not in the kernel yet.

I recently posted patches for the Emulex lpfc fibre channel 
scsi card, google for the subject line
  "[PATCH] lpfc: add PCI error recovery support"

to see what the patch looks like.

All of this work was done on powerpc systems. I have only
a vague idea of how this works on PC-class Intel platforms.

--linas

