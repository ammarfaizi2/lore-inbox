Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUBELu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 06:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBELu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 06:50:26 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:59268 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265171AbUBELuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 06:50:25 -0500
Message-ID: <40222D4B.6050608@cyberone.com.au>
Date: Thu, 05 Feb 2004 22:47:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org>
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/
>
>
>- Merged some page reclaim fixes from Nick and Nikita.  These yield some
>  performance improvements in low memory and heavy paging situations.
>
>

Nikita's vm-dont-rotate-active-list.patch still has this:

+/* dummy pages used to scan active lists */
+static struct page scan_pages[MAX_NUMNODES][MAX_NR_ZONES];
+

Which probably needs its nodes and cachelines untangled.
Maybe it doesn't - I really don't know.


