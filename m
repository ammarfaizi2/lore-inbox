Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUL1VvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUL1VvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUL1VvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:51:03 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:12837 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261261AbUL1VvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:51:00 -0500
Date: Tue, 28 Dec 2004 22:52:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kai@germaschewski.name,
       sam@ravnborg.org
Subject: Re: [PATCH] make kernelrelease
Message-ID: <20041228215228.GB21591@mars.ravnborg.org>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, kai@germaschewski.name,
	sam@ravnborg.org
References: <20041221002815.GD28322@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221002815.GD28322@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 04:28:15PM -0800, Matt Mackall wrote:
> This patch makes it easy to programmatically get at the kernel
> makefile's idea of the kernel version from external scripts and
> makefiles with something like V=`make kernelrelease`.
> 
> Alternatives include parsing Makefile (errorprone and broken by things
> like localversion) and running the C preprocessor on version.h (which
> requires a) building version.h somewhere and b) is really ugly).
> 
> Index: l/Makefile
> ===================================================================
> --- l.orig/Makefile	2004-12-20 16:08:11.746716000 -0800
> +++ l/Makefile	2004-12-20 16:18:25.036696000 -0800
> @@ -1187,6 +1187,9 @@
>  	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
>  	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
>  
> +kernelrelease:
> +	@echo $(KERNELRELEASE)
> +
>  # FIXME Should go into a make.lib or something 
>  # ===========================================================================

Applied - thanks.

	Sam
