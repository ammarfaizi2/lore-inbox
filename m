Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTDEBg3 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTDEBg3 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:36:29 -0500
Received: from gumby.usu.edu ([129.123.1.117]:20752 "EHLO gumby.usu.edu")
	by vger.kernel.org with ESMTP id S261700AbTDEBgR (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:36:17 -0500
Date: Fri, 04 Apr 2003 18:47:46 -0700
From: Anup Pemmaiah <pemmaiah@cc.usu.edu>
Subject: Building Kernel-2.5
To: linux-kernel@vger.kernel.org
Message-id: <3E8FAF07@webmail.usu.edu>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.62
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 7bit
X-WebMail-UserID: pemmaiah
X-EXP32-SerialNo: 00002751
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     How are you? This question is been asked previously, but I haven't found 
a solution yet. I have searched most of the mailing lists and have mailed to 
the concerned persons who had posted this question before, but of no success.
     I wanted to build the kernel-2.5. I dowloaded 2.5.64 and built it as I 
did for 2.4. Everything went on fine. But when I reboot the system, it doesnt 
do anything after it shows "Uncompressing Linux....OK". There is no disk 
activity. I made sure the Input devices and video cards is been selected. I am 
working on this for past 10 days but of no success.

I would like to explain my building process.


 1) Downloaded the linux-2.5-66.tar.gz from www.kernel.org website.
 2) Saved it in /usr/src directory and un-tarred it which created the
 linux-2.5-66 directory.
 3) Got into the linux-2.5-66 directory for further work
 4) "make mrpoper" to remove remains of previous builds
 5) "make xconfig", left the default settings as it is, save and exit
 6) "make dep", I know it doesn't help because of no change in default 
settings
 7) "make clean"
 8) "make bzImage"
 9) "make modules_install"
 10) "make install", which copied the System.map and vmlinuz-2.5 files to 
/boot
 directory and also did the corresponding entry in grub.conf file.
 11) /sbin/reboot

    Any advise on this will be greatly appreciated.Looking forward to your 
help.Please let me know if you need any more information. Please cc your mail 
to pemmaiah@cc.usu.edu.

Thank you

Anup


Some parts of the .config file.


CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
..............................
..................
....
#
# Input device support
#
CONFIG_INPUT=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_VORTEX=m
CONFIG_GAMEPORT_FM801=m
CONFIG_GAMEPORT_CS461x=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

....
....

....
....

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
CONFIG_FB_RIVA=m
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_SIS is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set

-------------------------------------------------
Anup Pemmaiah 
435-512-0935
anup_pemmaiah@yahoo.com
pemmaiah@cc.usu.edu
-------------------------------------------------

