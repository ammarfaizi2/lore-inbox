Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTLBDmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLBDmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:42:07 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:51897 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S264300AbTLBDmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:42:03 -0500
Message-ID: <3FCC0A12.5010906@lemur.sytes.net>
Date: Mon, 01 Dec 2003 22:42:10 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.23-pac1  VIA/S3 DRM compilation error
References: <Pine.LNX.4.58.0311282137440.20775@dot.kde.org>
In-Reply-To: <Pine.LNX.4.58.0311282137440.20775@dot.kde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [68.162.12.45] at Mon, 1 Dec 2003 21:42:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> $SUBJECT is at ftp.kernel.org/pub/linux/kernel/people/bero/2.4/2.4.23/
> 
> Changes since 2.4.23-rc5-pac1:
> - Increase version number
> 
> 

similar error messages for the via driver. 2.4.22-ac4 worked fine.

make[4]: Entering directory `/usr/src/linux-2.4.22/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=c3 
-falign-functions=0 -falign-jumps=0 -falign-loops=0  -DDO_MUNMAP_4_ARGS 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=savage_drv  -c -o 
savage_drv.o savage_drv.c
savage_drv.c: In function `savage_alloc_continuous_mem':
savage_drv.c:55: error: `drm_savage_alloc_cont_mem_t' undeclared (first 
use in this function)
savage_drv.c:55: error: (Each undeclared identifier is reported only once
savage_drv.c:55: error: for each function it appears in.)
savage_drv.c:55: error: syntax error before "cont_mem"
savage_drv.c:70: error: `cont_mem' undeclared (first use in this function)
savage_drv.c:70: error: syntax error before ')' token
savage_drv.c:70: error: syntax error before ')' token
savage_drv.c:94: error: `DRM_SAVAGE_MEM_LOCATION_PCI' undeclared (first 
use in this function)
savage_drv.c:136: error: syntax error before ')' token
savage_drv.c:136: error: syntax error before ')' token
savage_drv.c:139:2: warning: #warning "Race at the very least"
savage_drv.c: In function `savage_get_physics_address':
savage_drv.c:150: error: `drm_savage_get_physcis_address_t' undeclared 
(first use in this function)
savage_drv.c:150: error: syntax error before "req"
savage_drv.c:157: error: `req' undeclared (first use in this function)
savage_drv.c:157: error: syntax error before ')' token
savage_drv.c:157: error: syntax error before ')' token
savage_drv.c:161:2: warning: #warning "FIXME: need to redo logic for this"
savage_drv.c:182: error: syntax error before ')' token
savage_drv.c:182: error: syntax error before ')' token
savage_drv.c: In function `savage_free_cont_mem':
savage_drv.c:191: error: `drm_savage_alloc_cont_mem_t' undeclared (first 
use in this function)
savage_drv.c:191: error: syntax error before "cont_mem"
savage_drv.c:201: error: `cont_mem' undeclared (first use in this function)
savage_drv.c:201: error: syntax error before ')' token
savage_drv.c:201: error: syntax error before ')' token
savage_drv.c:203:2: warning: #warning "fix size overflow check"
savage_drv.c:225: error: too few arguments to function `do_munmap'
In file included from savage_drv.c:240:
drm_drv.h: At top level:
drm_drv.h:251: error: `DRM_IOCTL_SAVAGE_ALLOC_CONTINUOUS_MEM' undeclared 
here (not in a function)
drm_drv.h:251: error: nonconstant array index in initializer
drm_drv.h:251: error: (near initialization for `savage_ioctls')
drm_drv.h:251: error: `DRM_IOCTL_SAVAGE_GET_PHYSICS_ADDRESS' undeclared 
here (not in a function)
drm_drv.h:251: error: nonconstant array index in initializer
drm_drv.h:251: error: (near initialization for `savage_ioctls')
drm_drv.h:251: error: `DRM_IOCTL_SAVAGE_FREE_CONTINUOUS_MEM' undeclared 
here (not in a function)
drm_drv.h:251: error: nonconstant array index in initializer
drm_drv.h:251: error: (near initialization for `savage_ioctls')
make[4]: *** [savage_drv.o] Error 1

