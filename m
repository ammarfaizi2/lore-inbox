Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWGIHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWGIHMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGIHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 03:12:36 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:59845 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S932087AbWGIHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 03:12:35 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Compile Error on 2.6.17-mm6
Date: Sun, 9 Jul 2006 03:20:15 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200607072222.31586.mreuther@umich.edu> <20060708204448.6914aaf9.akpm@osdl.org> <20060708213734.a204a044.rdunlap@xenotime.net>
In-Reply-To: <20060708213734.a204a044.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607090320.15632.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 12:37 am, Randy.Dunlap wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
>
> MICROCODE needs FW_LOADER functions.
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  arch/i386/Kconfig   |    1 +
>  arch/x86_64/Kconfig |    1 +
>  2 files changed, 2 insertions(+)
>
> --- linux-2617-mm6.orig/arch/x86_64/Kconfig
> +++ linux-2617-mm6/arch/x86_64/Kconfig
> @@ -159,6 +159,7 @@ config X86_GOOD_APIC
>
>  config MICROCODE
>  	tristate "/dev/cpu/microcode - Intel CPU microcode support"
> +	depends on FW_LOADER
>  	---help---
>  	  If you say Y here the 'File systems' section, you will be
>  	  able to update the microcode on Intel processors. You will
> --- linux-2617-mm6.orig/arch/i386/Kconfig
> +++ linux-2617-mm6/arch/i386/Kconfig
> @@ -399,6 +399,7 @@ config X86_REBOOTFIXUPS
>
>  config MICROCODE
>  	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> +	depends on FW_LOADER
>  	---help---
>  	  If you say Y here and also to "/dev file system support" in the
>  	  'File systems' section, you will be able to update the microcode on

This fixes the error. Thanks for your help!
Matt
