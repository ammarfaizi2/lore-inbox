Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUIMA0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUIMA0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUIMA0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:26:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264346AbUIMA0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:26:51 -0400
Message-ID: <4144E93E.5030404@pobox.com>
Date: Sun, 12 Sep 2004 20:26:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
References: <200409110726.i8B7QTGn009468@hera.kernel.org>
In-Reply-To: <200409110726.i8B7QTGn009468@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> --- a/include/linux/compiler.h	2004-09-11 00:26:40 -07:00
> +++ b/include/linux/compiler.h	2004-09-11 00:26:40 -07:00
> @@ -6,13 +6,17 @@
>  # define __kernel	/* default address space */
>  # define __safe		__attribute__((safe))
>  # define __force	__attribute__((force))
> +# define __iomem	__attribute__((noderef, address_space(2)))

Dumb gcc attribute questions:

1) what does force do? it doesn't appear to be in gcc 3.3.3 docs.

2) is "volatile ... __force" redundant?

3) can we use 'malloc' attribute on kmalloc?

