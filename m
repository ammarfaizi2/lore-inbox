Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVHRKMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVHRKMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVHRKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:12:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbVHRKME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:12:04 -0400
Date: Thu, 18 Aug 2005 03:10:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jesper.juhl@gmail.com
Subject: Re: [PATCH 2/7] rename locking functions - convert sema_init users
Message-Id: <20050818031039.545dd53e.akpm@osdl.org>
In-Reply-To: <200508180204.33470.jesper.juhl@gmail.com>
References: <200508180204.33470.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> --- linux-2.6.13-rc6-git9-orig/fs/xfs/linux-2.6/sema.h	2005-06-17 21:48:29.000000000 +0200
>  +++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/sema.h	2005-08-18 00:46:41.000000000 +0200
>  @@ -43,9 +43,9 @@
>   
>   typedef struct semaphore sema_t;
>   
>  -#define init_sema(sp, val, c, d)	sema_init(sp, val)
>  -#define initsema(sp, val)		sema_init(sp, val)
>  -#define initnsema(sp, val, name)	sema_init(sp, val)
>  +#define init_sema(sp, val, c, d)	init_sema(sp, val)
>  +#define initsema(sp, val)		init_sema(sp, val)
>  +#define initnsema(sp, val, name)	init_sema(sp, val)

Well that's pretty nonsensical.  I'll drop the patches - please don't send
things which haven't been compiled.

