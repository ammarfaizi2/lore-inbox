Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVIPXv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVIPXv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIPXv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:51:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbVIPXv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:51:28 -0400
Date: Fri, 16 Sep 2005 16:50:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix epoll delayed initialization bug ...
Message-Id: <20050916165053.2dec0a6b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
>
> diff -Nru linux-2.6.13.vanilla/fs/eventpoll.c linux-2.6.13/fs/eventpoll.c
>  --- linux-2.6.13.vanilla/fs/eventpoll.c	2005-09-16 15:20:46.000000000 -0700
>  +++ linux-2.6.13/fs/eventpoll.c	2005-09-16 15:21:08.000000000 -0700
>  @@ -231,8 +231,9 @@
> 
>    static void ep_poll_safewake_init(struct poll_safewake *psw);
>    static void ep_poll_safewake(struct poll_safewake *psw, wait_queue_head_t *wq);
>  -static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
>  -static int ep_file_init(struct file *file);
>  +static int ep_getfd(int *efd, struct inode **einode, struct file **efile,
>  +		    struct eventpoll *ep);
>  +static int ep_alloc(struct eventpoll **pep);

Sigh.  Space-stuffing strikes again.  Please resend as an attachment.

The number of whitespace-buggered patches which are coming in is just
getting out of control lately.

Even `patch -l' tossed four rejects, so there may be something else wrong
in this one.

