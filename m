Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUHFL6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUHFL6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHFL6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:58:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:56242 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265833AbUHFL6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:58:31 -0400
X-Authenticated: #1725425
Date: Fri, 6 Aug 2004 14:00:12 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: James Morris <jmorris@redhat.com>
Cc: torvalds@osdl.org, davem@redhat.com, linux-kernel@vger.kernel.org,
       clemens@endorphin.org
Subject: Re: [PATCH] Re-implemented i586 asm AES
Message-Id: <20040806140012.2dbd92bd.Ballarin.Marc@gmx.de>
In-Reply-To: <Xine.LNX.4.44.0408060411340.21666-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0408060411340.21666-100000@dhcp83-76.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 04:24:08 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> This code is a rework of the original Gladman AES code, and does not
> include any supposed BSD licensed work by Jari Ruusu.
> 

Will this code work with CONFIG_REGPARM=y ?

> +
> +// An AES (Rijndael) implementation for the Pentium MMX family using
> the NASM+// assembler <http://www.web-sites.co.uk/nasm/>. This version
> only implements+// the standard AES block length (128 bits, 16 bytes)
> with the same interface+// as that used in my C/C++ implementation.  
> This code does not preserve the+// eax, ecx or edx registers or the
> artihmetic status flags. However, the ebx, +// esi, edi, and ebp
> registers are preserved across calls.    Only encryption+// and
> decryption are implemented here, the key schedule code being that
> from+// compiling aes.c with USE_ASM defined.  This code uses VC++
> register saving+// conentions// if it is used with another compiler, its
> conventions for using+// and saving registers will need to be checked.
> +

This comment seems partly obsolete.

>  config CRYPTO_AES
>  	tristate "AES cipher algorithms"
> -	depends on CRYPTO
> +	depends on CRYPTO && !(X86 && !X86_64)
>  	help

Does it work on x86 CPUs without MMX?

Regards
