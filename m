Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUBPUm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265918AbUBPUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:42:28 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:10615 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265915AbUBPUmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:42:25 -0500
Date: Mon, 16 Feb 2004 21:58:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pratik Solanki <pratik.solanki@timesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor cross-compile issues
Message-ID: <20040216205800.GC2977@mars.ravnborg.org>
Mail-Followup-To: Pratik Solanki <pratik.solanki@timesys.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4027B7D3.2020107@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4027B7D3.2020107@timesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 11:39:47AM -0500, Pratik Solanki wrote:
> Attached are 2 patches
> 
> asm-boot.patch - Fixes include path for build.c so that it finds 
> asm/boot.h. /usr/include/asm/boot.h may not be present when 
> cross-compiling on a non-Linux machine.
OK - but see minor comemnt.

 
> shell.patch - Use $(CONFIG_SHELL) instead of sh.
OK

	Sam

> ===== arch/i386/boot/Makefile 1.28 vs edited =====
> --- 1.28/arch/i386/boot/Makefile	Thu Sep 11 06:01:23 2003
> +++ edited/arch/i386/boot/Makefile	Thu Feb  5 15:56:28 2004
> @@ -31,6 +31,8 @@
>  
>  host-progs	:= tools/build
>  
> +HOSTCFLAGS_build.o := -I$(TOPDIR)/include
Do not use absolute paths here.

> +HOSTCFLAGS_build.o := -Iinclude
Is the preferred way to do it.

	Sam
