Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbUKRWQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUKRWQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbUKRWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:15:48 -0500
Received: from fmr11.intel.com ([192.55.52.31]:56294 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262990AbUKRWMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:12:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: e820 and shared VGA memory problem
Date: Thu, 18 Nov 2004 14:11:44 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600360C70D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e820 and shared VGA memory problem
Thread-Index: AcTNuiJ/qRWudVE8QyqVIPuss+egZAAAIHogAAAs96A=
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Magnus Damm" <magnus.damm@gmail.com>, "Dave Jones" <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2004 22:11:44.0941 (UTC) FILETIME=[9703E5D0:01C4CDBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Pallipadi, Venkatesh 
>Sent: Thursday, November 18, 2004 2:09 PM
>To: 'Magnus Damm'; Dave Jones; linux-kernel@vger.kernel.org
>Subject: RE: e820 and shared VGA memory problem
>
> 
>
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Magnus Damm
>>Sent: Thursday, November 18, 2004 1:50 PM
>>To: Dave Jones; Magnus Damm; linux-kernel@vger.kernel.org
>>Subject: Re: e820 and shared VGA memory problem
>>
>>On Thu, 18 Nov 2004 16:44:31 -0500, Dave Jones 
>><davej@redhat.com> wrote:
>>> In the past such problems have been attributed to BIOS's not
>>> setting up MTRRs correctly, or in extreme situations, running
>>> out of available MTRRS.  How does /proc/mtrr look ?
>>
>>reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
>>reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
>>reg02: base=0x60000000 (1536MB), size= 256MB: write-back, count=1
>>reg03: base=0x70000000 (1792MB), size= 128MB: write-back, count=1
>>reg04: base=0x78000000 (1920MB), size=  64MB: write-back, count=1
>>reg05: base=0x7c000000 (1984MB), size=  32MB: write-back, count=1
>
>The issue is with the bad MTRR setting by BIOS.
>It only sets 0-2016MB as write-back. 2016MB-2048MB is set as 
>uncached. Due to this whenever you use that memory you will 
>see the slowness. Probably BIOS is assuming that Video will 
>always use 32MB.
>

Oops. Probably I spoke a bit too early. Was this mtrr setting for the
working (mem=2026M) case?
Can you get mtrr for one of the non-working case.

-Venki
