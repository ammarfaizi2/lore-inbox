Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTDIPVu (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTDIPVt (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:21:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44960 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263513AbTDIPVp (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:21:45 -0400
Date: Wed, 09 Apr 2003 08:33:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 563] New: Build failure at drivers/media/video/zr36120.c
Message-ID: <190330000.1049902398@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=563

           Summary: Build failure at drivers/media/video/zr36120.c
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: tobias@fresco.org


Distribution: source from ftp.kernel.org
Hardware Environment: mobile PIII
Software Environment: Debian
Problem Description: Build fails at drivers/media/video/zr36120.c

Steps to reproduce: Configuret the kernel to  include the "Zoran ZR36120/36125
Video For Linux" driver (in this case as a module)

Error message:

  gcc -Wp,-MD,drivers/media/video/.zr36120.o.d -D__KERNEL__ -Iinclude -Wall -Wst
rict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpref
erred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-fr
ame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=zr36120 
-DKBUILD_MODNAME=zoran -c -o drivers/media/video/.tmp_zr36120.o drivers/media/vi
deo/zr36120.c
drivers/media/video/zr36120.c:42:19: tuner.h: No such file or directory        
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:26:31: linux/media/types.h: No such file or direct
ory
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':                     
drivers/media/video/zr36120.c:392: warning: implicit declaration of function `i2
c_control_device'
drivers/media/video/zr36120.c:392: `I2C_DRIVERID_VIDEODECODER' undeclared (first
 use in this function)
drivers/media/video/zr36120.c:392: (Each undeclared identifier is reported only 
once                                                                           
drivers/media/video/zr36120.c:392: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':                
drivers/media/video/zr36120.c:738: `I2C_DRIVERID_VIDEODECODER' undeclared (first
 use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1164: `I2C_DRIVERID_VIDEODECODER' undeclared (firs
t use in this function)
drivers/media/video/zr36120.c:1438: `I2C_DRIVERID_TUNER' undeclared (first use i
n this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1495: unknown field `open' specified in initializer
drivers/media/video/zr36120.c:1495: warning: initialization makes integer from
pointer without a cast
drivers/media/video/zr36120.c:1496: unknown field `close' specified in initializer
drivers/media/video/zr36120.c:1496: warning: initialization from incompatible
pointer type                  
drivers/media/video/zr36120.c:1497: unknown field `read' specified in
initializer                           
drivers/media/video/zr36120.c:1498: unknown field `write' specified in
initializer                          
drivers/media/video/zr36120.c:1498: warning: initialization makes integer from
pointer without a cast       
drivers/media/video/zr36120.c:1499: unknown field `poll' specified in
initializer                           
drivers/media/video/zr36120.c:1499: warning: missing braces around initializer
drivers/media/video/zr36120.c:1499: warning: (near initialization for
`zr36120_template.lock')              
drivers/media/video/zr36120.c:1499: warning: initialization makes integer from
pointer without a cast       
drivers/media/video/zr36120.c:1500: unknown field `ioctl' specified in
initializer                          
drivers/media/video/zr36120.c:1500: warning: initialization from incompatible
pointer type                  
drivers/media/video/zr36120.c:1501: unknown field `mmap' specified in
initializer                           
drivers/media/video/zr36120.c:1501: warning: excess elements in struct
initializer                          
drivers/media/video/zr36120.c:1501: warning: (near initialization for
`zr36120_template')                   
drivers/media/video/zr36120.c:1829: unknown field `open' specified in
initializer                           
drivers/media/video/zr36120.c:1829: warning: initialization makes integer from
pointer without a cast       
drivers/media/video/zr36120.c:1830: unknown field `close' specified in
initializer                          
drivers/media/video/zr36120.c:1830: warning: initialization from incompatible
pointer type                  
drivers/media/video/zr36120.c:1831: unknown field `read' specified in
initializer                           
drivers/media/video/zr36120.c:1832: unknown field `write' specified in
initializer                          
drivers/media/video/zr36120.c:1832: warning: initialization makes integer from
pointer without a cast       
drivers/media/video/zr36120.c:1833: unknown field `poll' specified in
initializer                           
drivers/media/video/zr36120.c:1833: warning: missing braces around initializer
drivers/media/video/zr36120.c:1833: warning: (near initialization for
`vbi_template.lock')                  
drivers/media/video/zr36120.c:1833: warning: initialization makes integer from
pointer without a cast       
drivers/media/video/zr36120.c:1834: unknown field `ioctl' specified in
initializer                          
drivers/media/video/zr36120.c:1834: warning: initialization from incompatible
pointer type                  
drivers/media/video/zr36120.c: In function `find_zoran':
drivers/media/video/zr36120.c:1869: warning: implicit declaration of function
`request_irq'                 
drivers/media/video/zr36120.c: In function `init_zoran':
drivers/media/video/zr36120.c:2009: warning: implicit declaration of function
`i2c_register_bus'            
drivers/media/video/zr36120.c: In function `release_zoran':
drivers/media/video/zr36120.c:2040: warning: implicit declaration of function
`free_irq'                    
drivers/media/video/zr36120.c:2043: warning: implicit declaration of function
`i2c_unregister_bus'          
make[4]: *** [drivers/media/video/zr36120.o] Error 1
make[3]: *** [drivers/media/video] Error 2
make[2]: *** [drivers/media] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.67'
make: *** [stamp-build] Error 2

