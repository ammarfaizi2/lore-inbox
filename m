Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVDRQhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVDRQhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVDRQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:37:19 -0400
Received: from fmr18.intel.com ([134.134.136.17]:27009 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261385AbVDRQhN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:37:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Date: Tue, 19 Apr 2005 00:37:07 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8B78@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Thread-Index: AcVD9eAOsKpZOGZ8TG+CRZo1yAFElAAPUiNw
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 18 Apr 2005 16:37:08.0304 (UTC) FILETIME=[DCC87500:01C54434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a 32bit program is mapping a lot of hugepage vm_areas, 
hugetlb_get_unmapped_area may search beyond 4G, then the program will
get a SIGFAULT instead of an errno of ENOMEM.
This patch will fix that.
I believe there are other inconsistent cases in generic code like mm and
fs.

Zou Nan hai

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Monday, April 18, 2005 5:06 PM
> To: Zou, Nanhai
> Cc: discuss@x86-64.org; Andi Kleen; linux-kernel@vger.kernel.org;
Siddha,
> Suresh B
> Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup
> 
> On Sat, Apr 16, 2005 at 09:34:25AM +0800, Zou, Nanhai wrote:
> >
> > Hi,
> >    This patch will clean up the X86_64 compatibility mode TASK_SIZE
> > define thus fix some bugs found in X86_64 compatibility mode
program.
> 
> Fix what bugs exactly?  Please a detailed description.
> 
> -Andi
