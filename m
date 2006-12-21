Return-Path: <linux-kernel-owner+w=401wt.eu-S1422631AbWLUDh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWLUDh2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWLUDh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:37:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34386 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422631AbWLUDh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:37:27 -0500
Date: Wed, 20 Dec 2006 19:36:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH] ppc : Use syslog macro for the printk log level.
Message-Id: <20061220193642.76a25dbf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612181434220.3836@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612181658070.8277@localhost.localdomain>
	<Pine.LNX.4.64N.0612181434220.3836@attu4.cs.washington.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 14:36:23 -0800 (PST)
David Rientjes <rientjes@cs.washington.edu> wrote:

> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -18,13 +18,15 @@ #include <asm/thread_info.h>
>  #include <asm/vfpmacros.h>
>  #include "../kernel/entry-header.S"
>  
> +#define KERN_DEBUG	"<7>"
> +

These definitions should be available to assembly code via inclusion of
kernel.h?
