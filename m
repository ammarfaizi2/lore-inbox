Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265417AbSIWKkf>; Mon, 23 Sep 2002 06:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265416AbSIWKkf>; Mon, 23 Sep 2002 06:40:35 -0400
Received: from globenet1.tvnet.hu ([195.38.124.81]:44555 "EHLO fw.globenet.hu")
	by vger.kernel.org with ESMTP id <S265417AbSIWKke> convert rfc822-to-8bit;
	Mon, 23 Sep 2002 06:40:34 -0400
Message-Id: <sd8f0f46.076@tigris.globenet-office.hu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Mon, 23 Sep 2002 12:55:26 +0200
From: "=?ISO-8859-2?B?RXJk9XNpIFpvbHThbg==?=" <zoli@globenet.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.5.37 make broken with DAC960
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody !

I want make 2.5.X kernel on Intel Server mainboard with 2 P4 Xeon CPU, 1 Gb RAM and Mylex Raid 352 controller on 64bit 100 MHz bus.

2.4.19 kernel is running and complilng on this machine.  

This error generate on make: 

[root@p4 linux-2.5.37]# make bzImage
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.37/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/linux-2.5.37/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o built-in.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.37/init'
  ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group -o vmlinux
drivers/built-in.o: In function `DAC960_V1_ExecuteType3':
drivers/built-in.o(.text+0x362ec): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V1_ExecuteType3B':
drivers/built-in.o(.text+0x363a1): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V1_ExecuteType3D':
drivers/built-in.o(.text+0x3645e): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_GeneralInfo':
drivers/built-in.o(.text+0x3651a): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V2_ControllerInfo':
drivers/built-in.o(.text+0x365ee): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V2_LogicalDeviceInfo':
drivers/built-in.o(.text+0x366c4): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V2_PhysicalDeviceInfo':
drivers/built-in.o(.text+0x367de): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V1_EnableMemoryMailboxInterface':
drivers/built-in.o(.text+0x36b5e): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x36b6e): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_EnableMemoryMailboxInterface':
drivers/built-in.o(.text+0x36f96): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x36fab): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x36fc4): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x37047): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x37155): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V1_ReadDeviceConfiguration':
drivers/built-in.o(.text+0x37bdd): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x37c10): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x37d7c): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_ReadDeviceConfiguration':
drivers/built-in.o(.text+0x3800c): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V1_QueueReadWriteCommand':
drivers/built-in.o(.text+0x3a23d): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3a2a5): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3a302): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_QueueReadWriteCommand':
drivers/built-in.o(.text+0x3a3eb): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3a472): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3a4be): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3a527): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V1_ProcessCompletedCommand':
drivers/built-in.o(.text+0x3a937): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3aa4d): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3aa90): undefined reference to `Bus32_to_Virtual'
drivers/built-in.o(.text+0x3aab6): undefined reference to `Bus32_to_Virtual'
drivers/built-in.o(.text+0x3adb0): undefined reference to `Bus32_to_Virtual'
drivers/built-in.o(.text+0x3b527): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3b558): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3b599): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3b604): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3b64a): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3b6ee): more undefined references to `Virtual_to_Bus32' follow
drivers/built-in.o: In function `DAC960_V2_ProcessCompletedCommand':
drivers/built-in.o(.text+0x3be8b): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3bfbe): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3c8a4): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3c952): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3ca05): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3cab9): more undefined references to `Virtual_to_Bus64' follow
drivers/built-in.o: In function `DAC960_P_InterruptHandler':
drivers/built-in.o(.text+0x3d2a9): undefined reference to `Bus32_to_Virtual'
drivers/built-in.o(.text+0x3d2d9): undefined reference to `Bus32_to_Virtual'
drivers/built-in.o: In function `DAC960_V1_QueueMonitoringCommand':
drivers/built-in.o(.text+0x3d3f8): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_QueueMonitoringCommand':
drivers/built-in.o(.text+0x3d475): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_UserIOCTL':
drivers/built-in.o(.text+0x3e0b1): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3e0be): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3e1e6): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3e65b): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3e693): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_KernelIOCTL':
drivers/built-in.o(.text+0x3edb7): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3edca): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3eed0): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o(.text+0x3f147): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o(.text+0x3f177): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V1_ExecuteUserCommand':
drivers/built-in.o(.text+0x3fe14): undefined reference to `Virtual_to_Bus32'
drivers/built-in.o: In function `DAC960_V2_TranslatePhysicalDevice':
drivers/built-in.o(.text+0x3ff90): undefined reference to `Virtual_to_Bus64'
drivers/built-in.o: In function `DAC960_V2_ExecuteUserCommand':
drivers/built-in.o(.text+0x40660): undefined reference to `Virtual_to_Bus64'
make: *** [vmlinux] Error 1

thx Zoli 
