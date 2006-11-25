Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967220AbWKYVib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967220AbWKYVib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967222AbWKYVib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:38:31 -0500
Received: from dvhart.com ([64.146.134.43]:47760 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S967220AbWKYVia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:38:30 -0500
Message-ID: <4568B72C.1060801@mbligh.org>
Date: Sat, 25 Nov 2006 13:35:40 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
References: <4568AFB1.3050500@mbligh.org> <20061125132828.16a01762.akpm@osdl.org>
In-Reply-To: <20061125132828.16a01762.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The traces are a bit confusing, but I don't actually see anything wrong
> there.  The machine has used up all swap, has used up all memory and has
> correctly gone and killed things.  After that, there's free memory again.

Yeah, it's just a bit odd that it's always in the IO path. Makes me
suspect there's actually a bunch of pagecache in the box as well, but
maybe it's just coincidence, and the rest of the box really is full
of anon mem. I thought we dumped the alt-sysrq-m type stuff on an OOM
kill, but it seems not. maybe that's just not in mainline.

>> This doesn't seem to happen every run, unfortnately, only
>> intermittently, and we don't have much data before that, so
>> hard to tell how long it's been going on.
>>
>> Still happening on latest kernels.
>> http://test.kernel.org/abat/62445/debug/console.log
> 
> The same appears to have happened there too.  Although it does seem to have
> killed a lot more than it should have.
> 
> Has something changed in the configuration of that machine?  New LTP
> version?  Less swapsapce?

Difficult to tell, it's a fairly new box to the grid, so it seems to
have been doing that intermittently forever.

