Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSCRGfL>; Mon, 18 Mar 2002 01:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312213AbSCRGfC>; Mon, 18 Mar 2002 01:35:02 -0500
Received: from rj.sgi.com ([204.94.215.100]:46566 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S312212AbSCRGep>;
	Mon, 18 Mar 2002 01:34:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jason Li <jli@extremenetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work 
In-Reply-To: Your message of "Sun, 17 Mar 2002 22:25:16 -0800."
             <3C95884C.DCD11F6F@extremenetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Mar 2002 17:34:35 +1100
Message-ID: <2643.1016433275@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002 22:25:16 -0800, 
Jason Li <jli@extremenetworks.com> wrote:
>int (*fdbIoSwitchHook)(
>                           unsigned long arg0,
>                           unsigned long arg1,
>                           unsigned long arg2)=NULL;
>EXPORT_SYMBOL(fdbIoSwitchHook);
>gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>-march=i686    -c -o br_ioctl.o br_ioctl.c
>br_ioctl.c:26: warning: type defaults to `int' in declaration of
>`EXPORT_SYMBOL'

#include <linux/module.h>

Also add br_ioctl.o to export-objs in Makefile.

