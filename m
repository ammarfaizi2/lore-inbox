Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTKZMgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTKZMgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:36:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:17114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbTKZMga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:36:30 -0500
Date: Wed, 26 Nov 2003 04:42:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-Id: <20031126044251.3b8309c1.akpm@osdl.org>
In-Reply-To: <20031126085123.A1952@infradead.org>
References: <20031125211518.6f656d73.akpm@osdl.org>
	<20031126085123.A1952@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 25, 2003 at 09:15:18PM -0800, Andrew Morton wrote:
> > +invalidate_mmap_range-non-gpl-export.patch
> > 
> >  Export invalidate_mmap_range() to all modules
> 
> Why?

The individual patches in the broken-out/ directory are usually
changelogged.  This one says:

  It was EXPORT_SYMBOL_GPL(), however IBM's GPFS is not GPL.

  - the GPFS team contributed to the testing and development of
    invaldiate_mmap_range().

  - GPFS was developed under AIX and was ported to Linux, and hence meets
    Linus's "some binary modules are OK" exemption.

  - The export makes sense: clustering filesystems need it for shootdowns to
    ensure cache coherency.


