Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbULCFQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbULCFQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 00:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbULCFQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 00:16:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:1924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbULCFQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 00:16:49 -0500
Message-ID: <41AFF5F7.1040304@osdl.org>
Date: Thu, 02 Dec 2004 21:13:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephane Coulombe Bisson <stephcoul@aei.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: (kernel 2.6.9) insmod: -1 Invalid module format
References: <1102051062.5992.8.camel@localhost.localdomain>
In-Reply-To: <1102051062.5992.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Coulombe Bisson wrote:
> Hi,
> 
> I'm new to Linux module dev, I copied a very simple module from a book
> (http://lwn.net/Kernel/LDD2/ch02.lwn) and I can't insert it into the
> kernel.
> 
> I found hundreds of bug reports about it on google without any solution.
> I must be doing something wrong... 
> 
> /*----------mymodule.c-----------*/
> #define MODULE
> #include <linux/module.h>
> int init_module(void)  
> { printk("<1>Hello, world\n"); return 0; }
> void cleanup_module(void) 
> { printk("<1>Goodbye cruel world\n"); }
> /*----------EOF-----------*/
> 
> # gcc -c mymodule.c
> # insmod mymodule.o
> insmod: error inserting 'mymodule.o': -1 Invalid module format

a.  You need to use more than 'gcc -c module.c' to build a module
for Linux 2.6.x.  See current linux/Documentation/kbuild/*.txt .

b.  You load a module file named "mymodule.ko" for Linux 2.6.x,
not "mymodule.o".

c.  Make sure that you are using current module-init-tools package.


-- 
~Randy
