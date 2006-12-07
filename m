Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937825AbWLGAJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937825AbWLGAJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937826AbWLGAJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:09:56 -0500
Received: from mail.velocitynet.com.au ([203.17.154.25]:58057 "EHLO
	m0.velocity.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937825AbWLGAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:09:55 -0500
Message-ID: <45775B34.3030902@iinet.net.au>
Date: Thu, 07 Dec 2006 11:07:16 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] A few small additions and corrections to README
References: <200612070045.58396.jesper.juhl@gmail.com>
In-Reply-To: <200612070045.58396.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Hi,
>
> here's a small patch which 
>
>  - adds a few archs to the current list of supported platforms.
>  - adds a few missing slashes at the end of URLs.
>  - adds a few references to additional documentation.
>  - adds "make config" to the list of possible configuration targets.
>  - makes a few other minor changes.
>
> Please consider for inclusion.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  README                         |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
> diff --git a/README b/README
> index 3e26472..b656f00 100644
> --- a/README
> +++ b/README
> @@ -1,4 +1,4 @@
> -	Linux kernel release 2.6.xx <http://kernel.org>
> +	Linux kernel release 2.6.xx <http://kernel.org/>
>  
>  These are the release notes for Linux version 2.6.  Read them carefully,
>  as they tell you what this is all about, explain how to install the
> @@ -22,15 +22,17 @@ ON WHAT HARDWARE DOES IT RUN?
>  
>    Although originally developed first for 32-bit x86-based PCs (386 or higher),
>    today Linux also runs on (at least) the Compaq Alpha AXP, Sun SPARC and
> -  UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH,
> +  UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH, Cell,
>   
And AVR32 as of 2.6.19 :)
>    IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64, AXIS CRIS,
> -  and Renesas M32R architectures.
> +  Cris, Xtensa and Renesas M32R architectures.
>  
>    Linux is easily portable to most general-purpose 32- or 64-bit architectures
>    as long as they have a paged memory management unit (PMMU) and a port of the
>    GNU C compiler (gcc) (part of The GNU Compiler Collection, GCC). Linux has
>    also been ported to a number of architectures without a PMMU, although
>    functionality is then obviously somewhat limited.
> +  Linux has also been ported to itself. You can now run the kernel as a
> +  userspace application - this is called UserMode Linux (UML).
>  
>  DOCUMENTATION:
>  
> @@ -113,6 +115,7 @@ INSTALLING the kernel:
>     version 2.6.12.2 and want to jump to 2.6.12.3, you must first
>     reverse the 2.6.12.2 patch (that is, patch -R) _before_ applying
>     the 2.6.12.3 patch.
> +   You can read more on this in Documentation/applying-patches.txt
>  
>   - Make sure you have no stale .o files and dependencies lying around:
>  
> @@ -161,6 +164,7 @@ CONFIGURING the kernel:
>     only ask you for the answers to new questions.
>  
>   - Alternate configuration commands are:
> +	"make config"      Plain text interface.
>  	"make menuconfig"  Text based color menus, radiolists & dialogs.
>  	"make xconfig"     X windows (Qt) based configuration tool.
>  	"make gconfig"     X windows (Gtk) based configuration tool.
> @@ -303,8 +307,9 @@ IF SOMETHING GOES WRONG:
>  
>   - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
>     as is, otherwise you will have to use the "ksymoops" program to make
> -   sense of the dump.  This utility can be downloaded from
> -   ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops.
> +   sense of the dump (but compiling with CONFIG_KALLSYMS is usually preferred).
> +   This utility can be downloaded from
> +   ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/ .
>     Alternately you can do the dump lookup by hand:
>  
>   - In debugging dumps like the above, it helps enormously if you can
> @@ -336,7 +341,7 @@ IF SOMETHING GOES WRONG:
>  
>     If you for some reason cannot do the above (you have a pre-compiled
>     kernel image or similar), telling me as much about your setup as
> -   possible will help. 
> +   possible will help.  Please read the REPORTING-BUGS document for details.
>  
>   - Alternately, you can use gdb on a running kernel. (read-only; i.e. you
>     cannot change values or set break points.) To do this, first compile the
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

