Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUHOThE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUHOThE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 15:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266858AbUHOThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 15:37:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19666 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266853AbUHOThC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 15:37:02 -0400
Date: Sun, 15 Aug 2004 12:36:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte
In-Reply-To: <411F7067.8040305@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0408151234350.2309@schroedinger.engr.sgi.com>
References: <411F7067.8040305@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, Manfred Spraul wrote:

> Very odd. Why do you see a problem with the page_table_lock but no
> problem from the mmap semaphore?

I will have a look at that...

> The page fault codepath acquires both.
> How often is the page table lock acquired per page fault? Just once or
> multiple spin_lock calls per page fault? Is the problem contention or
> cache line trashing?

The page table lock seems to be acquired at least 2 times and up to 5
times per page fault.
