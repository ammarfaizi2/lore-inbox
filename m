Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263388AbTCUAiN>; Thu, 20 Mar 2003 19:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbTCUAiN>; Thu, 20 Mar 2003 19:38:13 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:36871 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S263388AbTCUAiL>; Thu, 20 Mar 2003 19:38:11 -0500
Message-ID: <3E7A6149.2010308@snapgear.com>
Date: Fri, 21 Mar 2003 10:48:09 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: 2.5.56: undefined reference to `_ebss' from drivers/mtd/maps/uclinux.c
References: <20030112095559.GT21826@fs.tum.de> <3E226969.5080406@snapgear.com> <20030320145927.GF11659@fs.tum.de> <20030320160008.GB3174@fs.tum.de>
In-Reply-To: <20030320160008.GB3174@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

This seems reasonable to me. It is after all targeted at uclinux.
I suspect noone with VM setups would be much interrested in using
it anyway.

Patch looks good to me.

Regards
Greg



Adrian Bunk wrote:
> On Thu, Mar 20, 2003 at 03:59:28PM +0100, Adrian Bunk wrote:
> 
>>...
>>It might not be a solution for the whole issue, but is it intentionally
>>that it's possible to enable CONFIG_MTD_UCLINUX on non-uClinux 
>>architectures or should an appropriate dependency be added to the 
>>Kconfig file?
> 
> 
> The following patch should do what I was thinking of:
> 
> --- linux-2.5.65-full/drivers/mtd/maps/Kconfig.old	2003-03-20 16:56:25.000000000 +0100
> +++ linux-2.5.65-full/drivers/mtd/maps/Kconfig	2003-03-20 16:56:45.000000000 +0100
> @@ -348,7 +348,7 @@
>  
>  config MTD_UCLINUX
>  	tristate "Generic uClinux RAM/ROM filesystem support"
> -	depends on MTD_PARTITIONS
> +	depends on MTD_PARTITIONS && !MMU
>  	help
>  	  Map driver to support image based filesystems for uClinux.
>  
> 
> 
> Any comments on whether this is correct?
> 
> 
> cu
> Adrian
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

