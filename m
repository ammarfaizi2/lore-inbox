Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292811AbSCETc5>; Tue, 5 Mar 2002 14:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310166AbSCETcr>; Tue, 5 Mar 2002 14:32:47 -0500
Received: from 205-229-149-10.pool.corsair.com ([205.229.149.10]:42543 "EHLO
	varuna.ir.corsair.com") by vger.kernel.org with ESMTP
	id <S292811AbSCETck>; Tue, 5 Mar 2002 14:32:40 -0500
Message-Id: <4.3.2.7.2.20020305112638.03394630@pop3.ir.corsair.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 05 Mar 2002 11:32:32 -0800
To: linux-kernel@vger.kernel.org
From: Kamlesh Bans <kbans@corsair.com>
Subject: 2.5.5 3c505.c redefine of netdev_ethtool_ioctl and netdev_ioctl
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following errors compiling 3c505.c:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 
-DMODULE  -DKBUILD_BASENAME=3c505  -c -o 3c505.o 3c505.c
3c505.c:1362: redefinition of `netdev_ethtool_ioctl'
3c505.c:1172: `netdev_ethtool_ioctl' previously defined here
3c505.c:1417: redefinition of `netdev_ioctl'
3c505.c:1227: `netdev_ioctl' previously defined here
{standard input}: Assembler messages:
{standard input}:3833: Error: symbol `netdev_ethtool_ioctl' is already defined
{standard input}:4035: Error: symbol `netdev_ioctl' is already defined
make[2]: *** [3c505.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/drivers'
make: *** [_mod_drivers] Error 2

The module was able to compile with the second occurrences of the two 
functions removed.

Please cc me on any mail messages regarding this.



