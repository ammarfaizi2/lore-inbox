Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWEZRaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWEZRaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWEZRaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:30:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751179AbWEZRaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:30:14 -0400
Date: Fri, 26 May 2006 10:29:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 20/33] readahead: initial method - expected read size
Message-Id: <20060526102934.1dd39296.akpm@osdl.org>
In-Reply-To: <348469546.16482@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469546.16482@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> backing_dev_info.ra_expect_bytes is dynamicly updated to be the expected
> read pages on start-of-file. It allows the initial readahead to be more
> aggressive and hence efficient.
> 
> 
> +void fastcall readahead_close(struct file *file)

eww, fastcall.

> +{
> +	struct inode *inode = file->f_dentry->d_inode;
> +	struct address_space *mapping = inode->i_mapping;
> +	struct backing_dev_info *bdi = mapping->backing_dev_info;
> +	unsigned long pos = file->f_pos;

f_pos is loff_t.

