Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDUPoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDUPoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDUPoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:44:09 -0400
Received: from fmr18.intel.com ([134.134.136.17]:43220 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261459AbVDUPoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:44:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Date: Thu, 21 Apr 2005 23:43:57 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8B95@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Thread-Index: AcVGaFQ+ceY5o+ECSHKmNxYUf/rK6gAIH3/g
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 21 Apr 2005 15:43:58.0561 (UTC) FILETIME=[EEC98D10:01C54688]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Isn't that a 
!test_thread_flag(TIF_IA32) && (flags & MAP_32BIT)
in my patch?

Zou Nan hai

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Thursday, April 21, 2005 7:51 PM
> To: Zou, Nanhai
> Cc: Andi Kleen; discuss@x86-64.org; linux-kernel@vger.kernel.org;
Siddha,
> Suresh B
> Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup
> 
> On Thu, Apr 21, 2005 at 01:17:40AM +0800, Zou, Nanhai wrote:
> > Hi Andi,
> >    What is your comment on this patch?
> 
> There is at least one wrong change in there, you have a check
> for test_thread_flag(TIF_IA32) && (flags & MAP_32BIT)
> 
> and that is wrong because MAP_32BIT is used from 64bit code
> 
> -Andi
