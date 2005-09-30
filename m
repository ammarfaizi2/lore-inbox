Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVI3BDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVI3BDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVI3BDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:03:08 -0400
Received: from fmr13.intel.com ([192.55.52.67]:5289 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932540AbVI3BDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:03:06 -0400
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
	__alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128034202.6145.2.camel@localhost>
References: <20050929150155.A15646@unix-os.sc.intel.com>
	 <1128034202.6145.2.camel@localhost>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 29 Sep 2005 18:10:00 -0700
Message-Id: <1128042600.3735.16.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 01:02:29.0047 (UTC) FILETIME=[A119AC70:01C5C55A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 15:50 -0700, Dave Hansen wrote:


> 
> That looks to share a decent amount of logic with the pcp code in
> buffered_rmqueue.  Any chance it could be consolidated instead of
> copy/pasting?
> 

It indeed does share most of the code with buffered_rmqueue.  And it is
definitely possible to streamline this control flow.  But that would
require more changes in the existing code (didn't want to make that as
part of this patch to start with).

-rohit

