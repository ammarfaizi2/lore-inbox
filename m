Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRLDQfz>; Tue, 4 Dec 2001 11:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281027AbRLDQf1>; Tue, 4 Dec 2001 11:35:27 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:32737 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S280967AbRLDQdn>; Tue, 4 Dec 2001 11:33:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nav Mundi <nmundi@karthika.com>
To: linux-kernel@vger.kernel.org
Subject: Insmod problems
Date: Tue, 4 Dec 2001 11:33:30 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Michael Zhu <apiggyjj@yahoo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011204163337.ZIZ21717.tomts13-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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




