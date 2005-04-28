Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVD1CE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVD1CE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVD1CE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:04:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:61432 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261470AbVD1CEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:04:55 -0400
Message-ID: <427044AA.5030402@nortel.com>
Date: Wed, 27 Apr 2005 20:04:26 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: update to use the new 4L headers
References: <1114652039.7112.213.camel@gaston> <42704130.9050005@yahoo.com.au>
In-Reply-To: <42704130.9050005@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Just a bit off-topic: I wonder how many more of these open
> coded pt walks exist in arch code (yes I see you've cleaned
> yours up - good).

I know there's open coded walks outside the tree (I maintain one) due to 
there being no suitable function available from with in it...

I needed something like:

pte_t *va_to_ptep_map(struct mm_struct *mm, unsigned int addr)

There was code in follow_page() that did basically what I needed, but it 
was all contained within that function so I had to re-implement it.

Chris

