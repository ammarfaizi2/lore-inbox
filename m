Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbUDZQsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDZQsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUDZQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:48:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34759 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263040AbUDZQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:47:01 -0400
Date: Mon, 26 Apr 2004 09:46:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       valentin@rocklinux-consulting.de
Subject: Re: [PATCH] fix compilation of ppc embedded configs
Message-ID: <20040426164641.GB19246@smtp.west.cox.net>
References: <20040422.103620.607961025.rene@rocklinux-consulting.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422.103620.607961025.rene@rocklinux-consulting.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 10:36:20AM +0200, Rene Rebe wrote:

> Hi,
> 
> the attached patch converts some arch/ppc/platforms/*_setup.c files to
> the new openpic_init argument cleanups and additional fixes the
> includes of platforms/pplus.c.
> 
> prpmc750 config and pplus config tested and booted.

I'd like to see the hunks that aren't tested dropped as I strongly
suspect there's more subtle errors in these platforms, if the call to
openpic_init hasn't been changed.  Also, why is:

> --- linux-2.6.6-rc2/arch/ppc/platforms/pplus.c	2004-04-22 10:27:16.000000000 +0200
> +++ linux-2.6.5-wip/arch/ppc/platforms/pplus.c	2004-04-18 22:36:08.000000000 +0200
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> +#include <linux/initrd.h>
>  #include <linux/ioport.h>
>  #include <linux/console.h>
>  #include <linux/pci.h>

Needed?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
