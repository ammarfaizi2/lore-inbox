Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJND0P>; Sat, 13 Oct 2001 23:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJNDZ4>; Sat, 13 Oct 2001 23:25:56 -0400
Received: from montroll.Chem.McGill.CA ([132.206.205.86]:57472 "EHLO
	montroll.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S273902AbRJNDZr>; Sat, 13 Oct 2001 23:25:47 -0400
Date: Sat, 13 Oct 2001 23:25:55 -0400
From: David Ronis <ronis@montroll.chem.mcgill.ca>
Message-Id: <200110140325.f9E3Pttt002153@montroll.chem.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: Module Build Failure in 2.4.12
Cc: ronis@montroll.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to build 2.4.12 on an i586-linux-gnu box [an out of the 
package Slackware8.0 system].  The build fails in building the parport driver
module.  Specfically:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes -Wno-
trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpref
erred-stack-boundary=2 -march=i586 -DMODULE   -c -o ieee1284_ops.o ieee1284_ops.
c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this func
tion)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this func
tion)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2

I'm going to remove this support and try again, but the problem should be fixed.

David
