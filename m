Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275053AbRIYPhh>; Tue, 25 Sep 2001 11:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275050AbRIYPhb>; Tue, 25 Sep 2001 11:37:31 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:28130 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275049AbRIYPgm>;
	Tue, 25 Sep 2001 11:36:42 -0400
Message-ID: <3BB0A4A3.AA41BF07@candelatech.com>
Date: Tue, 25 Sep 2001 08:37:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SCSI module compile problem in 2.4.10: cpqfcTSinit.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -c -o scsi_debug.o scsi_debug.c
scsi_debug.c: In function `scsi_debug_biosparam':
scsi_debug.c:665: warning: unused variable `size'
gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -c -o cpqfcTSinit.o cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this function)
cpqfcTSinit.c:662: (Each undeclared identifier is reported only once
cpqfcTSinit.c:662: for each function it appears in.)
cpqfcTSinit.c:680: `SCSI_IOCTL_FC_TDR' undeclared (first use in this function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
make: *** [_mod_drivers] Error 2
[greear@grok linux]$ 

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
