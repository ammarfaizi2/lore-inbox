Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSEKI3o>; Sat, 11 May 2002 04:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314600AbSEKI3n>; Sat, 11 May 2002 04:29:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38409 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314597AbSEKI3m>; Sat, 11 May 2002 04:29:42 -0400
Date: Sat, 11 May 2002 09:29:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
Message-ID: <20020511092935.A16828@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com> <3CDC6906.B0288387@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 05:42:46PM -0700, george anzinger wrote:
> diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in linux/arch/arm/vmlinux-armo.lds.in
> --- linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in	Tue May  7 15:59:35 2002
> +++ linux/arch/arm/vmlinux-armo.lds.in	Fri May 10 17:07:31 2002
> @@ -4,6 +4,7 @@
>   */
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
> +jiffies = jiffies_64 + 4;
>  SECTIONS
>  {
>  	. = TEXTADDR;
> diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in linux/arch/arm/vmlinux-armv.lds.in
> --- linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in	Tue May  7 15:59:35 2002
> +++ linux/arch/arm/vmlinux-armv.lds.in	Fri May 10 17:07:34 2002
> @@ -4,6 +4,7 @@
>   */
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
> +jiffies = jiffies_64 + 4;
>  SECTIONS
>  {
>  	. = TEXTADDR;

Eurgh.  This seems to be a popular misconception.  What makes you think
ARM is big endian, or was it just a guess?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

