Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVBIOge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVBIOge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVBIOge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:36:34 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:740 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261827AbVBIOgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:36:31 -0500
X-OB-Received: from unknown (208.36.123.33)
  by wfilter.us4.outblaze.com; 9 Feb 2005 14:36:29 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "Deepti Patel" <pateldeepti@lycos.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 09 Feb 2005 09:36:29 -0500
Subject: Getting errors in compilation of Hello World!
X-Originating-Ip: 67.85.157.5
X-Originating-Server: ws7-4.us4.outblaze.com
Message-Id: <20050209143629.1B610CA09D@ws7-4.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am new to Linux. I am tring to load a module in kernel of 'Fedora core2'.
I wrote a simple Hello world program and tring to compile it with Makefile. I tried 3 differnt types of make file but still it is giving me error. I will really appritiate any help.
 
Here is my Hello world program:

    #include <linux/init.h>
    #include <linux/module.h>
    #include <linux/kernel.h>

    static int hello_init(void)
    {
        printk(KERN_ALERT "Hello, world\n");
        return 0;
    }

    static void hello_exit(void)
    {
        printk(KERN_ALERT "Goodbye, cruel world\n");
    }

    module_init(hello_init);
    module_exit(hello_exit);


Here is the Makefile:

ifneq ($(KERNELRELEASE),)
obj-m:= hello.o

else
KDIR:= /lib/modules/$(shell uname -r)/build
PWD:= $(shell pwd)

default:
$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
endif

Problem here is once I type the command "make" at the shell prompt it gives the following message :

$ make: Nothing to be done for 'default'


-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

