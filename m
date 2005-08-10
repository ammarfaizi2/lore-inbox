Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVHJV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVHJV4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVHJV4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:56:46 -0400
Received: from dvhart.com ([64.146.134.43]:16258 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750987AbVHJV4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:56:46 -0400
Date: Wed, 10 Aug 2005 14:56:41 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Pavel Machek <pavel@suse.cz>, Daniel Phillips <phillips@arcor.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <1256640000.1123711001@flay>
In-Reply-To: <20050810215022.GA2465@elf.ucw.cz>
References: <42F57FCA.9040805@yahoo.com.au> <1123577509.30257.173.camel@gaston> <42F87C24.4080000@yahoo.com.au> <200508100522.51297.phillips@arcor.de> <20050810215022.GA2465@elf.ucw.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 10, 2005 23:50:22 +0200 Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
>> > Swsusp is the main "is valid ram" user I have in mind here. It
>> > wants to know whether or not it should save and restore the
>> > memory of a given `struct page`.
>> 
>> Why can't it follow the rmap chain?
> 
> It is walking physical memory, not memory managment chains. I need
> something like:

Can you not use page_is_ram(pfn) ?

M.

