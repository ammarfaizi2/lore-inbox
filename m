Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRLDRL0>; Tue, 4 Dec 2001 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281199AbRLDRIW>; Tue, 4 Dec 2001 12:08:22 -0500
Received: from web20209.mail.yahoo.com ([216.136.226.64]:35337 "HELO
	web20209.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281910AbRLDRGo>; Tue, 4 Dec 2001 12:06:44 -0500
Message-ID: <20011204170642.78487.qmail@web20209.mail.yahoo.com>
Date: Tue, 4 Dec 2001 12:06:42 -0500 (EST)
From: Michael Zhu <apiggyjj@yahoo.ca>
Reply-To: apiggyjj@yahoo.ca
Subject: Re: Insmod problems
To: Tyler BIRD <BIRDTY@uvsc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sc0c9a91.036@mail-smtp.uvsc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've define these two when I compile the module. The
command line is:

gcc -D_KERNEL_ -DMODULE -c hello.c


--- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> You need to define the __KERNEL__ and MODULE symbols
> 
> #define __KERNEL__
> #define MODULE
> 
> 
> >>> Nav Mundi <nmundi@karthika.com> 12/04/01 09:33AM
> >>>
> What are we doing wrong? - Nav & Michael
> **************************************************
> 
> hello.c Source:
> 
> #include "/home/mzhu/linux/include/linux/config.h" 
> /*retrieve the CONFIG_* macros */
> #if defined(CONFIG_MODVERSIONS) &&
> !defined(MODVERSIONS)
> #define MODVERSIONS  /* force it on */
> #endif
> 
> #ifdef MODVERSIONS
> #include
> "/home/mzhu/linux/include/linux/modversions.h"
> #endif
> 
> #include "/home/mzhu/linux/include/linux/module.h"
> 
> int init_module(void)  { printk("<1>Hello,
> world\n");  return 0; }
> void cleanup_module(void) { printk("<1>Goodbye cruel
> world\n"); }
> 
> Output:
> 
> #>gcc -D_KERNEL_ -DMODULE -c hello.c
> 
> [This builds the hello.o file. ]
> 
> #>insmod hello.o
> 
> hello.o : unresolved symbol printk
> hello.o : Note: modules without a GPL compatible
> license cannot use 
> GPONLY_symbols
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/
> 


______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
