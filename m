Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbRCGQ6n>; Wed, 7 Mar 2001 11:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131122AbRCGQ6d>; Wed, 7 Mar 2001 11:58:33 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:30457 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131120AbRCGQ6V>; Wed, 7 Mar 2001 11:58:21 -0500
Date: Wed, 7 Mar 2001 13:56:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: BUG? race between kswapd and ptrace (access_process_vm )
In-Reply-To: <004701c0a724$45004240$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0103071356140.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Manfred Spraul wrote:

> Is kswapd now running without lock_kernel()?

Indeed ...

> Then there is a race between swapout and ptrace:
> access_process_vm() accesses the page table entries, only protected with
> the mmap_sem semaphore and lock_kernel().
>
> Isn't
>
>     spin_lock(&mm->page_table_lock);
>
> missing in access_one_page() [in linux/kernel/ptrace.c]?

You're probably right here ...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

