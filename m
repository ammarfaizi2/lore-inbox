Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVHDWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVHDWgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVHDWe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:34:28 -0400
Received: from fmr13.intel.com ([192.55.52.67]:9405 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262722AbVHDWeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:34:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] fix ACPI table discovery from EFI for x86
Date: Thu, 4 Aug 2005 15:34:10 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00A9F04AD@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] fix ACPI table discovery from EFI for x86
thread-index: AcWZQfcj/hYMKzr4QUuIdFARAztOUwAAXeEQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 04 Aug 2005 22:34:13.0585 (UTC) FILETIME=[A3DBE410:01C59944]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <> wrote:
> On Wednesday 13 July 2005 7:09 pm, Matt Tolentino wrote:
>> This patch addresses a problem on x86 EFI systems with larger memory
>> configurations.  Up until now, we've relied on the fact that the
>> ACPI RSDT would reside somewhere in low memory that could be
>> permanently 
>> mapped in kernel address space - so __va() has been sufficient. 
>> However, 
>> on EFI systems, the RSDT is often anywhere in the lower 4GB of
>> physical 
>> address space.  So, we may need to remap it on x86 systems.
> 
> The hunk below breaks HP rx7620, rx8620, and Superdome (all ia64)
> systems.  This is from 2.6.13-rc4-mm1, in

Ugh.  Well, that's pretty ugly...

Andrew, Len, please drop this one until I look at this closer.  

>     acpi-fix-table-discovery-from-efi-for-x86.patch

Thanks for testing Bjorn.  

matt 

 
