Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbTHLLfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTHLLfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:35:23 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:2576 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S270218AbTHLLfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:35:05 -0400
Date: Tue, 12 Aug 2003 13:34:38 +0200
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: matrox framebuffer halts booting?
Message-ID: <20030812113438.GA746@gates.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I try to boot a self-compiled kernel with the matrox framebuffer, the
booting process halts after 'Freeing unused kernel memory'.

After that, the system isn't hung (numlock works, ctrl-alt-del works)
but it also doesn't boot (not reachable over the network, blindly
logging in doesn't work). Before that, the framebuffer seems to work - I
see a resolution change and a penguin boot-logo.

I can compile kernels with matroxfb for my other machine just fine - and
I can't understand what option I'm missing, and I don't see any relevant
difference with my other machine's .config.

This is a Gigabyte GA-6BDX dual P3/450 board, with a PCI Matrox
Millennium I card.
I'm trying to boot with

append="video=matroxfb:vesa:0x1B8,fv:72"

in my lilo.conf.

Thanks for any hints,
Jurriaan

Here's my .config, with some options (CPU, USB, NET etc.) removed for
brevity:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ISA=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_VIAPRO=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_RAW_DRIVER=y
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_6x11=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIOS_REBOOT=y

