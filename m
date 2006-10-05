Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWJEIxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJEIxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWJEIxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:53:50 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:53777 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751247AbWJEIxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:53:49 -0400
Date: Thu, 5 Oct 2006 10:53:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christer Weinigel <christer@weinigel.se>
Subject: Re: [patch 2.6.18+] MAINTAINERS - take over scx200-* and pc8736*
 drivers
Message-Id: <20061005105351.f791f4f1.khali@linux-fr.org>
In-Reply-To: <45248867.40903@gmail.com>
References: <45248867.40903@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

> Add MAINTAINERS entries for new scx200_hrt and pc8736x_gpio drivers, and 
> take over maintenance
> of scx200_gpio, authored by Christer Weinigel (which Ive hacked at), who 
> no longer has the hardware.
> Also take over hwmon/pc87360, authored by Jean Delvare, who's dropped 
> maintenance to dedicate
> more time to hwmon subsystem.

Yep, I'm fine with Jim taking over maintainerchip of the pc87360
hardware monitoring driver.

> 
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> ---
> 
> Christer acked this off-list already, in case he's too busy and misses 
> this one.
> 
>  MAINTAINERS                         |   41 
> ++++++++++++++++++++++++++++--------
> 
> 
> 
> diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.18-rc6-mm2-sk/MAINTAINERS doc-touches/MAINTAINERS
> --- linux-2.6.18-rc6-mm2-sk/MAINTAINERS	2006-09-12 09:39:29.000000000 -0600
> +++ doc-touches/MAINTAINERS	2006-10-04 22:03:09.000000000 -0600
> @@ -2151,6 +2151,11 @@ M:	emoenke@gwdg.de
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  
> +NSC_GPIO Common Methods Module (supports PC8736x_GPIO and SCX200_GPIO Drivers)

All other entries in this file are uppercase.

I also doubt that anyone will ever search for "common methods module",
I'm not even sure I understand what it means. What's really important
here are the driver names IMHO, and you already have added entries for
these below - isn't that sufficient?

> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +S:	Maintained
> +
>  NTFS FILESYSTEM
>  P:	Anton Altaparmakov
>  M:	aia21@cantab.net
> @@ -2262,6 +2267,17 @@ T:	git kernel.org:/pub/scm/linux/kernel/
>  T:	cvs cvs.parisc-linux.org:/var/cvs/linux-2.6
>  S:	Maintained
>  
> +PC87360 LM-SENSORS DRIVER
> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +L:	lm-sensors@lm-sensors.org
> +S:	Maintained

I'd prefer "HARDWARE MONITORING" rather than "LM-SENSORS", as all other
hwmon driver entries have. lm-sensors is really only the user-space
part now, and the kernel can live without it.

> +
> +PC8736x GPIO Driver

Uppercase.

> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +S:	Maintained
> +
>  PCI ERROR RECOVERY
>  P:	Linas Vepstas
>  M:	linas@austin.ibm.com
> @@ -2574,16 +2590,25 @@ L:	linux-scsi@vger.kernel.org
>  S:	Maintained
>  
>  SCTP PROTOCOL
> -P: Sridhar Samudrala
> -M: sri@us.ibm.com
> -L: lksctp-developers@lists.sourceforge.net
> -S: Supported
> +P:	Sridhar Samudrala
> +M:	sri@us.ibm.com
> +L:	lksctp-developers@lists.sourceforge.net
> +S:	Supported

This is noise for this patch, it should be sent as a seperate patch.

>  
>  SCx200 CPU SUPPORT
> -P:	Christer Weinigel
> -M:	christer@weinigel.se
> -W:	http://www.weinigel.se
> -S:	Supported
> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +S:	Odd Fixes
> +
> +SCx200 GPIO DRIVER
> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +S:	Maintained
> +
> +SCx200 HRT CLOCKSOURCE DRIVER
> +P:	Jim Cromie
> +M:	jim.cromie@gmail.com
> +S:	Maintained
>  
>  SECURITY CONTACT
>  P:	Security Officers
> 


-- 
Jean Delvare
