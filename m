Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUAIU4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUAIU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:56:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:20418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbUAIU4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:56:09 -0500
Date: Fri, 9 Jan 2004 12:57:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
Message-Id: <20040109125718.5266c3f4.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0401091009440.21309@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> --- linux-2.6.1-rc2.pending/security/selinux/Makefile	2004-01-07 13:25:53.441124248 -0500
> +++ linux-2.6.1-rc2.w1/security/selinux/Makefile	2004-01-07 13:26:07.264022848 -0500
> @@ -6,5 +6,9 @@
>  
>  selinux-objs := avc.o hooks.o selinuxfs.o
>  
> +ifeq ($(CONFIG_SECURITY_NETWORK),y)
> +	selinux-objs += netif.o
> +endif
> +

The selinux makefiles seem a little unusual.  Can this not use the usual

	obj-$(CONFIG_FOO) += bar.o

?

Similarly, security/Makefile uses:

	ifeq ($(CONFIG_SECURITY_SELINUX),y)
		obj-$(CONFIG_SECURITY_SELINUX)	+= selinux/built-in.o
	endif

why the `ifeq'?
