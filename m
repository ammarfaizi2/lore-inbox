Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbSLERlo>; Thu, 5 Dec 2002 12:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbSLERlo>; Thu, 5 Dec 2002 12:41:44 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:24776 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267355AbSLERln>;
	Thu, 5 Dec 2002 12:41:43 -0500
Message-ID: <3DEF9196.6010002@colorfullife.com>
Date: Thu, 05 Dec 2002 18:49:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Hmm... that doesn't seem sufficient to explain it.
>
>Some background: I work with PPC embedded chips (the 4xx family) whose
>only way to get consistent memory is by entirely disabling the cache.
>
What do you mean with "disable"?
Do you have to disable the cache entirely when you encounter the first 
pci_alloc_consistent() call, or do you disable the cache just for the 
region that is returned by pci_alloc_consistent()?

If you disable it entirely - would "before_acess_consistent_area() / 
after_access_consistent_area()" macros help to avoid that, or are there 
other problems?

--
    Manfred

