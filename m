Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBFXVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBFXVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBFXVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:21:16 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:16778 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261234AbVBFXVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:21:12 -0500
Date: Mon, 7 Feb 2005 00:21:08 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050206232108.GA31813@ojjektum.uhulinux.hu>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206070659.GA28596@infradead.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
> On Sun, Feb 06, 2005 at 12:33:43AM -0500, John Richard Moser wrote:
> > I dunno.  I can never understand the innards of the kernel devs' minds.
> 
> filesystem detection isn't handled at the kerne level.

Yeah, but the link order could be changed... Patch inlined.

-- 
pozsy

diff -Naurd a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	2004-08-04 10:52:28.000000000 +0200
+++ b/fs/Makefile	2004-08-04 11:32:04.510913663 +0200
@@ -57,8 +57,8 @@
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
 obj-$(CONFIG_UMSDOS_FS)		+= umsdos/
-obj-$(CONFIG_MSDOS_FS)		+= msdos/
 obj-$(CONFIG_VFAT_FS)		+= vfat/
+obj-$(CONFIG_MSDOS_FS)		+= msdos/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_DEVFS_FS)		+= devfs/

Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>
