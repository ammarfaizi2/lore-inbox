Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbUKBWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUKBWgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKBWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:36:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21198 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262425AbUKBWfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:35:10 -0500
Message-ID: <41880B60.9070004@us.ibm.com>
Date: Tue, 02 Nov 2004 14:34:08 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@novell.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com>	<20041102220720.GV3571@dualathlon.random>	<4188086F.8010005@us.ibm.com> <20041102142944.0be6f750.akpm@osdl.org>
In-Reply-To: <20041102142944.0be6f750.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
>>Andrea Arcangeli wrote:
>>
>>>Still I recommend investigating _why_ debug_pagealloc is violating the
>>>API. It might not be necessary to wait for the pageattr universal
>>>feature to make DEBUG_PAGEALLOC work safe.
>>
>>OK, good to know.  But, for now, can we pull this out of -mm?  Or, at 
>>least that BUG_ON()?  DEBUG_PAGEALLOC is an awfully powerful debugging 
>>tool to just be removed like this.
> 
> If we make it a WARN_ON, will that cause a complete storm of output?

Yeah, just tried it.  I hit a couple hundred of them before I got to init.
