Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTBURh0>; Fri, 21 Feb 2003 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBURh0>; Fri, 21 Feb 2003 12:37:26 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:60879 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267611AbTBURhY>; Fri, 21 Feb 2003 12:37:24 -0500
From: Thomas Stuefe <thomas.stuefe@online.de>
To: linux-kernel@vger.kernel.org
Subject: compile error in isdn_ppp_mp.h: fkt ippp_xmit()
Date: Fri, 21 Feb 2003 15:14:12 +0100
User-Agent: KMail/1.5
Cc: kai@germaschewski.name
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302211514.12505.thomas.stuefe@online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

in 2.5.62:

when compiling ISDN (old ISDN4Linux) with this combination:

CONFIG_ISDN_PPP = Y
CONFIG_ISDN_MPP = N


I get:

  gcc -Wp,-MD,drivers/isdn/i4l/.isdn_ppp.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstri                ct-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mprefer                red-stack-boundary=2 
-march=pentium4 -Iinclude/asm-i386/mach-default -fomit-fram                
e-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=isdn_ppp 
-DKBUILD_                MODNAME=isdn -c -o drivers/isdn/i4l/isdn_ppp.o 
drivers/isdn/i4l/isdn_ppp.c
In file included from drivers/isdn/i4l/isdn_ppp.c:22:
drivers/isdn/i4l/isdn_ppp_mp.h: In function `ippp_mp_xmit':
drivers/isdn/i4l/isdn_ppp_mp.h:47: too many arguments to function `ippp_xmit'


Compile works with CONFIG_ISDN_MPP = Y. 


bye thomas

