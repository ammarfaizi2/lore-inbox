Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWFNX2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWFNX2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWFNX2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:28:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:398 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965030AbWFNX2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:28:10 -0400
Date: Thu, 15 Jun 2006 01:27:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Nathan Scott <nathans@sgi.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  Slimming down struct inode
In-Reply-To: <17551.58643.704359.815153@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61.0606150127080.14257@yvahk01.tjqt.qr>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com>
 <448EC51B.6040404@argo.co.il> <20060614084155.C888012@wobbly.melbourne.sgi.com>
 <17551.58643.704359.815153@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Sorry, but why this operation is needed? Generic code (in fs/*.c)
>doesn't use ->i_blksize at all. If XFS wants to provide per-inode
>st_blksize, all it has to do is to store preferred buffer size in its
>file system specific inode (struct xfs_inode), and use something
>different from generic_fillattr() as its ->i_op->getattr() callback
>(xfs_vn_getattr()).
>
By the way, are there any significant userspace applications that use 
i_blksize/i_blkbits?


Jan Engelhardt
-- 
