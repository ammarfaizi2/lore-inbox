Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUEZLZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUEZLZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbUEZLZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:25:44 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:24911 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264192AbUEZLZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:25:31 -0400
Message-ID: <40B47EA3.2060800@yahoo.com.au>
Date: Wed, 26 May 2004 21:25:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Olsson <mnemo@minimum.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47546.5050602@minimum.se>
In-Reply-To: <40B47546.5050602@minimum.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Olsson wrote:
> Hi Linux-gurus,
> 
> I agree with Anthony Disante, maybe not all users want swapping. I have 
> myself felt very annoying with swapping lately but I've not yet tried to 
> disable it.
> 
> In school I've studied the swapping concept from a theoretical point
> of view, and I fully understand the fact that swapping, if used 
> properly, can both increase performance and provide a safe way to get 
> out of a bad situation when the box runs out of memory. The problem is 
> that in reality this does not work, not on Linux nor on Windows 2000 
> which I use at home. Unfortunately I cannot provide a specific reason 
> why it does not work, I'm very much a end-user/desktop-user, I'm not a 
> kernel hacker (yet). But I see two things that needs improvement atm:
> 

You don't need to provide a specific reason, a report would be
valuable too.

> A) when I do large data processing operations the computer is always 
> very very slow afterwards
> 

Time how long the large data processing operations take, then turn
swap off and time them again.

> B) if I have X Mb of RAM then there should not be imho a single swap 
> read/write until the whole of my X Mb RAM is completely stuffed, is this 
> so today?
> 

Yes, Linux doesn't start swapping or reclaiming at all until your
RAM is full.

> ---
> 
> Also, imagine that I disable swap today and start a large data 
> processing operation. During this operation I try to start a new 
> process, here ideally the program should not OOM but instead the memory 
> allocated for the data processing operation should be decreased. Is this 
> possible using today's technology? Can be divide memory into two sorts, 
> one for processes (here to stay memory) and another sort for batch 
> operations (where the amount of memory does not really matter but less 
> memory means less performance). I see the problem with "taking memory 
> back" though, I guess its impossible.
> 

File backed data will be able to be reclaimed, yes.
