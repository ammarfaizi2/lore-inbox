Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261864AbSI3Ahc>; Sun, 29 Sep 2002 20:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSI3Ahc>; Sun, 29 Sep 2002 20:37:32 -0400
Received: from mx11.dmz.fedex.com ([199.81.193.118]:36358 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261864AbSI3Ahb>; Sun, 29 Sep 2002 20:37:31 -0400
Date: Mon, 30 Sep 2002 08:41:51 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: can't compile ide as a module on 2.5.39
Message-ID: <Pine.LNX.4.44.0209300840190.2804-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 08:42:52 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 08:42:54 AM,
	Serialize complete at 09/30/2002 08:42:54 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling ide as a module on 2.5.39, encountered the following error

  gcc -Wp,-MD,./.ide.o.d -D__KERNEL__ -I/v6/src/2539/linux-2.5.39/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i586 -I/v6/src/2539/linux-2.5.39/arch/i386/mach-generic -nostdinc
-iwithprefix include -DMODULE -include
/v6/src/2539/linux-2.5.39/include/linux/modversions.h
-DKBUILD_BASENAME=ide -DEXPORT_SYMTAB  -c -o ide.o ide.c
ide.c:3578: redefinition of `init_module'
ide.c:3556: `init_module' previously defined here
ide.c: In function `cleanup_module':
ide.c:3601: warning: implicit declaration of function `bus_unregister'
{standard input}: Assembler messages:
{standard input}:8863: Error: symbol `init_module' is already defined
make[2]: *** [ide.o] Error 1
make[2]: Leaving directory `/v6/src/2539/linux-2.5.39/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/v6/src/2539/linux-2.5.39/drivers'
make: *** [drivers] Error 2


Jeff


