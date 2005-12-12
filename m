Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVLLIfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVLLIfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLLIfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:35:23 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:38804 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751134AbVLLIfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:35:23 -0500
Message-ID: <439D3632.7000201@cosmosbay.com>
Date: Mon, 12 Dec 2005 09:34:58 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] x86_64 NUMA : Bug correction in populate_memnodemap()
References: <a762e240512062124i517a9c35xd1ec681428418341@mail.gmail.com> <43970136.4010006@cosmosbay.com> <20051211182741.GT11190@wotan.suse.de>
In-Reply-To: <20051211182741.GT11190@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 12 Dec 2005 09:35:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Wed, Dec 07, 2005 at 04:35:18PM +0100, Eric Dumazet wrote:
> 
>>As reported by Keith Mannthey, there are problems in populate_memnodemap()
>>
>>The bug was that the compute_hash_shift() was returning 31, with incorrect 
>>initialization of memnodemap[]
>>
>>To correct the bug, we must use (1UL << shift) instead of (1 << shift) to 
>>avoid an integer overflow, and we must check that shift < 64 to avoid an 
>>infinite loop.
> 
> 
> It's already merged, no need to resubmit. P.S.: It would be easier
> to merge if you didn't use attachments.

Hi Andi

AFAIK I posted the patch on linux-kernel only once... and once privatly to 
Keith because it seems he missed the linux-kernel post.
I'm confused by your answer.

Eric
