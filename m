Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVLCBqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVLCBqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVLCBqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:46:49 -0500
Received: from mail.dvmed.net ([216.237.124.58]:50660 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751142AbVLCBqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:46:48 -0500
Message-ID: <4390F903.3040001@pobox.com>
Date: Fri, 02 Dec 2005 20:46:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       tom.l.nguyen@intel.com
Subject: Re: Status of PCI domain support?
References: <4390B752.90006@pobox.com> <20051202213811.GA3948@suse.de>
In-Reply-To: <20051202213811.GA3948@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Greg KH wrote: > On Fri, Dec 02, 2005 at 04:06:26PM
	-0500, Jeff Garzik wrote: > >>The lack of PCI domain support on x86-64
	prevents me from seeing the >>following devices on the PCI bus: >>
	>>61:04.0 RAID bus controller: Silicon Image, Inc. Adaptec AAR-1210SA
	SATA >>HostRAID Controller (rev 02) >>61:06.0 SCSI storage controller:
	LSI Logic / Symbios Logic 53c1030 PCI-X >>Fusion-MPT Dual Ultra320 SCSI
	(rev 07) >>61:06.1 SCSI storage controller: LSI Logic / Symbios Logic
	53c1030 PCI-X >>Fusion-MPT Dual Ultra320 SCSI (rev 07) >> >>I get the
	following errors, unless I disable the BIOS option 'ACPI bus
	>>segmentation', which is enabled by default (and will be enabled on
	most >>future machines): >> >>Dec 2 10:40:18 localhost kernel: ACPI:
	PCI Root Bridge [PCI1] (0001:40) >>Dec 2 10:40:18 localhost kernel:
	PCI: Multiple domains not supported >>Dec 2 10:40:18 localhost kernel:
	ACPI: PCI Root Bridge [PCI2] (0002:80) >>Dec 2 10:40:18 localhost
	kernel: PCI: Multiple domains not supported >> >>Full machine info was
	just posted in another message, subject >>"[2.6.15-rc4] oops in
	acpiphp". >> >>Is this a bug? Is this expected behavior (not
	implemented yet)? A >>jump-start on tracking this down would be
	appreciated. > > > Based on the logic in arch/i386/pci/acpi.c (which is
	shared with > x86-64), it's just not implemented yet at all. > > I
	don't know of anyone currently working on adding this support to this >
	code, does anyone else? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Dec 02, 2005 at 04:06:26PM -0500, Jeff Garzik wrote:
> 
>>The lack of PCI domain support on x86-64 prevents me from seeing the 
>>following devices on the PCI bus:
>>
>>61:04.0 RAID bus controller: Silicon Image, Inc. Adaptec AAR-1210SA SATA 
>>HostRAID Controller (rev 02)
>>61:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
>>Fusion-MPT Dual Ultra320 SCSI (rev 07)
>>61:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
>>Fusion-MPT Dual Ultra320 SCSI (rev 07)
>>
>>I get the following errors, unless I disable the BIOS option 'ACPI bus 
>>segmentation', which is enabled by default (and will be enabled on most 
>>future machines):
>>
>>Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI1] (0001:40)
>>Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported
>>Dec  2 10:40:18 localhost kernel: ACPI: PCI Root Bridge [PCI2] (0002:80)
>>Dec  2 10:40:18 localhost kernel: PCI: Multiple domains not supported
>>
>>Full machine info was just posted in another message, subject 
>>"[2.6.15-rc4] oops in acpiphp".
>>
>>Is this a bug?  Is this expected behavior (not implemented yet)?  A 
>>jump-start on tracking this down would be appreciated.
> 
> 
> Based on the logic in arch/i386/pci/acpi.c (which is shared with
> x86-64), it's just not implemented yet at all.
> 
> I don't know of anyone currently working on adding this support to this
> code, does anyone else?

Well, that's silly.  It should be implemented now.

	Jeff



