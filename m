Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUBEQMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUBEQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:12:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:20165 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265328AbUBEQMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:12:12 -0500
Date: Thu, 05 Feb 2004 08:11:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <68430000.1075997516@[10.10.2.4]>
In-Reply-To: <40222D4B.6050608@cyberone.com.au>
References: <20040205014405.5a2cf529.akpm@osdl.org> <40222D4B.6050608@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Nick Piggin <piggin@cyberone.com.au> wrote (on Thursday, February 05, 2004 22:47:23 +1100):

> 
> Andrew Morton wrote:
> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/
>> 
>> 
>> - Merged some page reclaim fixes from Nick and Nikita.  These yield some
>>  performance improvements in low memory and heavy paging situations.
>> 
>> 
> 
> Nikita's vm-dont-rotate-active-list.patch still has this:
> 
> +/* dummy pages used to scan active lists */
> +static struct page scan_pages[MAX_NUMNODES][MAX_NR_ZONES];
> +
> 
> Which probably needs its nodes and cachelines untangled.
> Maybe it doesn't - I really don't know.

The idle toad's way is to shove it in the pgdat.
Maybe even the zone structure?

M.
