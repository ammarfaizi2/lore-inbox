Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTEMFrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTEMFrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:47:48 -0400
Received: from ns.suse.de ([213.95.15.193]:18188 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262963AbTEMFrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:47:47 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
References: <20030512155417.67a9fdec.akpm@digeo.com.suse.lists.linux.kernel>
	<20030512155511.21fb1652.akpm@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 May 2003 08:00:28 +0200
In-Reply-To: <20030512155511.21fb1652.akpm@digeo.com.suse.lists.linux.kernel>
Message-ID: <p73wugvz8qr.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

I fixed a lot of bugs since then. It's not all merged yet and I introduced
a few new ones in the process but: 

> 
> arch/x86_64/
> ------------
> 
>   (Andi)
> 
> - memory corruption with IOMMU pci_free_consistent - often causes crashes
>   at shutdown.  This is rather mysterious, the code is basically identical to
>   2.4 which works fine.  Can only be seen on systems with >4GB of memory or
>   with iommu=force

This is fixed.


> - change_page_attr corrupts memory/crashes. Breaks some AGP users.

This is also fixed.


> - some fixes from 2.4 still need to be merged

This is basically done, except the timing code.

Current new bug list: 

- 32bit vsyscalls seem to be broken
- 32bit elf coredumps are broken

Required/Wanted features:

- need to coredump 64bit vsyscall code with dwarf2
- move 64bit signal trampolines into vsyscall code and add dwarf2 for it.
- describe kernel assembly with dwarf2 annotations for kgdb (currently waiting 
on some binutils changes for this) 

-Andi
