Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283141AbRLDS0k>; Tue, 4 Dec 2001 13:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281624AbRLDSZZ>; Tue, 4 Dec 2001 13:25:25 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:48081 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S281566AbRLDSYA> convert rfc822-to-8bit; Tue, 4 Dec 2001 13:24:00 -0500
Message-Id: <sc0cb294.005@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Tue, 04 Dec 2001 11:24:38 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <CAmes@PacificDigital.com>, <apiggyjj@yahoo.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Insmod problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in linux/module.h header file
KERNEL_VERSION is defined.

what you need to do is make sure the directory /usr/include is a link
to the include directory in your kernel source and not the header files os some other kernel.

if you cant do that try something like this

___NO_VERSION___
#include <linux/module.h>
KERNEL_VERSION(major,minor,release)


read more on this site

http://www.xml.com/ldd/chapter/book/ch02.html#t2 


>>> Michael Zhu <apiggyjj@yahoo.ca> 12/04/01 11:13AM >>>
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

