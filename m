Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbTIHIlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTIHIlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:41:08 -0400
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:46906 "EHLO
	sparc.campana.vi.it") by vger.kernel.org with ESMTP id S262084AbTIHIlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:41:05 -0400
Date: Mon, 8 Sep 2003 10:40:36 +0200
From: Ottavio Campana <ottavio@campana.vi.it>
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.22 compile error
Message-ID: <20030908084036.GA30850@campana.vi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux dirac 2.4.21-dirac 
X-Organization: Lega per la soppressione del Visual Basic
X-Homepage: http://www.campana.vi.it/ottavio/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just downloaded  linux 2.4.22 and applied the  following patches: xfs,
i2c 2.8.0 and lm_sensors 2.8.0 .

The kernel is failing to compile, here's the error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 
-DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.22/include/linux/modversions.h
-nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_if  -DEXPORT_SYMTAB 
-c bttv-if.c
bttv-if.c:244: unknown field `inc_use' specified in initializer
bttv-if.c:244: warning: initialization from incompatible pointer type
bttv-if.c:245: unknown field `dec_use' specified in initializer
bttv-if.c:245: warning: missing braces around initializer
bttv-if.c:245: warning: (near initialization for `bttv_i2c_adap_template.name')
bttv-if.c:245: warning: initialization makes integer from pointer without a cast
bttv-if.c:245: initializer element is not computable at load time
bttv-if.c:245: (near initialization for `bttv_i2c_adap_template.name[0]')
bttv-if.c:246: unknown field `name' specified in initializer
bttv-if.c:246: warning: initialization makes integer from pointer without a cast
bttv-if.c:246: initializer element is not computable at load time
bttv-if.c:246: (near initialization for `bttv_i2c_adap_template.name[1]')
bttv-if.c:247: unknown field `id' specified in initializer
bttv-if.c:248: unknown field `client_register' specified in initializer
bttv-if.c:248: warning: initialization makes integer from pointer without a cast
bttv-if.c:248: initializer element is not computable at load time
bttv-if.c:248: (near initialization for `bttv_i2c_adap_template.name[3]')
make[4]: *** [bttv-if.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/media/video'
make[3]: *** [_modsubdir_video] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/media'
make[2]: *** [_modsubdir_media] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22'
make: *** [stamp-build] Error 2

I've given  a look  a bttv-if, but  I can't understand  the error,  so I
can't help more than this. I'm using gcc 2.95.4 .

If you need more  infos can you please cc me, for  I'm not subscribed to
the list?
