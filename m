Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTE3EtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTE3EtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:49:16 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:54694 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263273AbTE3EtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:49:15 -0400
Message-ID: <3ED6E5D2.50900@colorfullife.com>
Date: Fri, 30 May 2003 07:02:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "David S. Miller" <davem@redhat.com>, bonganilinux@mweb.co.za,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm1 Strangeness
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>	<20030529135541.7c926896.akpm@digeo.com>	<20030529.171114.34756018.davem@redhat.com> <20030529175135.7b204aaf.akpm@digeo.com>
In-Reply-To: <20030529175135.7b204aaf.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Something seems to have gone and bumped the object size from 240 bytes up
>to 4096.  This is actually what I want CONFIG_DEBUG_PAGEALLOC to do, but I
>don't think it does it yet.  
>  
>
Yes, it does it:
 > #ifdef CONFIG_DEBUG_PAGEALLOC
 >        if (size < PAGE_SIZE-3*BYTES_PER_WORD && size > 128)
 >                size = PAGE_SIZE-3*BYTES_PER_WORD;
 > #endif

--
    Manfred

