Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUBEQSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUBEQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:18:34 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:9614 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265993AbUBEQSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:18:32 -0500
Message-ID: <40226C49.4010307@cyberone.com.au>
Date: Fri, 06 Feb 2004 03:16:09 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org> <40222D4B.6050608@cyberone.com.au> <68430000.1075997516@[10.10.2.4]>
In-Reply-To: <68430000.1075997516@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>--Nick Piggin <piggin@cyberone.com.au> wrote (on Thursday, February 05, 2004 22:47:23 +1100):
>
>
>>Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/
>>>
>>>
>>>- Merged some page reclaim fixes from Nick and Nikita.  These yield some
>>> performance improvements in low memory and heavy paging situations.
>>>
>>>
>>>
>>Nikita's vm-dont-rotate-active-list.patch still has this:
>>
>>+/* dummy pages used to scan active lists */
>>+static struct page scan_pages[MAX_NUMNODES][MAX_NR_ZONES];
>>+
>>
>>Which probably needs its nodes and cachelines untangled.
>>Maybe it doesn't - I really don't know.
>>
>
>The idle toad's way is to shove it in the pgdat.
>Maybe even the zone structure?
>
>

It logically belongs in the zone structure, but apparently
dependancies will not allow that right now.

