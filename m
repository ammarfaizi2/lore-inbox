Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbTHZR4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTHZR4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:56:50 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39172 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261714AbTHZR4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:56:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: add check_gcc for P3/P4
Date: Tue, 26 Aug 2003 20:56:39 +0300
X-Mailer: KMail [version 1.4]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030826082437.GA2017@werewolf.able.es>
In-Reply-To: <20030826082437.GA2017@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308262056.39595.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 11:24, J.A. Magallon wrote:
> Hi.
>
> Resending for 2.4.23-pre ;)
>
> --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18
> 23:40:25.000000000 +0200
> +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000
> +0200
> @@ -53,11 +53,11 @@
>  endif
>
>  ifdef CONFIG_MPENTIUMIII
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
>  endif
>  Marcelo Tosatti <marcelo@conectiva.com.br>

This is a rather strange make statement

>  ifdef CONFIG_MPENTIUM4
> -CFLAGS += -march=i686
> +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
>  endif
>
>  ifdef CONFIG_MK6
--
vda
