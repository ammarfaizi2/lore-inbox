Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314292AbSEBJRc>; Thu, 2 May 2002 05:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314294AbSEBJRb>; Thu, 2 May 2002 05:17:31 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:11276 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314292AbSEBJRa>; Thu, 2 May 2002 05:17:30 -0400
Date: Thu, 2 May 2002 10:17:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: AMD PowerNow booboo in 2.4.19-pre7-ac3
Message-ID: <20020502101723.B23709@flint.arm.linux.org.uk>
In-Reply-To: <20020502085137.GP14678@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 06:51:37PM +1000, CaT wrote:
> --- arch/i386/kernel/amdk6plus.c.old    Thu May  2 18:51:13 2002
> +++ arch/i386/kernel/amdk6plus.c        Thu May  2 18:51:17 2002
> @@ -117,4 +117,4 @@
>  MODULE_LICENSE ("GPL");
>  module_init(PowerNow_k6plus_init);
>  module_exit(PowerNow_k6plus_exit);
> -__initcall (PowerNOW_k6plus_init);
> +__initcall (PowerNow_k6plus_init);
> 

Hmm, that looks really odd - module_init() should be identical to __initcall
when built into the kernel.  Copied to the cpufreq list.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

