Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUBVSss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 13:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUBVSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 13:48:47 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:52145 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S261726AbUBVSsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 13:48:43 -0500
Subject: Re:
From: Larry Reaves <larry@moonshinecomputers.com>
To: redzic fadil <redzic_fadil@hotmail.com>
In-Reply-To: <BAY8-F58uoHWh7qdDZ700010d93@hotmail.com>
References: <BAY8-F58uoHWh7qdDZ700010d93@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1077475719.5903.34.camel@tux.moonshinecomputers.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 22 Feb 2004 13:48:39 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest that you read
http://linuxdevices.com/articles/AT4389927951.html it is an article
about the differences between modules for 2.4 and 2.6.  Basically all
you need to do to get it to work is delete your Makefile and create a
new one with only this line:
obj-m := hello.o
and then issue the following command:
make -C /usr/src/linux-2.6.3 SUBDIRS=$PWD modules
your module compiles fine on my box using this method

On Sun, 2004-02-22 at 12:51, redzic fadil wrote:
> hello
> 
> 
> I hope I don't disturb,
> 
> 
> I have tried to compile the hello.c module under kernel 2.6.3.
> And I'd like to insert the hello.o module in the kernel.
> But this doesn't work with kernel 2.6.3 .
> 
> I have compiled this module with kernel 2.4.* and it is well.
> 
> Also I cannot include the header file module.h, because I get error 
> messages.
> 
> my module:
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/init.h>
> 
> 
> int initial_module (void)
> {
> 	printk("\ninitial module\n");
> 	return (0);
> }
> 
> void delete_module (void)
> {
> 	printk("\ndelete module\n");
> }
> 
> module_init(initial_module);
> module_exit(delete_module);
> 
> 
> my Makefile:
> CC=gcc
> CFLAGS=-isystem /lib/modules/`uname -r`/build/include -O2 -D__KERNEL__ 
> -DMODULE
> all: hello.o
> 
> If you have any idea please send an E-Mail:  redzic_fadil@hotmail.com
> 
> thanks
> 
> _________________________________________________________________
> Die ultimative Fan-Seite für den MSN Messenger http://www.ilovemessenger.de
> Emoticons und Hintergründe kostenlos downloaden!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Larry Reaves <larry@moonshinecomputers.com>

