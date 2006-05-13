Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWEMMau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWEMMau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWEMMau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:30:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932410AbWEMMau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:30:50 -0400
Date: Sat, 13 May 2006 05:27:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception
 gates
Message-Id: <20060513052740.54d8cbff.akpm@osdl.org>
In-Reply-To: <20060509085154.441800000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085154.441800000@sous-sol.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:16 -0700
Chris Wright <chrisw@sous-sol.org> wrote:

> --- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_pre.h
> +++ linus-2.6/include/asm-i386/mach-xen/setup_arch_pre.h
> @@ -5,6 +5,8 @@
>  struct start_info *xen_start_info;
>  EXPORT_SYMBOL(xen_start_info);
>  
> +struct trap_info xen_trap_table[257];
> +
>  /*
>   * Point at the empty zero page to start with. We map the real shared_info
>   * page as soon as fixmap is up and running.

Is there any particular reason why things-which-should-be-in-a-C-file are
present in a .h file?
