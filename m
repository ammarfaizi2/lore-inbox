Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbUKUVOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUKUVOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKUVOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:14:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:47522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261808AbUKUVN4 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:13:56 -0500
Date: Sun, 21 Nov 2004 13:13:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux-Kernel@vger.kernel.org, AKPM@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 2/4 mm/swap.c cleanup
Message-Id: <20041121131343.333716cd.akpm@osdl.org>
In-Reply-To: <16800.47052.733779.713175@gargle.gargle.HOWL>
References: <16800.47052.733779.713175@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> +#define pagevec_for_each_page(_v, _i, _p, _z)				\
>  +for (_i = 0, _z = NULL;							\
>  +     ((_i) < pagevec_count(_v) && (__guardloop(_v, _i, _p, _z), 1)) ||	\
>  +     (__postloop(_v, _i, _p, _z), 0);					\
>  +     (_i)++)

Sorry, this looks more like a dirtyup to me ;)
