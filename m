Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbULaJfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbULaJfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULaJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:35:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:31930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261834AbULaJf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:35:27 -0500
Date: Fri, 31 Dec 2004 01:34:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, SYSLINUX@zytor.com
Subject: Re: [PATCH] /proc/sys/kernel/bootloader_type
Message-Id: <20041231013443.313a3320.akpm@osdl.org>
In-Reply-To: <41D34E3A.3090708@zytor.com>
References: <41D34E3A.3090708@zytor.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
> This patch exports to userspace the boot loader ID which has been 
>  exported by (b)zImage boot loaders since boot protocol version 2.

Why does userspace need to know this?

>  --- linux-2.5/arch/i386/Makefile	24 Dec 2004 21:09:54 -0000	1.73
>  +++ linux-2.5/arch/i386/Makefile	28 Dec 2004 04:56:17 -0000
>  @@ -20,6 +20,10 @@
>   LDFLAGS_vmlinux :=
>   CHECKFLAGS	+= -D__i386__
>   
>  +# This allows compilation with an x86-64 compiler
>  +CC_M32		:= $(call cc-option,-m32)
>  +CC 		+= $(CC_M32)

Was this hunk deliberately a part of this patch?
