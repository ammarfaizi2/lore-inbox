Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRDUOpP>; Sat, 21 Apr 2001 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132675AbRDUOpF>; Sat, 21 Apr 2001 10:45:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21772 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132674AbRDUOo6>;
	Sat, 21 Apr 2001 10:44:58 -0400
Date: Sat, 21 Apr 2001 15:44:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: All architecture maintainers: pgd_alloc()
Message-ID: <20010421154455.C7576@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For ARM, I require pgd_alloc to take a struct mm_struct argument (so the
pgd_alloc prototype becomes "pgd_t *pgd_alloc(struct mm_struct *)".

Why?  Because ARM must always have the first virtual page allocated and
present - its used for the hardware vectors, and in order to allocate
the page table for this page, I need a mm_struct (see the pte_alloc
prototype and associated code in mm/memory.c).

There are various options here:

1. Either I can fix up all architectures, and send a patch to this list, or
2. You can fix it up, send me a patch, and I'll collate them and send the
   whole to Linus.
3. I can send a patch to Alan, and you can send your individual patches again
   to Alan, and Alan can send the whole patch to Linus.

Its up to you how this is done.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

