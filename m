Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUBWDAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUBWDAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:00:21 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:34471 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261793AbUBWDAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:00:05 -0500
Message-ID: <40396ACD.7090109@cyberone.com.au>
Date: Mon, 23 Feb 2004 13:51:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org>
In-Reply-To: <20040222175507.558a5b3d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/
>>>
>>>
>>>
>>URL is of course,
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/
>>
>
>Yes, thanks.
>
>
>>This still doesn't shrink slab correctly on highmem machines
>>because you dropped my patch :(
>>
>
>First, one needs to define "correctly".
>
>Certainly, it is not "solves the alleged updatedb problem".
>
>The design behind the slab shrinking is to reclaim slab in response to
>memory demand.  Not in response to lowmem demand.  With all the scaling,
>accounting-for-seeks-and-locality, etc.
>
>

That is the wrong design. That is basically just circumventing
zone balancing, and it shows because you don't balance slab vs
lowmem properly.

Lowmem pagecache vs highmem pagecache should be balanced correctly?
I think it is with your other patches.

Lowmem pagecache vs slab should be balanced correctly with my patch.

Therefore highmem vs slab will be balanced correctly.

Is that a good proof?

