Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVI1SKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVI1SKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVI1SKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:10:35 -0400
Received: from fmr13.intel.com ([192.55.52.67]:1249 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750713AbVI1SKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:10:34 -0400
Subject: Re: [PATCH]: show_free_area shows free pages in pcp list
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0509281037240.14338@schroedinger.engr.sgi.com>
References: <20050928102219.A29282@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0509281037240.14338@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 28 Sep 2005 11:17:49 -0700
Message-Id: <1127931469.5046.13.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 18:10:23.0999 (UTC) FILETIME=[E56900F0:01C5C457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 10:40 -0700, Christoph Lameter wrote:
> On Wed, 28 Sep 2005, Seth, Rohit wrote:
> 
> > [PATCH]: The count field in pcp list represents the free pages in that list. 
> 
> Well, lets keep it the way it is.
> 
> Its the number of free pages used by the pcp list.
> 

As you said, pcp is a cache of free pages.  From pcp's point-of-view,
this is a count of free pages that is available for use.

> Its  true that these are pages that are not "used" by the system but they 
> are in use for the cache and not accounted for by the number of free 
> pages.
> 
> 


In case free is causing any confusion then I would like to get that
changed to "count"...representing the number of elements on it (and the
field of structure just like other values).

