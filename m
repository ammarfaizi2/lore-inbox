Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRLDQly>; Tue, 4 Dec 2001 11:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLDQlp>; Tue, 4 Dec 2001 11:41:45 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:60619 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S280984AbRLDQlk> convert rfc822-to-8bit; Tue, 4 Dec 2001 11:41:40 -0500
Message-Id: <sc0c9a91.035@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Tue, 04 Dec 2001 09:42:38 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <nmundi@karthika.com>, <linux-kernel@vger.kernel.org>
Cc: <apiggyjj@yahoo.ca>
Subject: Re: Insmod problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to define the __KERNEL__ and MODULE symbols

#define __KERNEL__
#define MODULE


>>> Nav Mundi <nmundi@karthika.com> 12/04/01 09:33AM >>>
What are we doing wrong? - Nav & Michael
**************************************************

hello.c Source:

#include "/home/mzhu/linux/include/linux/config.h" 
/*retrieve the CONFIG_* macros */
#if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
#define MODVERSIONS  /* force it on */
#endif

#ifdef MODVERSIONS
#include "/home/mzhu/linux/include/linux/modversions.h"
#endif

#include "/home/mzhu/linux/include/linux/module.h"

int init_module(void)  { printk("<1>Hello, world\n");  return 0; }
void cleanup_module(void) { printk("<1>Goodbye cruel world\n"); }

Output:

#>gcc -D_KERNEL_ -DMODULE -c hello.c

[This builds the hello.o file. ]

#>insmod hello.o

hello.o : unresolved symbol printk
hello.o : Note: modules without a GPL compatible license cannot use 
GPONLY_symbols




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

