Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTHVS4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTHVS4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:56:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:32773 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263475AbTHVS4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:56:19 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030822113106.0503a665.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain> 
	<20030822113106.0503a665.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Aug 2003 13:56:06 -0500
Message-Id: <1061578568.2053.313.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 13:31, David S. Miller wrote:
> On Fri, 22 Aug 2003 19:34:41 +0100 (BST)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > And to me.  If VM_SHARED is set, then __vma_link_file puts the vma on
> > on i_mmap_shared.  If VM_SHARED is not set, it puts the vma on i_mmap.
> > flush_dcache_page treats i_mmap_shared and i_mmap lists equally.
> 
> But file system page cache writes only call flush_dache_page()
> if the page has a non-empty i_mmap_shared list.

Hmm, but if it does that then the glibc bug test should show up on sparc
because the i_mmap_shared list is empty if we only do MAP_SHARED of read
only files.

James


