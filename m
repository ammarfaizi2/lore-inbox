Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVFKJ6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVFKJ6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVFKJ6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 05:58:42 -0400
Received: from one.firstfloor.org ([213.235.205.2]:28832 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261670AbVFKJ6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 05:58:41 -0400
To: Subrahmanyam Ongole <songole@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64: Kernel with large page size
References: <a8447f24050603175061598809@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Jun 2005 11:58:39 +0200
In-Reply-To: <a8447f24050603175061598809@mail.gmail.com> (Subrahmanyam
 Ongole's message of "Fri, 3 Jun 2005 17:50:55 -0700")
Message-ID: <m164wldxkg.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subrahmanyam Ongole <songole@gmail.com> writes:

> When we run our application on AMD Opteron processors, we are seeing a
> large number of   L1_AND_L2_DTLB_MISSES. We used oprofile to measure
> these numbers.
>
> We wanted to try with a bigger page size and see if we could bring it
> down. TLB caches 4k page translations. I don't  know if larger page

You can use large pages in your application by mmaping
from a file in hugetlbfs and configuring large pages using sysctl.

> size would even help here.

It probably wouldn't because Opteron has much more 4K DTLB entries
than 2M DTLB entries. I have had people trying the opposite from
what you tried (using 4K pages for the kernel instead of 2MB),
but that also doesn't work right now.

-Andi

