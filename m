Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJMAEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJMAEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWJMAEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:04:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751351AbWJMAEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:04:22 -0400
Date: Thu, 12 Oct 2006 20:03:47 -0400
From: Dave Jones <davej@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
Subject: Re: [patch] rearrange kioctx and aio_ring_info
Message-ID: <20061013000347.GA8673@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Zach Brown' <zach.brown@oracle.com>,
	'Suparna Bhattacharya' <suparna@in.ibm.com>,
	"Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
	linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
References: <000101c6ee55$c3e121a0$db34030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c6ee55$c3e121a0$db34030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 04:25:54PM -0700, Chen, Kenneth W wrote:
 > The following patch is result of our kernel data latency analysis on a
 > large database setup (128 logical CPU, 1 TB memory, a couple thousand
 > disks). The analysis is done at an individual cache line level through
 > hardware performance monitor unit.  What we did essentially is to collect
 > data access latency on every kernel memory address and look for top 50
 > longest average access latency.  The hardware performance unit also keeps
 > track of instruction address for each collected data access.  This allows
 > us to further associate each of the top 50 cache lines to instruction
 > sequences that caused long latency.

Do you have performance numbers of before/after this change ?
How much is it worth?

	Dave

-- 
http://www.codemonkey.org.uk
