Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbTGLNkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTGLNkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:40:04 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:42677 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S265686AbTGLNj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:39:59 -0400
Date: Sat, 12 Jul 2003 07:47:16 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: linux-2.4.22-pre5 drm/agpsupport unresolved symbols
Message-ID: <Pine.LNX.4.44.0307120731001.1986-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes the following compile error when building
agpsupport as a module.  This is against 2.4.22pre5.

Marcelo, please apply as it's a very simple patch the adds the symbol to an
enum in include/linux/agp_backend.h and adds a missed break statement in
drm-4.0/agpsupport.c.

**********
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.22pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/redhat/BUILD/kernel-2.4.22pre5/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpsupport  -c -o agpsupport.o agpsupport.c
agpsupport.c: In function `drm_agp_bind':
agpsupport.c:215: warning: concatenation of string literals with __FUNCTION__ is deprecated
agpsupport.c: In function `drm_agp_init':
agpsupport.c:280: `VIA_APOLLO_P4X400' undeclared (first use in this function)
agpsupport.c:280: (Each undeclared identifier is reported only once
agpsupport.c:280: for each function it appears in.)
make[3]: *** [agpsupport.o] Error 1
make[3]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers/char/drm-4.0'
make[2]: *** [_modsubdir_drm-4.0] Error 2
make[2]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers'
make: *** [_mod_drivers] Error 2
******************

Thanks and regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  




