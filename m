Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUGDATX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUGDATX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 20:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUGDATX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 20:19:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:23444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264798AbUGDATW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 20:19:22 -0400
Date: Sat, 3 Jul 2004 17:18:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?UGF3ZV9f?= Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [prefetch.h] warning: pointer of type `void *' used in
 arithmetic'
Message-Id: <20040703171811.1f10c5df.akpm@osdl.org>
In-Reply-To: <200407031832.34780.pluto@pld-linux.org>
References: <200407031832.34780.pluto@pld-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawe__ Sikora <pluto@pld-linux.org> wrote:
>
> warning killed.

>  --- /var/tmp/linux/include/linux/prefetch.h.orig	2004-06-16 07:20:25.000000000 +0200
>  +++ /var/tmp/linux/include/linux/prefetch.h	2004-07-03 18:28:10.478861720 +0200
>  @@ -59,7 +59,7 @@
>   {
>   #ifdef ARCH_HAS_PREFETCH
>   	char *cp;
>  -	char *end = addr + len;
>  +	char *end = (char *)addr + len;

What version of the compiler is generating this warning?
