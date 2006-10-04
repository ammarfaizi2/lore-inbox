Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWJDA6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWJDA6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWJDA6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:58:30 -0400
Received: from mga07.intel.com ([143.182.124.22]:47886 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161052AbWJDA63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:58:29 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,252,1157353200"; 
   d="scan'208"; a="126538335:sNHT71994377"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
In-Reply-To: <20061003170705.6a75f4dd.akpm@osdl.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <20061003170705.6a75f4dd.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel
Date: Tue, 03 Oct 2006 17:09:29 -0700
Message-Id: <1159920569.8035.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 17:07 -0700, Andrew Morton wrote:

> 
> Perhaps the `static int __warn_once' is getting put in the same cacheline
> as some frequently-modified thing.   Perhaps try marking that as __read_mostly?
> 

I've tried marking static int __warn_once as __read_mostly.  However, it
did not help with reducing the cache miss :(

So I would suggest reversing the "Let WARN_ON/WARN_ON_ONCE return the
condition" patch.  It has just been added 3 days ago so reversing it
should not be a problem.

Tim
