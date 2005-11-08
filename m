Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVKHTEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVKHTEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVKHTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:04:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:10112 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030318AbVKHTEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:04:32 -0500
Message-ID: <4370F6BB.1070409@us.ibm.com>
Date: Tue, 08 Nov 2005 11:04:27 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Roland Dreier <rolandd@cisco.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <52mzkfrily.fsf@cisco.com> <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 7 Nov 2005, Roland Dreier wrote:
> 
> 
>>    > * Replace a constant (4096) with what it represents (PAGE_SIZE)
>>
>>This seems dangerous.  I don't pretend to understand the slab code,
>>but the current code works on architectures with PAGE_SIZE != 4096.
>>Are you sure this change is correct?
> 
> 
> Leave the constant. The 4096 is only used for debugging and is a boundary 
> at which redzoning and last user accounting is given up.
> 
> A large object in terms of this patch is a object greater than 4096 bytes 
> not an object greater than PAGE_SIZE. I think the absolute size is 
> desired.

Would you be OK with at least NAMING the constant?  I won't name it
PAGE_SIZE (of course), but LARGE_OBJECT_SIZE or something?

> Would you CC manfred on all your patches?

Yes.  I will repost my patches later today and I will be sure to CC Manfred
on all of them.

Thanks for the review,

-Matt
