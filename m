Return-Path: <linux-kernel-owner+w=401wt.eu-S1422790AbWLUHSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWLUHSX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWLUHSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:18:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44870 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422790AbWLUHSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:18:22 -0500
Date: Wed, 20 Dec 2006 23:18:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH update9] drivers: add LCD support
Message-Id: <20061220231819.185c5236.akpm@osdl.org>
In-Reply-To: <20061220151000.27602c37.maxextreme@gmail.com>
References: <20061220151000.27602c37.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 15:10:00 +0100
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -65,6 +65,7 @@ config KS0108_DELAY
>  config CFAG12864B
>         tristate "CFAG12864B LCD"
>         depends on X86
> +       depends on FB
>         depends on KS0108
>         default n
>         ---help---
> @@ -74,6 +75,8 @@ config CFAG12864B
>           For help about how to wire your LCD to the parallel port,
>           check Documentation/auxdisplay/cfag12864b
> 
> +         Depends on the x86 arch and the framebuffer support.

heh, that was clever.

scripts/kconfig/conf -m arch/i386/Kconfig
drivers/auxdisplay/Kconfig:81:warning: multi-line strings not supported
drivers/auxdisplay/Kconfig:78: unknown option "Depends"
drivers/auxdisplay/Kconfig:80: unknown option "The"
drivers/auxdisplay/Kconfig:81: unknown option "It"
drivers/auxdisplay/Kconfig:82: unknown option "of"
drivers/auxdisplay/Kconfig:84: unknown option "To"
drivers/auxdisplay/Kconfig:85: unknown option "the"
drivers/auxdisplay/Kconfig:87: unknown option "If"
make[1]: *** [allmodconfig] Error 1

you broke Roman's parser.


Oh, your patch used spaces where tabs should have been.  Please don't do
that.

