Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130278AbRCBCKa>; Thu, 1 Mar 2001 21:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRCBCKL>; Thu, 1 Mar 2001 21:10:11 -0500
Received: from jalon.able.es ([212.97.163.2]:46253 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130265AbRCBCJ6>;
	Thu, 1 Mar 2001 21:09:58 -0500
Date: Fri, 2 Mar 2001 03:09:46 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2ac8 lost char devices
Message-ID: <20010302030946.A2631@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well, somethig has broken in ac8, because I lost my PS/2 mouse and
(less important, but perhaps it is useful) the microcode driver. So
I think it something common to both.

The onle diff in dmesg from ac7 to ac8 is just the errors:

1c1
< Linux version 2.4.2-ac7 (root@werewolf.able.es) (gcc version 2.96 20000731
(Linux-Mandrake 8.0)) #1 SMP Fri Mar 2 02:36:23 CET 2001
---
> Linux version 2.4.2-ac8 (root@werewolf.able.es) (gcc version 2.96 20000731
(Linux-Mandrake 8.0)) #1 SMP Fri Mar 2 01:17:50 CET 2001
82c82
< Detected 400.917 MHz processor.
---
> Detected 400.914 MHz processor.
232,237c232,237
< ..... CPU clock speed is 400.8934 MHz.
< ..... host bus clock speed is 100.2232 MHz.
< cpu: 0, clocks: 1002232, slice: 334077
< CPU0<T0:1002224,T1:668144,D:3,S:334077,C:1002232>
< cpu: 1, clocks: 1002232, slice: 334077
< CPU1<T0:1002224,T1:334064,D:6,S:334077,C:1002232>
---
> ..... CPU clock speed is 400.8944 MHz.
> ..... host bus clock speed is 100.2233 MHz.
> cpu: 0, clocks: 1002233, slice: 334077
> CPU0<T0:1002224,T1:668144,D:3,S:334077,C:1002233>
> cpu: 1, clocks: 1002233, slice: 334077
> CPU1<T0:1002224,T1:334064,D:6,S:334077,C:1002233>
245c245,246
< IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
---
> microcode: can't misc_register on minor=184
> microcode: failed to devfs_register()

What is microcode doing with devfs ? I have not configured devfs...

--
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac7 #1 SMP Fri Mar 2 02:36:23 CET 2001 i686

