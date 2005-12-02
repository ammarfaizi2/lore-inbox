Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVLBVGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVLBVGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVLBVGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:06:30 -0500
Received: from mail.dvmed.net ([216.237.124.58]:42979 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750782AbVLBVG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:06:29 -0500
Message-ID: <4390B752.90006@pobox.com>
Date: Fri, 02 Dec 2005 16:06:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Greg KH <gregkh@suse.de>, Matthew Wilcox <matthew@wil.cx>,
       Andi Kleen <ak@suse.de>, tom.l.nguyen@intel.com
Subject: Status of PCI domain support?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  The lack of PCI domain support on x86-64 prevents me
	from seeing the following devices on the PCI bus: 61:04.0 RAID bus
	controller: Silicon Image, Inc. Adaptec AAR-1210SA SATA HostRAID
	Controller (rev 02) 61:06.0 SCSI storage controller: LSI Logic /
	Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
	61:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030
	PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The lack of PCI domain support on x86-64 prevents me from seeing the 
following devices on the PCI bus:

61:04.0 RAID bus controller: Silicon Image, Inc. Adaptec AAR-1210SA SATA 
HostRAID Controller (rev 02)
61:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)
61:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)

I get the following errors, unless I disable the BIOS option 'ACPI bus 
segmentation', which is enabled by default (and will be enabled on most 
future machines):

Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI1] (0001:40)
Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported
Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI2] (0002:80)
Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported

Full machine info was just posted in another message, subject 
"[2.6.15-rc4] oops in acpiphp".

Is this a bug?  Is this expected behavior (not implemented yet)?  A 
jump-start on tracking this down would be appreciated.

	Jeff



