Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUHZVAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUHZVAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269635AbUHZU7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:59:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34299 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269657AbUHZU4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:56:54 -0400
Date: Thu, 26 Aug 2004 13:55:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <52540000.1093553736@flay>
In-Reply-To: <412E11ED.7040300@kolivas.org>
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, August 27, 2004 02:38:05 +1000 Con Kolivas <kernel@kolivas.org> wrote:

> Rafael J. Wysocki wrote:
>> On Thursday 26 of August 2004 13:07, Con Kolivas wrote:
>> 
>>> Andrew Morton wrote:
>>> 
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
>>>> .6.9-rc1-mm1/
>>>> 
>>>> 
>>>> - nicksched is still here.  There has been very little feedback, except
>>>> that it seems to slow some workloads on NUMA.
>>> 
>>> That's because most people aren't interested in a new cpu scheduler for
>>> 2.6.
>> 
>> 
>> I am, but I have no benchmarks that give any useful numbers.
> 
> That's because there are none for interactivity; you're simply 
> reinforcing my point.

Rick's schedstats stuff had some ways to measure latency that seemed to work
quite nicely. Hard to simulate exactly mozilla, email, etc, but probably
close enough to be far more use than "ooh, it feels faster".

He did a whole paper at OLS ... Rick ... pointer?

>> Actually, with the current scheduler, updatedb really sucks.  It's supposed to 
>> be a background task, but it hogs IO resources and memory like crazy 
>> (disclaimer: it's my personal subjective observation).
> 
> The cpu scheduler plays almost no part in this. It's the I/O scheduler and the vm. IOnice will help the former _when it comes out_. Dropping the swappiness kind of helps the latter; although there are numerous alternative tweaks appearing for that too.

Yup. I can open a large 8Mpixel camera image in "display" and hang the whole
system for about 30s too ;-(

M.

