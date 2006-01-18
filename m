Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWARBQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWARBQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWARBQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932443AbWARBQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:16:32 -0500
Date: Tue, 17 Jan 2006 17:18:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Extract inode_inc_count(), inode_dec_count()
Message-Id: <20060117171828.76d481bd.akpm@osdl.org>
In-Reply-To: <20060118003453.GB24835@mipter.zuzino.mipt.ru>
References: <20060118003453.GB24835@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> +static inline void inode_inc_count(struct inode *inode)
> +{
> +	inode->i_nlink++;
> +	mark_inode_dirty(inode);
> +}

hm, OK.  I think I'll switch these all to inode_inc_link_count(), to
clearly distinguish them from the various functions which diddle ->i_count.
