Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbSJBQyo>; Wed, 2 Oct 2002 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263171AbSJBQyo>; Wed, 2 Oct 2002 12:54:44 -0400
Received: from dsl-213-023-022-021.arcor-ip.net ([213.23.22.21]:34690 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263158AbSJBQyk>;
	Wed, 2 Oct 2002 12:54:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Snapshot of shared page tables
Date: Wed, 2 Oct 2002 19:00:19 +0200
X-Mailer: KMail [version 1.3.2]
References: <45850000.1033570655@baldur.austin.ibm.com> <E17wmit-0001bH-00@starship>
In-Reply-To: <E17wmit-0001bH-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wmrE-0001bS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 18:51, Daniel Phillips wrote:
> On Wednesday 02 October 2002 16:57, Dave McCracken wrote:
> > 
> > Ok, here it is.  This patch works for my simple tests, both under UP and
> > SMP, including under memory pressure.  I'd appreciate anyone who'd like to
> > take it and beat on it.  Please let me know of any problems you find.
> > 
> > The patch is against this morning's 2.5 BK tree.
> 
> Interesting, you substituted pte_page_lock(ptepage) for mm->page_table_lock.
> Could you wax poetic about that, please?

Never mind, I see the logic.  This reflects the fact that page_table_lock
is insufficient protection when pte pages are shared.  So you solved that
problem and at the same time improved the scalability for the general case
immensely, without adding any new overhead.  Very nice!

-- 
Daniel
