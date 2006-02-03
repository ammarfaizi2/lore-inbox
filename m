Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWBCGfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWBCGfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWBCGfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:35:10 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:27104 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932430AbWBCGfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:35:09 -0500
Message-ID: <43E2F98E.6010300@colorfullife.com>
Date: Fri, 03 Feb 2006 07:34:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, kevin@koconnor.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] slab leak detector (Was: Size-128 slab leak)
References: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI> <20060202004415.28249549.akpm@osdl.org>
In-Reply-To: <20060202004415.28249549.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>  
>
>>Downside is that now 
>> some slabs don't get leak reports (those that don't get SLAB_STORE_USER 
>> enabled in kmem_cache_create).
>>    
>>
>
>Which slabs are those?  SLAB_HWCACHE_ALIGN?  If so, that's quite a lot of
>them (more than needed, probably).
>  
>
Slabs with 4 kB or larger objects.

--
    Manfred
