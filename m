Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSGMUFq>; Sat, 13 Jul 2002 16:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSGMUFp>; Sat, 13 Jul 2002 16:05:45 -0400
Received: from ns.suse.de ([213.95.15.193]:58122 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315416AbSGMUFp>;
	Sat, 13 Jul 2002 16:05:45 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch[ Simple Topology API
References: <3D2F75D7.3060105@us.ibm.com.suse.lists.linux.kernel> <3D2F9521.96D7080B@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jul 2002 22:08:35 +0200
In-Reply-To: Andrew Morton's message of "13 Jul 2002 04:45:16 +0200"
Message-ID: <p73ofdbv1a4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:


> AFAIK, the interested parties with this and the memory binding API are
> ia32-NUMA, ia64, PPC, some MIPS and x86-64-soon.  It would be helpful
> if the owners of those platforms could review this work and say "yes,
> this is something we can use and build upon".  Have they done that?

Comment from the x86-64 side: 

Current x86-64 NUMA essentially has no 'nodes', just each CPU has
local memory that is slightly faster than remote memory. This means
the node number would be always identical to the CPU number. As long
as the API provides it's ok for me. Just the node concept will not be
very useful on that platform. memblk will also be identity mapped to
node/cpu.

Some way to tell user space about memory affinity seems to be useful,
but...

General comment:

I don't see what the application should do with the memblk concept
currently. Just knowing about it doesn't seem too useful. 
Surely it needs some way to allocate memory in a specific memblk to be useful?
Also doesn't it need to know how much memory is available in each memblk?
(otherwise I don't see how it could do any useful partitioning)

-Andi

