Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWAZW5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWAZW5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbWAZW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:57:13 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21217 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030181AbWAZW5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:57:13 -0500
Message-ID: <43D953C4.5020205@us.ibm.com>
Date: Thu, 26 Jan 2006 14:57:08 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 25 Jan 2006, Matthew Dobson wrote:
> 
> 
>>plain text document attachment (critical_mempools)
>>Add NUMA-awareness to the mempool code.  This involves several changes:
> 
> 
> I am not quite sure why you would need numa awareness in an emergency 
> memory pool. Presumably the effectiveness of the accesses do not matter. 
> You only want to be sure that there is some memory available right?

Not all requests for memory from a specific node are performance
enhancements, some are for correctness.  With large machines, especially as
those large machines' workloads are more and more likely to be partitioned
with something like cpusets, you want to be able to specify where you want
your reserve pool to come from.  As it was not incredibly difficult to
offer this option, I added it.  I was unwilling to completely ignore
callers' NUMA requests, assuming that they are all purely performance
motivated.


> You do not need this.... 

I do not agree...


Thanks!

-Matt
