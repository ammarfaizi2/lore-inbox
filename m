Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWF3Jnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWF3Jnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWF3Jnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:43:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932165AbWF3Jnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:43:31 -0400
Date: Fri, 30 Jun 2006 02:43:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: arjan@infradead.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] add __[start|end]_rodata sections to
 asm-generic/sections.h
Message-Id: <20060630024321.71832c54.akpm@osdl.org>
In-Reply-To: <20060630090321.GA9457@osiris.boeblingen.de.ibm.com>
References: <20060630090321.GA9457@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 11:03:21 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Add __start_rodata and __end_rodata to sections.h to avoid extern declarations.
> Needed by s390 code (see following patch).
>
> Cc: Arjan van de Ven <arjan@infradead.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
>  include/asm-generic/sections.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 0b49f9e..962cad7 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -14,5 +14,6 @@ extern char _end[];
>  extern char __per_cpu_start[], __per_cpu_end[];
>  extern char __kprobes_text_start[], __kprobes_text_end[];
>  extern char __initdata_begin[], __initdata_end[];
> +extern char __start_rodata[], __end_rodata[];
>  

OK.  I'll queue this up and will clean up x86, parisc and x86_64 to suit.

The second patch could go via the shiny new s390 git tree if you like.  Or
I can handle it, but I don't know if it's a for-2.6.18 thing.

