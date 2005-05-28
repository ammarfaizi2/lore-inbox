Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVE1HHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVE1HHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 03:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVE1HHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 03:07:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34182 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262089AbVE1HHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 03:07:18 -0400
Date: Sat, 28 May 2005 08:07:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Zankel <chris@zankel.net>
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <20050528070714.GB17005@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
References: <20050525134933.5c22234a.akpm@osdl.org> <200505272313.20734.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505272313.20734.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 11:13:19PM +0200, Arnd Bergmann wrote:
> On Middeweken 25 Mai 2005 22:49, Andrew Morton wrote:
> > 
> > - New Xtensa architecture: Tensilica Xtensa CPU series.
> 
> I noticed this has another copy of all the backwards compatibility
> syscalls in its arch/*/kernel/syscall.c file. This doesn't make
> sense for a new architecture added to the tree.
> 
> Chris, are there any existing binaries that rely on your implementations
> of old_mmap, sys_fork, sys_vfork, sys_olduname or sys_ipc and need to
> work with future kernels? Otherwise, you should probably drop these.
> For sys_ipc, you would need to add the subcalls directly to the table,
> like parisc does.

We should do that either way.  If people have existing binaries relying
on broken thing before submitting ports for review it's their fault.

