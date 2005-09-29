Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVI2Q12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVI2Q12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVI2Q12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:27:28 -0400
Received: from fmr13.intel.com ([192.55.52.67]:21638 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932235AbVI2Q11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:27:27 -0400
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
From: Rohit Seth <rohit.seth@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@engr.sgi.com>, akpm@osdl.org,
       linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org, steiner@sgi.com
In-Reply-To: <433B8E76.9080005@yahoo.com.au>
References: <20050928105009.B29282@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
	 <1127939185.5046.17.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0509281408480.15213@schroedinger.engr.sgi.com>
	 <1127943168.5046.39.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
	 <433B8E76.9080005@yahoo.com.au>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 29 Sep 2005 09:34:19 -0700
Message-Id: <1128011659.3735.3.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 16:26:51.0923 (UTC) FILETIME=[99232E30:01C5C512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 16:49 +1000, Nick Piggin wrote:

> I don't see that there would be any problems with playing with the
> ->high and ->low numbers so long as they are a reasonable multiple
> of batch, however I would question the merit of setting the high
> watermark of the cold queue to ->batch + 1 (should really stay at
> 2*batch IMO).
> 

I agree that this watermark is little low at this point.  But that is
mainly because currently we don't have a way to drain the pcps for low
memory conditions.  Once I add that support, I will bump up the high
water marks.

Can you share a list of specific workloads that you ran earlier while
fixing these numbers.

-rohit

