Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269003AbTBZWn6>; Wed, 26 Feb 2003 17:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269030AbTBZWn6>; Wed, 26 Feb 2003 17:43:58 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:30086 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S269003AbTBZWn4>; Wed, 26 Feb 2003 17:43:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.5.62-1
Date: Thu, 27 Feb 2003 06:45:27 +0100
X-Mailer: KMail [version 1.3.2]
References: <200302261905.h1QJ5m221192@uml.karaya.com>
In-Reply-To: <200302261905.h1QJ5m221192@uml.karaya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030226225413.ACF29EAF62@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 20:05, Jeff Dike wrote:
> This patch updates UML to 2.5.63...

Built and booted.  However, without CONFIG_MODULES=y it doesn't build:

gcc -Wp,-MD,arch/um/sys-i386/.module.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE 
-Iarch/um/include -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask 
-I/m/src/uml.2.5.63/arch/um/kernel/tt/include 
-I/m/src/uml.2.5.63/arch/um/kernel/skas/include -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=module -DKBUILD_MODNAME=module -c -o 
arch/um/sys-i386/module.o arch/um/sys-i386/module.c
arch/um/sys-i386/module.c: In function `apply_relocate':
arch/um/sys-i386/module.c:89: dereferencing pointer to incomplete type
arch/um/sys-i386/module.c: In function `apply_relocate_add':
arch/um/sys-i386/module.c:103: dereferencing pointer to incomplete type
make[1]: *** [arch/um/sys-i386/module.o] Error 1
make: *** [arch/um/sys-i386] Error 2

Native 2.5.63 (i386) is ok with or without CONFIG_MODULES=y.

Regards,

Daniel
