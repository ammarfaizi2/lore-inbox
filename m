Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTBESNO>; Wed, 5 Feb 2003 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTBESNO>; Wed, 5 Feb 2003 13:13:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:59284 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262807AbTBESNM>;
	Wed, 5 Feb 2003 13:13:12 -0500
Date: Wed, 5 Feb 2003 10:23:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-Id: <20030205102308.68899bc3.akpm@digeo.com>
In-Reply-To: <20030205174021.GE19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 18:22:41.0104 (UTC) FILETIME=[91B7CD00:01C2CD43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  void jfs_truncate(struct inode *ip)
>  {
> -       jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
> +       jfs_info("jfs_truncate: size = 0x%lx", (ulong) ip->i_size);
> 
>         nobh_truncate_page(ip->i_mapping, ip->i_size);
> 	^^^^^^^^^^^^^^^^^^

This is the correct version.  Since 2.5.59, jfs was switched over to not use
buffer_heads.

