Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268280AbTBMUTJ>; Thu, 13 Feb 2003 15:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268282AbTBMUTJ>; Thu, 13 Feb 2003 15:19:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268280AbTBMUTI>;
	Thu, 13 Feb 2003 15:19:08 -0500
Date: Thu, 13 Feb 2003 12:26:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting Kernel Symbols
Message-Id: <20030213122610.07bbadff.rddunlap@osdl.org>
In-Reply-To: <F131jJLAiVXqMLhudPJ0001e073@hotmail.com>
References: <F131jJLAiVXqMLhudPJ0001e073@hotmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003 20:22:48 +0000
"shesha bhushan" <bhushan_vadulas@hotmail.com> wrote:

| Hi,
|   I have written a new function in linux/fs/read_write.c and I want to make 
| the function avaliable to other kernel modules loaded using insmod.
| He is what I did:
| 1. Wrore the func my_func() in linux/fs/read_write.c
| 2. Used the macro EXPORT_SYMBOL(my_func) inside linux/fs/read_write.c
| 3. Have a signature of my_func in my_func.h
| 4. Include my_func.h in linux/fs/read_write.c and my_driver.c
| 5. Recompiled the kernel
| 6. Compiler my_driver as loadable module.
| 7. Brought my new kernel Up.
| 8 . Insmod my_driver.o
| Here I get the error "Unresolved symbol my_func"
| Can any one clarify this.

For what kernel version?

In 2.4.20, e.g., in linux/fs/Makefile, change the following line:

export-objs :=	filesystems.o open.o dcache.o buffer.o

to include read_write.o

--
~Randy
