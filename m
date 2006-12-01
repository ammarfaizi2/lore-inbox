Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162064AbWLAWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162064AbWLAWLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162067AbWLAWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:11:16 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:57355 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1162064AbWLAWLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:11:14 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Date: Fri, 1 Dec 2006 14:10:59 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490727A@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug
 device
Thread-Index: AccVjfgUTl20DSl8Q3izf4UicUS88gABjKFw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>
cc: "Stefan Reinauer" <stepan@coresystems.de>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 01 Dec 2006 22:10:59.0971 (UTC)
 FILETIME=[95224530:01C71595]
X-WSS-ID: 696E77F91WC1910594-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Friday, December 01, 2006 1:15 PM

Peter Stuge <stuge-linuxbios@cdy.org> writes:

>> On Fri, Dec 01, 2006 at 11:19:16AM -0800, Greg KH wrote:
>>> Well, earlyprintk will not work, as you need PCI up and running.
>>
>> Not all of it though. LinuxBIOS will probably do just enough PCI
>> setup to talk to the EHCI controller and use the debug port _very_
>> soon after power on.

>Right.  For LinuxBIOS not a problem for earlyprintk in the kernel
>somethings might need to be refactored.  The challenge in the kernel
>is we don't know at build to how to do a pci_read_config...

early_pci_read_config?
Otherwise printk will come too late, and will not get output before pci
bus ops is set.

>The other hard part early in the kernel is the fact that the
>bar is memory mapped I/O.  Which means it will need to get mapped
>into the kernels page tables.

several entries to map 0xfc000000 ( PCI IO mem range) in page table in
head.S?

YH



