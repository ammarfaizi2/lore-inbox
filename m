Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVFHIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVFHIYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFHIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:24:12 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:52135 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262141AbVFHIYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:24:06 -0400
Message-ID: <42A6AB1B.8000800@a-wing.co.uk>
Date: Wed, 08 Jun 2005 09:23:55 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sis5513.c patch
References: <42A621BC.7040607@a-wing.co.uk> <58cb370e05060800276f3fc29c@mail.gmail.com>
In-Reply-To: <58cb370e05060800276f3fc29c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> 
>>Hi,
> 
> 
> Hi,
> 

Hi again,

> 
>>I'm not sure if a similar patch has been submitted or not, but here is a
>>patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
>>chipset combo.
> 
> 
> This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID 
> is common for almost all SiS IDE controllers and is already present in 
> sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver 
> will try to use ATA_133 on all _unknown_ IDE controllers.  You need
> to add PCI ID of the Host chipset (lspci should reveal it) instead.

Unless I am reading the following wrong 5513 is the PCI ID:

00:02.5 Class 0101: 1039:5513 (rev 01) (prog-if 80 [Master])
	Subsystem: 1043:8139
	Flags: bus master, medium devsel, latency 128
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]
	Capabilities: [58] Power Management version 2

> 
> Thanks,
> Bartlomiej

Regards
Andrew
-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 424: operation failed because: there is no message for this 
error (#1014)
