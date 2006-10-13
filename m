Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWJMAU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWJMAU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWJMAU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:20:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:27275 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751362AbWJMAU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:20:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="3373460:sNHT143765262"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Dave Jones'" <davej@redhat.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       <linux-kernel@vger.kernel.org>, "linux-aio" <linux-aio@kvack.org>
Subject: RE: [patch] rearrange kioctx and aio_ring_info
Date: Thu, 12 Oct 2006 17:20:52 -0700
Message-ID: <000401c6ee5d$727de3e0$db34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbuWx2xh+O6EtGQRgS9Nfi0lnbhbAAAbB0A
In-Reply-To: <20061013000347.GA8673@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote on Thursday, October 12, 2006 5:04 PM
> On Thu, Oct 12, 2006 at 04:25:54PM -0700, Chen, Kenneth W wrote:
>  > The following patch is result of our kernel data latency analysis on a
>  > large database setup (128 logical CPU, 1 TB memory, a couple thousand
>  > disks). The analysis is done at an individual cache line level through
>  > hardware performance monitor unit.  What we did essentially is to collect
>  > data access latency on every kernel memory address and look for top 50
>  > longest average access latency.  The hardware performance unit also keeps
>  > track of instruction address for each collected data access.  This allows
>  > us to further associate each of the top 50 cache lines to instruction
>  > sequences that caused long latency.
> 
> Do you have performance numbers of before/after this change ?


Not yet, I just queued up experiment on our internal benchmark setup. I posted
the patch here to get some early discussion on how to attack the problem.
