Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJBRj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJBRj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJBRj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:39:26 -0400
Received: from xenotime.net ([66.160.160.81]:50606 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751125AbVJBRj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:39:26 -0400
Date: Sun, 2 Oct 2005 10:39:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-Id: <20051002103922.34dd287d.rdunlap@xenotime.net>
In-Reply-To: <20051002170318.GA22074@home.fluff.org>
References: <20051002170318.GA22074@home.fluff.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:

> If release_resource() is passed a NULL resource
> the kernel will OOPS.

does this actually happen?  you are fixing a real oops?
if so, what driver caused it?

btw, please use diff -p also (as in Documentation/SubmittingPatches)


> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> diff -urN -X ../dontdiff linux-2.6.14-rc3/kernel/resource.c linux-2.6.14-rc3-bjd1/kernel/resource.c
> --- linux-2.6.14-rc3/kernel/resource.c	2005-10-02 12:58:03.000000000 +0100
> +++ linux-2.6.14-rc3-bjd1/kernel/resource.c	2005-10-02 17:58:09.000000000 +0100
> @@ -181,6 +181,9 @@
>  {
>  	struct resource *tmp, **p;
>  
> +	if (!old)
> +		return 0;
> +
>  	p = &old->parent->child;
>  	for (;;) {
>  		tmp = *p;
> 


---
~Randy

