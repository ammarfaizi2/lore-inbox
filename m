Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWGESLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWGESLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWGESLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:11:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964956AbWGESLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:11:14 -0400
Date: Wed, 5 Jul 2006 11:10:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
Message-Id: <20060705111057.a03fbcec.akpm@osdl.org>
In-Reply-To: <20060705175725.GL1605@parisc-linux.org>
References: <20060705175725.GL1605@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 11:57:25 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
> chipsets available.
> 
> ...
>
>  config AGP_SIS
>  	tristate "SiS chipset support"
> -	depends on AGP
> +	depends on AGP && X86

I never know what to do here.

Sure, the driver will not be used on that architecture.  But there is some
benefit in being able to cross-compile that driver on other architectures
anyway.  Sometimes it will pick up missed #includes, sometimes printk
mismatches, various other assumptions which might be OK for x86 right now
but which might cause problems in the future.

Need to balance a very minor con against some very minor pros ;)
