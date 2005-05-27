Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVE0VdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVE0VdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVE0VdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:33:25 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:905 "EHLO natnoddy.rzone.de")
	by vger.kernel.org with ESMTP id S262607AbVE0VdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:33:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 23:13:19 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505272313.20734.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 25 Mai 2005 22:49, Andrew Morton wrote:
> 
> - New Xtensa architecture: Tensilica Xtensa CPU series.

I noticed this has another copy of all the backwards compatibility
syscalls in its arch/*/kernel/syscall.c file. This doesn't make
sense for a new architecture added to the tree.

Chris, are there any existing binaries that rely on your implementations
of old_mmap, sys_fork, sys_vfork, sys_olduname or sys_ipc and need to
work with future kernels? Otherwise, you should probably drop these.
For sys_ipc, you would need to add the subcalls directly to the table,
like parisc does.

	Arnd <><
