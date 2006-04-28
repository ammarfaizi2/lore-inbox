Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWD1KhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWD1KhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWD1KhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:37:03 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23708 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030365AbWD1KhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:37:02 -0400
Date: Fri, 28 Apr 2006 13:36:59 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Michael Holzheu <holzheu@de.ibm.com>
cc: akpm@osdl.org, schwidefsky@de.ibm.com, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
In-Reply-To: <20060428112225.418cadd9.holzheu@de.ibm.com>
Message-ID: <Pine.LNX.4.58.0604281334080.16832@sbz-30.cs.Helsinki.FI>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, 28 Apr 2006, Michael Holzheu wrote:
> diff -urpN linux-2.6.16/arch/s390/hypfs/inode.c linux-2.6.16-hypfs/arch/s390/hypfs/inode.c
> --- linux-2.6.16/arch/s390/hypfs/inode.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-hypfs/arch/s390/hypfs/inode.c	2006-04-28 08:59:36.000000000 +0200

[snip]

> +static struct dentry *update_file_dentry;
> +static struct file_operations hypfs_file_ops;
> +static struct file_system_type hypfs_type;
> +static struct super_operations hypfs_s_ops;
> +static time_t last_update_time = 0;	/* update time in seconds since 1970 */
> +static DEFINE_MUTEX(hypfs_lock);

These should be per-superblock and not global, right?

				Pekka
