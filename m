Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWHHRFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWHHRFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHHRFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:05:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:28842 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964903AbWHHRFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:05:07 -0400
Subject: Re: + fs-cache-generic-filesystem-caching-facility.patch added to
	-mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, dhowells@redhat.com,
       trond.myklebust@fys.uio.no, zippel@linux-m68k.org
In-Reply-To: <200608050009.k7509ivU019636@shell0.pdx.osdl.net>
References: <200608050009.k7509ivU019636@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 10:04:56 -0700
Message-Id: <1155056696.19249.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 17:09 -0700, akpm@osdl.org wrote:
> The attached patch adds a generic intermediary (FS-Cache) by which filesystems
> may call on local caching capabilities, and by which local caching backends may
> make caches available:

I'm getting the following in 2.6.18-rc3-mm2 when I complile AFS  and NFS
into the kernel.  I left FSCACHE as a module somehow, enabled AFS/NFS
caching, and hilarity ensues:

fs/built-in.o(.text+0xbbcd7): In function `nfs_fscache_release_page':
lxc/include/linux/fscache.h:482: undefined reference to
`__fscache_uncache_page'

Is there some way that we can tell fscache's Kconfig option that it can
not be a module if any of the filesystems using it *are*?  Should we
take away the option for fscache to be a module?

-- Dave

