Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVKJRE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVKJRE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKJRE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:04:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40667 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751151AbVKJRE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:04:28 -0500
Message-ID: <43737D94.2060408@us.ibm.com>
Date: Thu, 10 Nov 2005 09:04:20 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com> <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI> <4370F7AE.5090505@us.ibm.com> <20051110104211.GB5376@stusta.de>
In-Reply-To: <20051110104211.GB5376@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Nov 08, 2005 at 11:08:30AM -0800, Matthew Dobson wrote:
> 
>>Pekka J Enberg wrote:
>>
>>>On Mon, 7 Nov 2005, Matthew Dobson wrote:
>>>
>>>
>>>>I found three functions in slab.c that have only 1 caller (kmem_getpages,
>>>>alloc_slabmgmt, and set_slab_attr), so let's inline them.
>>>
>>>
>>>Why? They aren't on the hot path and I don't see how this is an 
>>>improvement...
>>>
>>>			Pekka
>>
>>Well, no, they aren't on the hot path.  I just figured since they are only
>>ever called from one other function, why not inline them?  If the sentiment
>>is that it's a BAD idea, I'll drop it.
> 
> 
> And if there will one day be a second caller, noone will remember to 
> remove the inline...

So are you suggesting that we don't mark these functions 'inline', or are
you just pointing out that we'll need to drop the 'inline' if there is ever
another caller?

-Matt
