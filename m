Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVALWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVALWdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVALWdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:33:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:63621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVALWcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:32:13 -0500
Date: Wed, 12 Jan 2005 14:36:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/11] FUSE - core
Message-Id: <20050112143652.6adfcc1b.akpm@osdl.org>
In-Reply-To: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu>
References: <E1CoOpP-0003Jb-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> +static int fuse_fill_super(struct super_block *sb, void *data, int silent)
> +{
> ...
> +	if (!inc_mount_count() && current->uid != 0)
> +		goto err;

The open-coded current->uid test needs to go.  capable(CAP_SYS_ADMIN)?
