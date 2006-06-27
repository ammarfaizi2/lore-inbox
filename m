Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWF0Qsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWF0Qsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWF0Qsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:48:55 -0400
Received: from xenotime.net ([66.160.160.81]:50649 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161200AbWF0Qss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:48:48 -0400
Date: Tue, 27 Jun 2006 09:51:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jonsmirl@gmail.com, adaplas@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH, trivial] Remove about 50 unneeded
 #includes in fbdev
Message-Id: <20060627095127.441c543e.rdunlap@xenotime.net>
In-Reply-To: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
References: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 12:19:07 -0400 Jon Smirl wrote:

> Remove about 50 unneeded #includes in fbdev

Does this that
(a) these drivers build without these header files explicitly #included
or
(b) these drivers don't use *any* APIs or data from these header files?

They may build (a) but still use the APIs, so (b) is the requirement/target.
(I.e., other header files could suck in the required headers.)


> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> 
> diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
> index db878fd..e498a54 100644
> --- a/drivers/video/aty/aty128fb.c
> +++ b/drivers/video/aty/aty128fb.c
> @@ -46,26 +46,14 @@
>   */
> 
> 
> -#include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/kernel.h>
>  #include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/slab.h>
> -#include <linux/vmalloc.h>
>  #include <linux/delay.h>
> -#include <linux/interrupt.h>
>  #include <asm/uaccess.h>
>   #include <linux/fb.h>
> -#include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/ioport.h>
>  #include <linux/console.h>
> -#include <linux/backlight.h>
> -#include <asm/io.h>
> 
>   #ifdef CONFIG_PPC_PMAC
>  #include <asm/machdep.h>
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index c5185f7..5f4c76c 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -49,26 +49,13 @@
>  ******************************************************************************/
> 
> 
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/slab.h>
> -#include <linux/vmalloc.h>
>  #include <linux/delay.h>
>  #include <linux/console.h>
>   #include <linux/fb.h>
> -#include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
>  #include <linux/backlight.h>
> 
> -#include <asm/io.h>
>  #include <asm/uaccess.h>
> 
>  #include <video/mach64.h>
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index c5ecbb0..56445ea 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -52,25 +52,6 @@
> 
>  #define RADEON_VERSION	"0.2.0"
> 
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/time.h>
> -#include <linux/fb.h>
> -#include <linux/ioport.h>
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/vmalloc.h>
> -#include <linux/device.h>
> -
> -#include <asm/io.h>
>  #include <asm/uaccess.h>
> 
>   #ifdef CONFIG_PPC_OF
> diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
> index a9d0414..4855c0a 100644
> --- a/drivers/video/aty/radeon_i2c.c
> +++ b/drivers/video/aty/radeon_i2c.c
> @@ -1,9 +1,3 @@
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/sched.h>
> -#include <linux/delay.h>
> -#include <linux/pci.h>
>   #include <linux/fb.h>
> 
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


---
~Randy
