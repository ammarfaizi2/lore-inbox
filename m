Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUKIUvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUKIUvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUKIUvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:51:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:34503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261671AbUKIUu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:50:59 -0500
Date: Tue, 9 Nov 2004 12:55:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Message-Id: <20041109125507.4bc49b3c.akpm@osdl.org>
In-Reply-To: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> When fully configured, some POWER5 boxes can have much more than 4 IDE
> interfaces. Increase the limit to reflect this.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> diff -puN include/asm-ppc64/ide.h~bump_ide_hwifs include/asm-ppc64/ide.h
> --- gr_work/include/asm-ppc64/ide.h~bump_ide_hwifs	2004-08-25 08:11:54.357759525 -0500
> +++ gr_work-anton/include/asm-ppc64/ide.h	2004-08-25 08:11:54.366758100 -0500
> @@ -19,7 +19,7 @@
>  #ifdef __KERNEL__
>  
>  #ifndef MAX_HWIFS
> -# define MAX_HWIFS	4
> +# define MAX_HWIFS	16
>  #endif

hrmph.  That costs 50kbytes, excluding ide-tape.  It's worth a config
variable, I think.

