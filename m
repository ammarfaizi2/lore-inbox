Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289725AbSAWHq2>; Wed, 23 Jan 2002 02:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289726AbSAWHqS>; Wed, 23 Jan 2002 02:46:18 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:55692 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S289725AbSAWHqG>; Wed, 23 Jan 2002 02:46:06 -0500
Date: Wed, 23 Jan 2002 10:45:50 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre3 -- aironet4500_core.c:2839:  In function `awc_init': incompatible types in return
Message-Id: <20020123104550.16b160b0.johnpol@2ka.mipt.ru>
In-Reply-To: <1011771248.24309.60.camel@stomata.megapathdsl.net>
In-Reply-To: <1011771248.24309.60.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2002 23:34:08 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> 
> make[2]: Entering directory `/usr/src/linux/drivers/net'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE  
> -DEXPORT_SYMTAB -c aironet4500_core.c aironet4500_core.c: In function
> `awc_init': aironet4500_core.c:2839: incompatible types in return
> aironet4500_core.c:2841: warning: control reaches end of non-void
> function make[2]: *** [aironet4500_core.o] Error 1

Try this patch, but it is given WITHOUT ANY WARRANTY.
I even cann't test to compile it.
And there is not ieee card here.
So, it was wrote with luck and common sense.
I hope it will help you.

P.S. If this is full bullshit... then i apologize and go learning Linux
kernel again...

--- ./drivers/net/aironet4500_core.c~   Sun Sep 30 23:26:06 2001
+++ ./drivers/net/aironet4500_core.c    Wed Jan 23 10:44:03 2002
@@ -2836,7 +2836,7 @@
        return 0; 
    final:
        printk(KERN_ERR "aironet init failed \n");
-       return NODEV;
+       return -1;
        
  };


	Evgeniy Polyakov ( s0mbre ).
