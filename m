Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVI3A6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVI3A6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVI3A6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:58:09 -0400
Received: from fmr13.intel.com ([192.55.52.67]:42918 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932142AbVI3A6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:58:07 -0400
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
	__alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050929153626.3ab4fce1.akpm@osdl.org>
References: <20050929150155.A15646@unix-os.sc.intel.com>
	 <20050929153626.3ab4fce1.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 29 Sep 2005 18:05:24 -0700
Message-Id: <1128042325.3735.11.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 00:57:53.0425 (UTC) FILETIME=[FCD11810:01C5C559]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 15:36 -0700, Andrew Morton wrote:
> "Seth, Rohit" <rohit.seth@intel.com> wrote:
> >
> > 	[PATCH]: Try to service a order 0 page request in __alloc_pages from the pcp list before checking the aone_watermarks.
> >
> >         Try to service a order 0 page request from pcp list.  This will allow us to not check and possibly start the reclaim activity when there are free pages present on the pcp.  This early allocation does not try to replenish an empty pcp.
> 
> (Please avoid the 240-column emails!)
> 

This is bad.  Sorry.

> Why is this a desirable change to make?

This change avoids any checks for watermarks and starting potential
reclaims for the cases where we already know we don't need to.   

-rohit

