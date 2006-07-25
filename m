Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWGYHyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWGYHyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWGYHyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:54:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751449AbWGYHyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:54:24 -0400
Date: Tue, 25 Jul 2006 00:53:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: apgo@patchbomb.org (Arthur Othieno)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: make CONFIG_EFI depend on EXPERIMENTAL
Message-Id: <20060725005310.4877390d.akpm@osdl.org>
In-Reply-To: <20060720001321.GC8584@krypton>
References: <20060720001321.GC8584@krypton>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006 20:13:21 -0400
apgo@patchbomb.org (Arthur Othieno) wrote:

> It is labelled as such, but doesn't actually depend on EXPERIMENTAL.
> 
> Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
> ---
>  arch/i386/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index 84c1b29..8577043 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -673,7 +673,7 @@ config MTRR
>  
>  config EFI
>  	bool "Boot from EFI support (EXPERIMENTAL)"
> -	depends on ACPI
> +	depends on ACPI && EXPERIMENTAL
>  	default n
>  	---help---
>  	This enables the the kernel to boot on EFI platforms using

Some poor soul will surely wonder where his EFI support went to and why his
box won't boot.

So I went the other way and removed the " (EXPERIMENTAL)"
