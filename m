Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSATQSn>; Sun, 20 Jan 2002 11:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSATQSd>; Sun, 20 Jan 2002 11:18:33 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3312 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288787AbSATQS1>; Sun, 20 Jan 2002 11:18:27 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.44.0201201611030.20948-100000@mimas.fachschaften.tu-muenchen.de> 
In-Reply-To: <Pine.NEB.4.44.0201201611030.20948-100000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Jan 2002 16:15:02 +0000
Message-ID: <2385.1011543302@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  If your compiler is configured as a cross-compiler everything should
> work as expected. If you are trying to compile a Linux kernel with a
> gcc that is configured to build binaries for NetBSD this sounds evil. 

What if he's trying to build UML to run on NetBSD? What if the best QA'd 
cross-gcc he has available is a generic arm-elf-gcc and he doesn't want to 
rebuild and do a full test and release cycle on it just because a handful 
of the kernel header files assume __linux__ will be defined?

> I don't know (I never tried to compile a *BSD kernel).

If you don't know, who was it that typed 'This is definitely wrong' in your 
first mail? Your cat?

> But if yes please consider what the following parts of your patch change:
> -#ifndef __linux__ 
> +#ifndef __KERNEL__

Well, if he hadn't explicitly mentioned that he made header files which 
could be included by userspace use defined(__KERNEL__)||defined(__linux__)
then I'd understand what you meant. As it is, I don't. Please explain.

--
dwmw2


