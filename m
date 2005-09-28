Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVI1VLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVI1VLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVI1VLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:11:17 -0400
Received: from fmr13.intel.com ([192.55.52.67]:12935 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750923AbVI1VLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:11:16 -0400
Subject: earlier allocation of order 0 pages in __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Organization: Intel 
Date: Wed, 28 Sep 2005 14:18:36 -0700
Message-Id: <1127942316.5046.37.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 21:11:06.0502 (UTC) FILETIME=[240BAA60:01C5C471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering if it is a good idea in __alloc_pages to first try to see
if a order 0 request can be serviced by cpu's pcp before checking the
low water marks for the zone.  The is useful if a request can be
serviced by a free page on the pcp then there is no reason to check the
zone's limits.  This early allocation should be without any replenishing
of pcps from zone free list

thanks,
-rohit

