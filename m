Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUCUAta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbUCUAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:49:30 -0500
Received: from server17.pronicsolutions.com ([64.94.232.3]:21662 "EHLO
	server17.pronicsolutions.com") by vger.kernel.org with ESMTP
	id S263582AbUCUAro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:47:44 -0500
From: "Bert Kammerer" <mot@pronicsolutions.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.26-pre5
Date: Sat, 20 Mar 2004 19:48:07 -0500
Message-ID: <001601c40ede$2d613390$0600a8c0@p17>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.44.0403200251350.3436-100000@dmt.cyclades>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server17.pronicsolutions.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pronicsolutions.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

You're my last hope :-)

Ever since 2.4.25, when compiling it in to any RedHat 7.3 machine, the
following appears in dmesg:

attempt to access beyond end of device
03:02: rw=0, want=1020128, limit=1020127

I traced this to the mount version that ships with RedHat 7.3
(mount-2.11n). Upgrading mount to a newer version gets rid of the
messages, but I am unsure as to whether or not the errors are really
going away. Do you have any comments/suggestions concerning this issue?

Thanks a million!

Bert


On Sun, 20 Mar 2004, Marcelo Tosatti wrote:

Hi, 

Here goes the fifth -pre of 2.4.26.

It includes a number of USB bugfixes/updates, SCSI driver/stack fixes
from 
Doug Ledford, another ACPI update, amongst others.

This is probably the last -pre of 2.4.26 series.

Detailed changelog follows

Summary of changes from v2.4.26-pre4 to v2.4.26-pre5
============================================

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<dledford:build-base.perf.redhat.com>:
  o scsi_lib.c: Fix sg segment recounting
  o Fix various minor compiler warning issues
  o Fix for Red Hat bug #98264, usb reset locking problem
  o sym53c8xx:  Only do SCSI-3 PPR message based negotiations on SCSI-3
devices or SCSI-2 devices that know to set the DT bit in their INQUIRY
return data.
  o scsi_scan.c: Correctness fix for scanning of multi-lun devices
  o scsi_scan.c: Add an option for making linux treat offlined devices
as online
  o Update the error handler to use mod_timer
  o Don't leak command structs when no device is found

<jamesl:appliedminds.com>:
  o USB: Fixing HID support for non-explicitly specified usages

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<mlotek:foobar.pl>:
  o USB: another unusual_devs.h change

<not:just.any.name>:
  o USB: Using physical extents instead of logical ones for NEC USB HID
gamepads

<pg:futureware.at>:
  o USB: more FTDI-SIO devices

<rene.herman:keyaccess.nl>:
  o 8139too assertions

<ricklind:us.ibm.com>:
  o block layer accounting fix

Alan Stern:
  o USB: fix unneeded SubClass entry in unusual_devs.h

Dave Kleikamp:
  o JFS: zero new log pages, etc

David Brownell:
  o USB Gadget: ethernet gadget locking tweaks
  o USB: EHCI updates (mostly periodic schedule scanning)
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: add "gadget_chips.h"
  o USB: gadget config buffer utilities
  o USB: usb gadget, dualspeed {run,compile}-time flags
  o USB: gadget zero, simplified controller-specific configuration

Don Fry:
  o pcnet32 correct names for changes
  o pcnet32.c oops

Greg Kroah-Hartman:
  o USB: add support for the Aceeca Meazura device to the visor driver

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Jeff Garzik:
  o Update pci_ids.h with new Intel PCI ids
  o Add Intel ICH6 irq router
  o Add Intel PCI ids to i810_audio
  o Add Intel PCI ids to IDE (PATA) driver
  o [netdrvr natsemi] Fix RX DMA mapping

Kumar Gala:
  o [PPC32] Modified OCP support so its not IBM specific and added new
APIs to allow modification of the device tree before drivers are bound

Len Brown:
  o [ACPI] acpi_wakeup_address - print only when broken
  o [ACPI] global lock macro fixes (Paul Menage, Luming Yu)
http://bugzilla.kernel.org/show_bug.cgi?id=1669
  o [ACPI] SMP poweroff (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=1141
  o [ACPI] ACPICA 20040311 from Bob Moore
  o [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize"
acpi_osi= will disable the _OSI method -- which by default tells the
BIOS to behave as if Windows is the OS.

Luca Tettamanti:
  o USB: fix hid-core compile warning

Manfred Spraul:
  o forcedeth update

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Paul Mackerras:
  o [PPC32] Add support for the EP405/EP405PC embedded platforms
  o [PPC32] Avoid prefetching past the end of the source in copy
routines
  o [PPC32] Add stabs debug entries to some assembler files
  o [PPC32] Add support for the Redwood 5 and 6 embedded boards

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Pete Zaitcev:
  o USB: Change the USB Maintainer entry
  o USB: fix hid-input problem with BTC keyboards
  o Trivial input.c change: Add missing new line on error case printk()

Petko Manolov:
  o USB: patch for pegasus.h
  o USB: another patch to pegasus.h

Richard Curnow:
  o USB: Fix handling of bounce buffers by rh_call_control

Stelian Pop:
  o sonypi driver update
  o meye driver update

Thomas Chen:
  o USB: fix little bug in io_edgeport.c

Thomas Sailer:
  o USB: OSS audio driver workaround for buggy descriptors


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


