Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSIKNb0>; Wed, 11 Sep 2002 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSIKNb0>; Wed, 11 Sep 2002 09:31:26 -0400
Received: from [211.154.175.3] ([211.154.175.3]:55570 "EHLO
	mail.netpower.com.cn") by vger.kernel.org with ESMTP
	id <S318771AbSIKNbZ>; Wed, 11 Sep 2002 09:31:25 -0400
Date: Wed, 11 Sep 2002 21:39:1 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "becker@scyld.com" <becker@scyld.com>
Subject: problem with sundance driver for dfe-550fx (DL10050B)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200209112144446.SM00872@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i tried to test the dfe-550fx card with the new driver from Donald Becker. the version is "sundance.c:v1.09a 7/16/2002". 
the chip of the d-link card is DL10050B. a DL10050A card work with the v1.02d driver. but there are some problems with the DL10050B one.
the kernel version is 2.4.19pre1.
i run the following commands:
	insmod pci-scan.o
	insmod sundance.o
and it worked. the log is as follows:

Sep 11 21:20:58 netpower kernel: pci-scan.c:v1.10 7/13/2002  Donald Becker <beck
er@scyld.com> http://www.scyld.com/linux/drivers.html
Sep 11 21:21:01 netpower kernel: sundance.c:v1.09a 7/16/2002  Written by Donald
Becker <becker@scyld.com>
Sep 11 21:21:01 netpower kernel:   http://www.scyld.com/network/sundance.html
Sep 11 21:21:01 netpower kernel: eth2: OEM Sundance Technology ST201 at 0xe800,
00:05:5d:5e:b9:dc, IRQ 24.
Sep 11 21:21:01 netpower kernel: eth2: MII PHY found at address 1, status 0x7809
 advertising 01e1.
Sep 11 21:21:01 netpower kernel: eth3: OEM Sundance Technology ST201 at 0xe400,
00:05:5d:5e:b9:df, IRQ 22.
Sep 11 21:21:01 netpower kernel: eth3: MII PHY found at address 1, status 0x7809
 advertising 01e1.

then when i run the cmd "ifconfig eth2 192.168.0.10"  to bring the card to work,it failed. the problem is as follows,
	sh-2.03# ifconfig eth2 192.168.0.10
	SIOCSIFFLAGS: No such device
and there is no log for this.  so is there some problem on the support of DL10050B? 

please cc. thanks.

zhengchuanbo
zhengcb@netpower.com.cn

