Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263258AbSJCMNr>; Thu, 3 Oct 2002 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263261AbSJCMNr>; Thu, 3 Oct 2002 08:13:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5125 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263258AbSJCMNq>; Thu, 3 Oct 2002 08:13:46 -0400
Date: Thu, 3 Oct 2002 13:19:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: peterc@gelato.unsw.edu.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large Block Device patch part 5/4
Message-ID: <20021003131914.C2304@flint.arm.linux.org.uk>
References: <15771.55917.32838.890081@lemon.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15771.55917.32838.890081@lemon.gelato.unsw.EDU.AU>; from peterc@gelato.unsw.edu.au on Thu, Oct 03, 2002 at 03:49:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:49:33PM +1000, peterc@gelato.unsw.edu.au wrote:
> +#ifdef CONFIG_LBD
>  extern u64 __udivdi3(u64, u64);
>  extern u64 __umoddi3(u64, u64);
> +EXPORT_SYMBOL(__udivdi3);
> +EXPORT_SYMBOL(__umoddi3);
> +#endif
>  EXPORT_SYMBOL(md_size);
>  EXPORT_SYMBOL(register_md_personality);
>  EXPORT_SYMBOL(unregister_md_personality);
> @@ -3493,6 +3497,4 @@
>  EXPORT_SYMBOL(md_wakeup_thread);
>  EXPORT_SYMBOL(md_print_devices);
>  EXPORT_SYMBOL(md_interrupt_thread);
> -EXPORT_SYMBOL(__udivdi3);
> -EXPORT_SYMBOL(__umoddi3);
>  MODULE_LICENSE("GPL");

These exports should be performed by the architecture not by generic
drivers.

Please move them into all architectures.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

