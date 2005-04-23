Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVDWX7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVDWX7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDWX7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:59:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:60117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbVDWX7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:59:41 -0400
Date: Sat, 23 Apr 2005 16:56:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport panic_timeout
Message-Id: <20050423165609.47087f9a.akpm@osdl.org>
In-Reply-To: <20050415151048.GL5456@stusta.de>
References: <20050415151048.GL5456@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I didn't find any possible modular usage in the kernel.
> 

panic_timeout has many in-kernel users and it is used from within a module
in 2.4.30.

Hence it is easily possible that some out-of-tree code is dependent upon
this export, hence I shan't be applying this patch.

> 
> --- linux-2.6.11-rc5-mm1-full/kernel/panic.c.old	2005-03-04 00:54:46.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/panic.c	2005-03-04 00:54:54.000000000 +0100
> @@ -24,8 +24,6 @@
>  int panic_on_oops;
>  int tainted;
>  
> -EXPORT_SYMBOL(panic_timeout);
> -
>  struct notifier_block *panic_notifier_list;
>  
>  EXPORT_SYMBOL(panic_notifier_list);
