Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVAAEHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVAAEHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVAAEHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:07:02 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:64855 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S262187AbVAAEG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:06:56 -0500
Date: Fri, 31 Dec 2004 23:04:58 -0500 (EST)
From: Michael Hines <mhines@cs.fsu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: can you switch between GFP_ATOMIC and GFP_KERNEL?
Message-ID: <Pine.GSO.4.33.0412312259160.28251-100000@diablo.cs.fsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've been working on some code that puts a hook in net/core/dev.c
to intercept packets and redirect them to a module of mine, depending
on the type of packet it is....

	My question is, new sk_buffs are always allocated with GFP_KERNEL
and can be swapped out. Is it possible to change the allocation status of
already-allocated memory to GFP_ATOMIC on the fly? (i.e. both the
slab-cache sk_buff header memory as well as the kmalloc'd data area).

	My module keeps these packets for some time. My machine has plenty
of memory, and I'd much prefer that the memory belonging to these newly
receive packets never gets swapped out.

Thanks,
/*********************************/
Michael R. Hines
Grad Student, Florida State
Dept. Computer Science
http://www.cs.fsu.edu/~mhines/
Jusqu'a ce que le futur vienne...
/*********************************/


