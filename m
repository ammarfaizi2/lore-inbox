Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUFIAmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUFIAmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUFIAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:42:32 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:9100 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265489AbUFIAm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:42:29 -0400
Date: Wed, 9 Jun 2004 02:40:43 +0200
To: Steve Hemond <steve.hemond@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inserting a module (2.6 kernel)
Message-ID: <20040609004043.GA1380@mars>
References: <20040608203342.2aa2522c.steve.hemond@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608203342.2aa2522c.steve.hemond@sympatico.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 08:33:42PM -0400, Steve Hemond wrote:
> Hi people,
> 
> I am new to kernel module writing and I base myself on the Linux Device Drivers book from O'reilly. I have written this simple module :
> 
> #include <linux/module.h>
> 
> int init_module(void)
> {
>   printk("<1>Module inserted\n");
>   return 0;
> }
> 
> void cleanup_module(void)
> {
>   printk("<1>Module removed\n");
> }

http://lwn.net/Articles/21817/

> And this is the Makefile :
> 
> KERNELDIR = /usr/src/linux
> 
> include $(KERNELDIR)/.config
> 
> CFLAGS = -D__KERNEL__ -DMODULE -I$(KERNELDIR)/include \
>         -O -Wall
> 
> ifdef CONFIG_SMP
>         CFLAGS += -D__SMP__ -DSMP
> endif
> 
> all : moduletest.o
> 
> clean :
>         rm -f *.o *~ core
> 
 
http://lwn.net/Articles/21823/

> And look at this :
> 
> bash-2.05b# make
> gcc -D__KERNEL__ -DMODULE -I/usr/src/linux/include -O -Wall   -c -o moduletest.o moduletest.c
> bash-2.05b# insmod ./moduletest.o
> insmod: error inserting './moduletest.o': -1 Invalid module format
 
http://kernel.org/pub/linux/utils/kernel/module-init-tools/
http://lwn.net/Articles/22197/   "Kernel version checking"

> Anyone know what needs to be added or changed for kernel 2.6, or maybe its simply my own mistake?
> 
> (By the way, if you know of a kernel-beginner mailing list that would be better suited about this, tell me)

http://kernelnewbies.org/mailinglist.php3

  $ echo subscribe kernelnewbies | mail listar@nl.linux.org

> Thanks a lot in advance,
> 
> Best regards,
> 
> Steve

	Arthur
