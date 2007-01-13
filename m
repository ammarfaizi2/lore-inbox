Return-Path: <linux-kernel-owner+w=401wt.eu-S1422644AbXAML3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbXAML3T (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 06:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbXAML3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 06:29:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32852 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422644AbXAML3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 06:29:18 -0500
Subject: Re: [2.6 patch] fix the JFFS2_FS_DEBUG=2 compilation
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, jffs-dev@axis.com,
       Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20070113105122.GL7469@stusta.de>
References: <20070112210537.GA24451@flint.arm.linux.org.uk>
	 <20070113105122.GL7469@stusta.de>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 19:29:59 +0800
Message-Id: <1168687799.9415.182.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-13 at 11:51 +0100, Adrian Bunk wrote:
> On Fri, Jan 12, 2007 at 09:05:37PM +0000, Russell King wrote:
> > The following configuration:
> > 
> > CONFIG_JFFS2_FS=y
> > CONFIG_JFFS2_FS_DEBUG=2
> > # CONFIG_JFFS2_FS_NAND is not set
> > # CONFIG_JFFS2_FS_NOR_ECC is not set
> > # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> > CONFIG_JFFS2_ZLIB=y
> > CONFIG_JFFS2_RTIME=y
> > # CONFIG_JFFS2_RUBIN is not set
> > 
> > results in these build errors:
> > 
> > fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
> > fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplete type
> > fs/jffs2/malloc.c: In function 'jffs2_free_full_dirent':
> > fs/jffs2/malloc.c:132: error: dereferencing pointer to incomplete type
> > fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dnode':
> > fs/jffs2/malloc.c:140: error: dereferencing pointer to incomplete type
> > fs/jffs2/malloc.c: In function 'jffs2_free_full_dnode':
> > fs/jffs2/malloc.c:146: error: dereferencing pointer to incomplete type
> > fs/jffs2/malloc.c: In function 'jffs2_alloc_raw_dirent':
> > fs/jffs2/malloc.c:154: error: dereferencing pointer to incomplete type
> > 
> > ... etc ...
> 
> Thanks for the report, patch below.

The patch is already in the MTD git tree, which is still awaiting Linus
to pull.

-- 
dwmw2

