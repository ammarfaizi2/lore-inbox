Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUC1G5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 01:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUC1G5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 01:57:04 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:14249 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262106AbUC1G5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 01:57:00 -0500
Message-ID: <40667734.8090203@yahoo.com.au>
Date: Sun, 28 Mar 2004 16:56:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org>
In-Reply-To: <20040328044029.GB1984@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Sun, Mar 28 at  9:37, Nick Piggin wrote:
> 
>> I think 32MB is too much. You incur latency and lose
>> scheduling grainularity. I bet returns start diminishing
>> pretty quickly after 1MB or so.
> 
> 
> 32-MB requests are the best for raw throughput.
> 
> ~15ms to land at your target location, then pure 50-60MB/sec for the .5
> seconds it takes to finish the operation. (media limited at that point)
> 
> Sure, there's more latency, but I guess that is application dependant.
> 

What about a queue depth of 2, and writing that 32MB in 1MB requests?
