Return-Path: <linux-kernel-owner+w=401wt.eu-S1030274AbXALVFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbXALVFr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbXALVFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:05:47 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4651 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030274AbXALVFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:05:46 -0500
Date: Fri, 12 Jan 2007 21:05:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Cc: jffs-dev@axis.com
Subject: Build regression since 2.6.19-git7: jffs2
Message-ID: <20070112210537.GA24451@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>, jffs-dev@axis.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following configuration:

CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=2
# CONFIG_JFFS2_FS_NAND is not set
# CONFIG_JFFS2_FS_NOR_ECC is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set

results in these build errors:

fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_free_full_dirent':
fs/jffs2/malloc.c:132: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dnode':
fs/jffs2/malloc.c:140: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_free_full_dnode':
fs/jffs2/malloc.c:146: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_alloc_raw_dirent':
fs/jffs2/malloc.c:154: error: dereferencing pointer to incomplete type

... etc ...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
