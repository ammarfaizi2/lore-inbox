Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbTLWGyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 01:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbTLWGyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 01:54:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:45710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264963AbTLWGyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 01:54:47 -0500
Date: Mon, 22 Dec 2003 22:54:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: mtd@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix static build of drivers/mtd/chips/jedec_probe.c
Message-Id: <20031222225442.764d8d0e.akpm@osdl.org>
In-Reply-To: <3FE7D92A.1090205@develer.com>
References: <3FE7D92A.1090205@develer.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
> Hello,
> 
> one liner fix for building jedec_probe statically in m68knommu and possibly other archs.
> 
> Applies to 2.6.0.
> 
> 
> --- drivers/mtd/chips/jedec_probe.c	2003-12-23 06:50:51.842514068 +0100
> +++ drivers/mtd/chips/jedec_probe.c.orig	2003-12-23 06:51:15.512685112 +0100
> @@ -8,7 +8,6 @@
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <asm/io.h>
> 

Inclusion of init.h shouldn't break anything.   What is the error?

