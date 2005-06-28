Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVF1KHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVF1KHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 06:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVF1KHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 06:07:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261208AbVF1KHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 06:07:43 -0400
Date: Tue, 28 Jun 2005 03:06:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] fix semaphore handling in __unregister_chrdev_region
Message-Id: <20050628030643.4f3efd01.akpm@osdl.org>
In-Reply-To: <42C11EA0.2040307@cola.voip.idv.tw>
References: <42C11EA0.2040307@cola.voip.idv.tw>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen-chien Jesse Sung <jesse@cola.voip.idv.tw> wrote:
>
> Maybe this up() should be down() instead?
> 
> ...
>  --- linux-2.6.12-git9.orig/fs/char_dev.c	2005-06-28 16:43:27.000000000 +0800
>  +++ linux-2.6.12-git9/fs/char_dev.c	2005-06-28 16:52:01.000000000 +0800
>  @@ -150,7 +150,7 @@ __unregister_chrdev_region(unsigned majo
>   	struct char_device_struct *cd = NULL, **cp;
>   	int i = major_to_index(major);
>   
>  -	up(&chrdevs_lock);
>  +	down(&chrdevs_lock);

Heck.  Thanks.
