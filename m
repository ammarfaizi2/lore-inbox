Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUJKSHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUJKSHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUJKSHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:07:40 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:60045 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269156AbUJKSHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:07:38 -0400
Message-ID: <416ACBCE.9090500@colorfullife.com>
Date: Mon, 11 Oct 2004 20:07:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reduce fragmentation due to kmem_cache_alloc_node
References: <41684BF3.5070108@colorfullife.com> <1097514734.12861.366.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1097514734.12861.366.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

>Manfred,
>
>This patch seems to work fine on my AMD machine.
>I tested your patch on 2.6.9-rc2-mm3. 
>
>It seemed to have fixed fragmentation problem I was
>observing, but I don't think it fixed the problem
>completely. I still see some fragmentation, with
>repeated tests of scsi-debug, but it could be due
>to the test. I will collect more numbers..
>
>  
>
Did you disable the !CONFIG_NUMA block from <linux/slab.h> or leave it 
enabled? If the CONFIG_NUMA test is in the header file, then my patch is 
identical to you proposal, except that I've changed the global 
declaration instead of just the call from alloc_percpu.

--
    Manfred
