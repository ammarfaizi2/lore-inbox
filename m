Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289244AbSANOQO>; Mon, 14 Jan 2002 09:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289246AbSANOQE>; Mon, 14 Jan 2002 09:16:04 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:25044 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289244AbSANOPs>; Mon, 14 Jan 2002 09:15:48 -0500
Message-ID: <3C42E811.309E5040@redhat.com>
Date: Mon, 14 Jan 2002 14:15:45 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Zhu <mylinuxk@yahoo.ca>, linux-kernel@vger.kernel.org
Subject: Re: Recompile the loop device
In-Reply-To: <20020114140754.36133.qmail@web14902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu wrote:
> 
> Hello, has anyone recompiled the loop device? I had a
> problem when trying to load the recompiled loop.o into
> the kernel. When I use the insmod to load the loop.o,
> the system always return "loop.o: unresolved external
> __put_user_bad". What is wrong? I found that the
> __put_user_bad() was defined in the <asm/uaccess.h> as
> "extern void __put_user_bad(void);". But I couldn't
> found the source code of this function. I don't know
> why. Can I define my own __put_user_bad() function in
> my recompiled loop.c?
> 
> Another question. My recompiled loop.o is about 25K.
> But I found that the loop.o in the
> "linux/drivers/block" directory is only 15K. What is
> the reason of this difference? I use the following
> command line to compile the loop.c file.
> 
> gcc -D__KERNEL__ -I/home/mzhu/linux/include -Wall
> -DMODULE -DMODVERSIONS -include
> /home/mzhu/linux/include/linux/modversions.h -c loop.c
> 
> Am I right? I can compile the loop.c and create the
> loop.o successfully. But I couldn't load it.
>

I think this is one of the FAQ items: you forgot -O2
