Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282404AbRLDSPk>; Tue, 4 Dec 2001 13:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283208AbRLDSOR>; Tue, 4 Dec 2001 13:14:17 -0500
Received: from web20210.mail.yahoo.com ([216.136.226.65]:14854 "HELO
	web20210.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282404AbRLDSNx>; Tue, 4 Dec 2001 13:13:53 -0500
Message-ID: <20011204181351.58929.qmail@web20210.mail.yahoo.com>
Date: Tue, 4 Dec 2001 13:13:51 -0500 (EST)
From: Michael Zhu <apiggyjj@yahoo.ca>
Reply-To: apiggyjj@yahoo.ca
Subject: RE: Insmod problems
To: Christine Ames <CAmes@PacificDigital.com>, Tyler BIRD <BIRDTY@uvsc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <81C25B579A82D31192BE00105A812084028931E9@AUGUSTA>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've changed my source file like this:
#define MODULE

#include <linux/module.h>

int init_module(void)  { printk("<1>Hello, world\n");
return 0; }
void cleanup_module(void) { printk("<1>Goodbye cruel
world\n"); }

And I use the following message to build the module.
But when I use insmod to load the module I got the
following error message:

hello.o : kernel-module version mismatch
         hello.o was compiled for kernel version
2.4.12
         while this kernel is version 2.4.8

What is wrong? My kernel version is 2.4.8. Is there
something wrong with the gcc compilier? My gcc
compilier is gcc-2.95.

Thanks to everyone. Your help is very beneficial to
me.

Michael

--- Christine Ames <CAmes@PacificDigital.com> wrote:
> > -----Original Message-----
> > From: Michael Zhu [mailto:apiggyjj@yahoo.ca]
> > Sent: Tuesday, December 04, 2001 9:07 AM
> 
> <snip>
> 
> > 
> > 
> > I've define these two when I compile the module.
> The
> > command line is:
> > 
> > gcc -D_KERNEL_ -DMODULE -c hello.c
> > 
> > 
> <snip>
> > 
> 
> See http://www.xml.com/ldd/chapter/book/ch02.html
> 
> Where your source should be similar to:
> 
> #define MODULE		// <- HERE!!! define MODULE 
> #include <linux/module.h>
> 
> int init_module(void)  { printk("<1>Hello,
> world\n"); return 0; }
> void cleanup_module(void) { printk("<1>Goodbye cruel
> world\n"); }
> 


______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
