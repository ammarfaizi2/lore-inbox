Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263479AbREYBUq>; Thu, 24 May 2001 21:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263481AbREYBUh>; Thu, 24 May 2001 21:20:37 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:54283 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S263479AbREYBUb>; Thu, 24 May 2001 21:20:31 -0400
From: rolf@newwweb.de
Date: Fri, 25 May 2001 03:20:28 +0200 (MET DST)
To: linux-kernel@vger.kernel.org
Subject: SiS630 linking problems w/ 2.4.4-ac12
Message-ID: <Pine.GSO.4.21.0105250315440.28560-100000@rrzc3.rz.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I`m trying to compile 2.4.4-ac12 with support for SiS accelerated
framebuffer device in the kernel. It compiles fine but then I get the
attached errors.
I`m trying the ac12 cause the sis framebuffer from the stock kernel
doesn`t even boot and there seem to be significant changes beetween those
two versions.

Please CC me cause I can`t keep up with the enormous traffic this list
generates :(
Thanks in advance, Rolf

make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  arch/i386/lib
make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux/arch/i386/lib'
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -c checksum.S -o checksum.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o old-checksum.o old-checksum.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o delay.o delay.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o usercopy.o usercopy.c
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -c getuser.S -o getuser.o
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -c putuser.S -o putuser.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o memcpy.o memcpy.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o strstr.o strstr.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o putuser.o memcpy.o strstr.o
make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
fs/fs.o: In function `bm_register_write':
fs/fs.o(.text+0x16093): undefined reference to `lookup_one'
drivers/video/video.o: In function `SiSInit300':
drivers/video/video.o(.text+0x6276): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6285): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6298): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x62ab): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x62cf): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x630f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x632f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x634f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6379): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x63a3): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x63c4): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x63d9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x63ef): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6410): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6425): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x643e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6466): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6490): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x64b1): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x64c0): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x64e9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x650c): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6523): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x653a): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6554): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x656b): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSInit300':
drivers/video/video.o(.text+0x65ff): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x660c): undefined reference to `sisfb_clear_DAC'
drivers/video/video.o: In function `SiSSetMemoryClock':
drivers/video/video.o(.text+0x6687): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x66b7): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetMode':
drivers/video/video.o(.text+0x67b3): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6815): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6879): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x689f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6960): undefined reference to `sisfb_clear_buffer'
drivers/video/video.o(.text+0x6972): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSCheckMemorySize':
drivers/video/video.o(.text+0x6a5e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSetSeqRegs':
drivers/video/video.o(.text+0x6acf): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6b37): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6b64): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetMiscRegs':
drivers/video/video.o(.text+0x6b99): undefined reference to `sisfb_set_reg3'
drivers/video/video.o: In function `SiSSetCRTCRegs':
drivers/video/video.o(.text+0x6bb5): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6bc8): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6bf2): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetATTRegs':
drivers/video/video.o(.text+0x6c6d): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0x6c7e): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x6c8f): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x6cab): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0x6cba): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x6cc9): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x6cd6): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0x6ce5): undefined reference to `sisfb_set_reg3'
drivers/video/video.o: In function `SiSSetGRCRegs':
drivers/video/video.o(.text+0x6d19): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6d3c): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6d51): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSClearExt1Regs':
drivers/video/video.o(.text+0x6d71): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSGetRatePtr':
drivers/video/video.o(.text+0x6dab): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSetSync':
drivers/video/video.o(.text+0x6e4d): undefined reference to `sisfb_set_reg3'
drivers/video/video.o: In function `SiSSetCRT1CRTC':
drivers/video/video.o(.text+0x6e8d): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x6ea4): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6ed4): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6f09): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6f41): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6f76): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x6fb1): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSSetCRT1CRTC':
drivers/video/video.o(.text+0x6ff3): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7030): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x704d): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetCRT1Offset':
drivers/video/video.o(.text+0x70f8): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7112): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7125): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7172): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetCRT1VCLK':
drivers/video/video.o(.text+0x71ca): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x71ed): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7212): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSSetCRT1ModeRegs':
drivers/video/video.o(.text+0x728d): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x72c6): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x72d5): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x730e): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x731d): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7352): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetVCLKState':
drivers/video/video.o(.text+0x73ca): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x73f2): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7401): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x742c): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7478): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7498): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSLoadDAC':
drivers/video/video.o(.text+0x752b): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x753a): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x758f): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x75da): undefined reference to `sisfb_set_reg3'
drivers/video/video.o: In function `SiSWriteDAC':
drivers/video/video.o(.text+0x7701): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0x7712): more undefined references to `sisfb_set_reg3' follow
drivers/video/video.o: In function `SiSDisplayOn':
drivers/video/video.o(.text+0x773b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7750): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetInterlace':
drivers/video/video.o(.text+0x7804): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x785f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x786e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7881): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7893): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x78bd): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetCRT1FIFO':
drivers/video/video.o(.text+0x792d): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7a0f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7a32): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7a4a): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7a78): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7a8e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7aa8): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7acc): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7adb): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7af5): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSCalcDelay':
drivers/video/video.o(.text+0x7b7b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7b92): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7beb): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSetCRT1FIFO2':
drivers/video/video.o(.text+0x7ca1): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7d45): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7d77): more undefined references to `sisfb_get_reg1' follow
drivers/video/video.o: In function `SiSSetCRT1FIFO2':
drivers/video/video.o(.text+0x7d8f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7db2): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7dc1): undefined reference to `sisfb_set_reg4'
drivers/video/video.o(.text+0x7dcb): undefined reference to `sisfb_get_reg3'
drivers/video/video.o(.text+0x7ddb): undefined reference to `sisfb_set_reg4'
drivers/video/video.o(.text+0x7df5): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7e0e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7e28): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7e4c): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x7e5b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7e75): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSCalcDelay2':
drivers/video/video.o(.text+0x7ea8): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7ec7): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSDisplayOff':
drivers/video/video.o(.text+0x7f0b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x7f24): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetDefCRT2ExtRegs':
drivers/video/video.o(.text+0x8077): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8087): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8096): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x80ae): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x80c4): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x80d1): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSGetRatePtrCRT2':
drivers/video/video.o(.text+0x813f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSaveCRT2Info':
drivers/video/video.o(.text+0x83ed): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x8407): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8416): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x842b): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSDisableLockRegs':
drivers/video/video.o(.text+0x843f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x8454): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSDisableCRT2':
drivers/video/video.o(.text+0x8467): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x847c): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSDisableBridge':
drivers/video/video.o(.text+0x84a0): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x84ac): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x84c4): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x84d1): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x84dc): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x84ea): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x84f8): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8509): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSUnLockCRT2':
drivers/video/video.o(.text+0x8cf7): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x8d05): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetCRT2ModeRegs':
drivers/video/video.o(.text+0x8d48): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8db6): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8e1d): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8e83): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x8e98): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x8f15): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetGroup1_LVDS':
drivers/video/video.o(.text+0x8fe2): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x901e): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x9055): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x9085): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSSetCRT2FIFO':
drivers/video/video.o(.text+0x9eaa): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9ee8): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9f0e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9f25): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9f60): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9f8c): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0x9fbd): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0x9fd0): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSGetQueueConfig':
drivers/video/video.o(.text+0xa014): undefined reference to `sisfb_set_reg4'
drivers/video/video.o(.text+0xa01e): undefined reference to `sisfb_get_reg3'
drivers/video/video.o(.text+0xa038): undefined reference to `sisfb_set_reg4'
drivers/video/video.o(.text+0xa042): undefined reference to `sisfb_get_reg3'
drivers/video/video.o: In function `SiSGetVCLKPtr':
drivers/video/video.o(.text+0xa07e): undefined reference to `sisfb_get_reg2'
drivers/video/video.o: In function `SiSGetDRAMType':
drivers/video/video.o(.text+0xa15c): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSCalcDelayVB':
drivers/video/video.o(.text+0xa1c6): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xa1ee): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xa205): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSetCRT2Sync':
drivers/video/video.o(.text+0xa582): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xa593): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetGroup2':
drivers/video/video.o(.text+0xa700): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa71f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa758): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa788): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa79f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xa7b6): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa7c6): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa7d9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa7e9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa7f9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xa85a): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSSetGroup2':
drivers/video/video.o(.text+0xadbe): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xadcf): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xadd7): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xade5): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xae14): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xae3d): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xae4c): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xae5f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xae71): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaea3): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaeaf): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xaec0): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaec8): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xaed6): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetGroup3':
drivers/video/video.o(.text+0xaefb): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaf14): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaf29): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaf36): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xaf8b): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSSetCRT2VCLK':
drivers/video/video.o(.text+0xb27e): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb290): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSEnableCRT2':
drivers/video/video.o(.text+0xb2db): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb2f4): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSLoadDAC2':
drivers/video/video.o(.text+0xb382): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xb3dc): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xb427): undefined reference to `sisfb_set_reg3'
drivers/video/video.o: In function `SiSWriteDAC2':
drivers/video/video.o(.text+0xb563): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xb56d): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xb577): more undefined references to `sisfb_set_reg3' follow
drivers/video/video.o: In function `SiSLockCRT2':
drivers/video/video.o(.text+0xb593): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb5a1): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetLockRegs':
drivers/video/video.o(.text+0xb5ce): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb5e7): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSEnableBridge':
drivers/video/video.o(.text+0xb60f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb61b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb629): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xb636): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xb659): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xb665): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSGetVBInfo':
drivers/video/video.o(.text+0xb6bf): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb6e3): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb6f6): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb7c8): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb8b2): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xb8ea): more undefined references to `sisfb_get_reg1' follow
drivers/video/video.o: In function `SiSPresetScratchregister':
drivers/video/video.o(.text+0xba0f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSGetLCDDDCInfo':
drivers/video/video.o(.text+0xba3a): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetTVSystem':
drivers/video/video.o(.text+0xba80): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xba96): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbacb): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbafe): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSGetSenseStatus':
drivers/video/video.o(.text+0xbbab): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbbc7): more undefined references to `sisfb_get_reg1' follow
drivers/video/video.o: In function `SiSGetSenseStatus':
drivers/video/video.o(.text+0xbc45): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xbd75): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSense':
drivers/video/video.o(.text+0xbda2): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xbdce): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSenseLCD':
drivers/video/video.o(.text+0xbe1c): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbe28): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetRegANDOR':
drivers/video/video.o(.text+0xbe65): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbe78): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSDetectMonitor':
drivers/video/video.o(.text+0xbebb): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xbed3): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xbeeb): undefined reference to `sisfb_clear_DAC'
drivers/video/video.o(.text+0xbef1): undefined reference to `sisfb_clear_buffer'
drivers/video/video.o(.text+0xbf83): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSTestMonitorType':
drivers/video/video.o(.text+0xbfb4): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xbfc3): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xbfd1): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xbfdf): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xbff0): undefined reference to `sisfb_set_reg3'
drivers/video/video.o(.text+0xc002): undefined reference to `sisfb_get_reg2'
drivers/video/video.o: In function `SiSWaitDisplay':
drivers/video/video.o(.text+0xc029): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0xc049): undefined reference to `sisfb_get_reg2'
drivers/video/video.o: In function `SiSLongWait':
drivers/video/video.o(.text+0xc070): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0xc090): undefined reference to `sisfb_get_reg2'
drivers/video/video.o: In function `SiSVBLongWait':
drivers/video/video.o(.text+0xc0b0): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc0c9): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc0d9): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0xc0f0): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0xc107): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSWaitVBRetrace':
drivers/video/video.o(.text+0xc11f): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc134): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc144): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSGetPanelID':
drivers/video/video.o(.text+0xc17a): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc1be): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc203): more undefined references to `sisfb_get_reg1' follow
drivers/video/video.o: In function `SiSGetPanelID':
drivers/video/video.o(.text+0xc244): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSModCRT1CRTC':
drivers/video/video.o(.text+0xc2ae): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc2c1): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc2da): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc307): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc338): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc369): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc39a): more undefined references to `sisfb_set_reg1' follow
drivers/video/video.o: In function `SiSModCRT1CRTC':
drivers/video/video.o(.text+0xc3ff): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xc417): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetCRT2ECLK':
drivers/video/video.o(.text+0xc495): undefined reference to `sisfb_get_reg2'
drivers/video/video.o(.text+0xc51d): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc538): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc555): undefined reference to `sisfb_set_reg1'
drivers/video/video.o(.text+0xc56f): undefined reference to `sisfb_set_reg1'
drivers/video/video.o: In function `SiSSetSwitchDDC2':
drivers/video/video.o(.text+0xcb7b): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xcb9d): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSReadDDC2Data':
drivers/video/video.o(.text+0xccdf): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSSetSCLKHigh':
drivers/video/video.o(.text+0xcd61): undefined reference to `sisfb_get_reg1'
drivers/video/video.o: In function `SiSDDC2Delay':
drivers/video/video.o(.text+0xcd82): undefined reference to `sisfb_get_reg1'
drivers/video/video.o(.text+0xcdcc): more undefined references to `sisfb_get_reg1' follow
drivers/video/video.o(.data.init+0x10): undefined reference to `sisfb_init'
drivers/video/video.o(.data.init+0x14): undefined reference to `sisfb_setup'
make: *** [vmlinux] Error 1

