Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWAITaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAITaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWAITaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:30:23 -0500
Received: from amdext4.amd.com ([163.181.251.6]:46988 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751252AbWAITaW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:30:22 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 11:29:43 -0800
Message-ID: <6F7DA19D05F3CF40B890C7CA2DB13A42030949D0@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] add x86-64 support for memory hot-add
Thread-Index: AcYVUo1T2TLm6sjOTraSQJ7/PXzP6gAAGiAg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "keith" <kmannth@us.ibm.com>
cc: "Andi Kleen" <ak@suse.de>, "Matt Tolentino" <metolent@cs.vt.edu>,
       akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 09 Jan 2006 19:29:44.0663 (UTC)
 FILETIME=[0B88EE70:01C61553]
X-WSS-ID: 6FDC66223982737129-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean use acpi run-time asl code to update these reg?

YH

-----Original Message-----
From: keith [mailto:kmannth@us.ibm.com] 
Sent: Monday, January 09, 2006 11:25 AM
To: Lu, Yinghai
Cc: Andi Kleen; Matt Tolentino; akpm@osdl.org; discuss@x86-64.org;
linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add

On Mon, 2006-01-09 at 10:51 -0800, Yinghai Lu wrote:
> for Opteron NUMA, need to update
> 0. stop the DCT on the node that will plug the new DIMM
> 1. read spd_rom for the added dimm
> 2. init the ram size and update the memory routing table...
> 3. init the timing...
> 4. update relate info in TOM and TOM2, and MTRR, and e820
> 
> It looks like we need to get some code about ram init from
LinuxBIOS.....

Is the AMD box not going to use the ACPI add-memory mechanism?


-- 
keith <kmannth@us.ibm.com>



