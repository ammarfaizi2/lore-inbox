Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbUKRV7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbUKRV7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUKRV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:57:30 -0500
Received: from fmr15.intel.com ([192.55.52.69]:20942 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S263035AbUKRVzf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:55:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: e820 and shared VGA memory problem
Date: Thu, 18 Nov 2004 13:55:25 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600360C6D5@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e820 and shared VGA memory problem
Thread-Index: AcTNtadPFaFY+LvbTxqIvTKP/LS/zAAAs7aQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Magnus Damm" <magnus.damm@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2004 21:55:25.0945 (UTC) FILETIME=[4F7CF690:01C4CDB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Magnus Damm
>Sent: Thursday, November 18, 2004 1:21 PM
>To: linux-kernel@vger.kernel.org
>Subject: e820 and shared VGA memory problem
>
>Heya,
>
>The machine is a Uniwill 223II0 equipped with 2GiB RAM and BIOS
>1.03US. The graphics are 855GM, aka "Intel Extreme Graphics 2", ie a
>chunk of system RAM is used as graphics memory. The BIOS does not
>allow me to setup the amount of VGA RAM.
>
>I am running a vanilla 2.6.9-kernel configured with highmem enabled.
>
>The problem is that the machine is slow as hell if the kernel is
>booted without limiting the amount of system ram with the command line
>option "ram=xM". And by that I mean that executing user space programs
>is _extremely_ slow - I've never taken the time to go through the
>rc-scripts.
>

What does your mtrr settings say? Can you get output of /proc/mtrr for
both case: System running fine with "mem=" and system being slow when
there is no "mem=".

I have seen similar problems on different hardware. And the issue was
due to the fact that BIOS mtrr setting and BIOS E820 doesn't agree with
each other regarding the usable memory. BIOS says some part of memory as
usable in E820 and sets mtrr as uncacheable to the same memory range.

-Venki  
