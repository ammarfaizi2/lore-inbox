Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268687AbTGIWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbTGIWs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:48:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268687AbTGIWrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:47:32 -0400
Message-ID: <3F0C9EE8.2050005@pobox.com>
Date: Wed, 09 Jul 2003 19:02:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.22-pre3: P3 and P4 for chekc_gcc
References: <20030709223355.GA2604@werewolf.able.es>
In-Reply-To: <20030709223355.GA2604@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
> +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
> @@ -53,11 +53,11 @@
>  endif
>  
>  ifdef CONFIG_MPENTIUMIII
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
>  endif
>  
>  ifdef CONFIG_MPENTIUM4
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
>  endif


Looks ok to me (I run this patch locally, and also am the one who 
submitted the check_gcc patch).

I haven't had any problems at all, but I'm curious if anyone has any 
negative feedback...  It's rather easy to be conservative and ignore the 
patch, since -march=i686 should always work.

	Jeff



