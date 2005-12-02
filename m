Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLBVid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLBVid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLBVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:38:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:31905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750760AbVLBVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:38:32 -0500
Date: Fri, 2 Dec 2005 13:38:11 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       tom.l.nguyen@intel.com
Subject: Re: Status of PCI domain support?
Message-ID: <20051202213811.GA3948@suse.de>
References: <4390B752.90006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4390B752.90006@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 04:06:26PM -0500, Jeff Garzik wrote:
> 
> The lack of PCI domain support on x86-64 prevents me from seeing the 
> following devices on the PCI bus:
> 
> 61:04.0 RAID bus controller: Silicon Image, Inc. Adaptec AAR-1210SA SATA 
> HostRAID Controller (rev 02)
> 61:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
> Fusion-MPT Dual Ultra320 SCSI (rev 07)
> 61:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
> Fusion-MPT Dual Ultra320 SCSI (rev 07)
> 
> I get the following errors, unless I disable the BIOS option 'ACPI bus 
> segmentation', which is enabled by default (and will be enabled on most 
> future machines):
> 
> Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI1] (0001:40)
> Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported
> Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI2] (0002:80)
> Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported
> 
> Full machine info was just posted in another message, subject 
> "[2.6.15-rc4] oops in acpiphp".
> 
> Is this a bug?  Is this expected behavior (not implemented yet)?  A 
> jump-start on tracking this down would be appreciated.

Based on the logic in arch/i386/pci/acpi.c (which is shared with
x86-64), it's just not implemented yet at all.

I don't know of anyone currently working on adding this support to this
code, does anyone else?

thanks,

greg k-h
