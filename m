Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRF2Rbd>; Fri, 29 Jun 2001 13:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266127AbRF2RbY>; Fri, 29 Jun 2001 13:31:24 -0400
Received: from zeke.inet.com ([199.171.211.198]:36505 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266124AbRF2RbO>;
	Fri, 29 Jun 2001 13:31:14 -0400
Message-ID: <3B3CBA86.355500A@inet.com>
Date: Fri, 29 Jun 2001 12:27:34 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB Keyboard errors with 2.4.5-ac
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a rather weird problem last night.  I was testing out a
USB Type 6 Unix layout keyboard from Sun Microsystems and a USB Crossbow
model mouse from Sun as well.  I like the Sun keyboard and mice and am
used to the layout from using it so often at work.  I originally thought
that it would be no big deal since they both work perfectly in Windows
(tested while at work on my Windows 2000 box).  When I got them home and
tried them out I noticed one thing immediately that I could easily get
the mouse to work with GPM and also I could unplug it and plug it back
in with no problem as all.  The keyboard was a different story, if I
plug the keyboard in during operation everything freaks out and I have
to reboot the machine to get it to work properly.  I also noticed that X
would not work properly if I had either the USB keyboard and a PS/2
keyboard plugged in or if I had the USB keyboard plugged in alone.  No
matter what I tried I could not get X to work, but while trying I
noticed my real problem with the keyboard.  The kernel apparently
expects a PS/2 (AT) keyboard to be plugged in because if there isn't one
the kernel reports timeouts and seems slower than when there is a PS/2
keyboard present, my guess is because it is waiting on all of those
timeouts.  The next major keyboard thing I noticed is that I can type on
certain keys but if I do anything like hit the caps lock key or number
lock a couple of times then the keyboard stops responding completely and
the kernel tells me that there was an error waiting on a IRQ on CPU #1. 
So I guess my questions are the following, is it totally hopeless to
want to try and get a USB keyboard to work as the systems only keyboard
and have it work under X and also not freeze the whole system when
hitting certain keys?  Do I just need to give up for now and get one of
those USB->PS/2 converters and use my normal keyboard port, if so will
Linux ever be able to not depend on PS/2 hardware for keyboards on
ix86?  I am not looking for anything fancy here, I mean all the extra
keys on it like front, stop etc. would be nice to use eventually but if
they do absolutely nothing that is fine with me, I just want to be able
to use this keyboard.  Below are the pertinent .config sections, this is
on a Tyan Tiger 230 which uses a Via chipset.  The mouse is still
working right now and X works if I have a PS/2 keyboard only plugged in
and just use the mouse.


Thanks for any help you can give me.

Jordan Breeding






#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_LONG_TIMEOUT=y
CONFIG_USB_LARGE_CONFIG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI=y
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HP5300 is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set
