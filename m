Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWA0AgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWA0AgC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWA0AgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:36:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:46535 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030246AbWA0AgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:36:00 -0500
Message-ID: <43D96AEC.4030200@us.ibm.com>
Date: Thu, 26 Jan 2006 16:35:56 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <20060127002331.GH10409@kvack.org>
In-Reply-To: <20060127002331.GH10409@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Wed, Jan 25, 2006 at 03:51:33PM -0800, Matthew Dobson wrote:
> 
>>plain text document attachment (critical_mempools)
>>Add NUMA-awareness to the mempool code.  This involves several changes:
> 
> 
> This is horribly bloated.  Mempools should really just be a flag and 
> reserve count on a slab, as then the code would not be in hot paths.
> 
> 		-ben

Ummm...  ok?  But with only a simple flag, how do you know *which* mempool
you're trying to use?  What if you want to use a mempool for a non-slab
allocation?

-Matt
