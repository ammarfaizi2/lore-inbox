Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbTCHOnc>; Sat, 8 Mar 2003 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbTCHOnb>; Sat, 8 Mar 2003 09:43:31 -0500
Received: from [196.12.44.6] ([196.12.44.6]:55434 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S262036AbTCHOnF>;
	Sat, 8 Mar 2003 09:43:05 -0500
Date: Sat, 8 Mar 2003 20:24:25 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Allocating memory
Message-ID: <Pine.LNX.4.44.0303082012490.15468-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
	this sounds awkward, but how do we allocate mmap to a process, if
we want to explicitly do it?  used the kmem_cache_alloc(mm_cachep,...) to
allocate memory to (task_struct)->mm, later allocated some vm_areas (no
dynamic libraries)  similarly... after using pgd_alloc to allocate the
pgd, added mm to the mmlist and copied all other variables directly from
the original mm of that process... then, i tried to start the process...
the response was that the system rebooted instantaneously (i expected it
to generate some page-faults, but surprisingly nothing like that
happened...). On trying to learn about that further, thought i was missing
on the PMDs and the PTEs.

could someone enlighten me on what could have gone wrong in the above setup.  

Thanks for your ideas.
Prasad.

-- 
Failure is not an option

