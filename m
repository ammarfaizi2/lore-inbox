Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUAOWcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAOWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:32:41 -0500
Received: from intra.cyclades.com ([64.186.161.6]:51934 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262048AbUAOWch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:32:37 -0500
Date: Thu, 15 Jan 2004 18:19:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Cc: Simon Kirby <sim@netnation.com>
Subject: Linux 2.4.25-pre5
Message-ID: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here is -pre5.

This version fixes the "memory filled with unfreeable inodes" problem
which occurs on high memory machines in some workloads.  That is the last
big problem 2.4 VM had with highmem I believe.

It contains a few other important fixes:
- fixes a SMP deadlock introduced during 2.4.23 (which could hang the
machine on high filesystem activity).
- fixes a memory allocation deadlock in USB

Amongst others.

Please test it!

Detailed changelog follows


Summary of changes from v2.4.25-pre4 to v2.4.25-pre5
============================================

<bjorn.helgaas:hp.com>:
  o ia64 Configure.help update

<davej:redhat.com>:
  o Add AGP support for Radeon IGP 345M

<jack:ucw.cz>:
  o Fix ext3/quota deadlock

<khali:linux-fr.org>:
  o i2c cleanups: Config.in
  o i2c cleanup: saa7146.h should include i2c-old.h, not i2c.h
  o i2c cleanup: i2c-core fixes

<len.brown:intel.com>:
  o [ACPI] fix smpboot.c mis-merge http://bugzilla.kernel.org/show_bug.cgi?id=1706

<marcelo:logos.cnet>:
  o Cset exclude: rtjohnso@eecs.berkeley.edu|ChangeSet|20040109135735|05388
  o Fix microcode update compilation error
  o Fix Makefile typo

<moilanen:austin.ibm.com>:
  o [PPC64] Improved NVRAM handling
  o [PPC64] Buffer error log entries in NVRAM

<nitin.a.kamble:intel.com>:
  o microcode update

<rtjohnso:eecs.berkeley.edu>:
  o USB ioctl fixes (vicam.c, w9968cf.c)

<sfr:au1.ibm.com>:
  o [PPC64] Fix a compile warning that becomes an error with gcc 3.4

<thomas:winischhofer.net>:
  o SiS Framebuffer driver update

<xose:wanadoo.es>:
  o ips SCSI driver update

Adrian Bunk:
  o fix CONFIG_DS1742 Config.in entry
  o remove REPORT_LUNS from cpqfcTSstructs.h
  o disallow modular CONFIG_COMX

Alan Cox:
  o Fix USB hangs
  o Minimal fix for the R128 drivers

Bartlomiej Zolnierkiewicz:
  o create /proc/ide/hdX/capacity only once

Ben Collins:
  o [IEEE1394]: Fix bug in updating configrom

David Engebretsen:
  o [PPC64] Distribute processing of hypervisor events over all processors

David Woodhouse:
  o Fix SMP deadlock in __wait_on_freeing_inode() (introduced during 2.4.23)

Hugh Dickins:
  o tmpfs readdir does not update dir atime

Paul Mackerras:
  o [PPC64] Remove some unnecessary code from arch/ppc64/kernel/prom.c
  o [PPC64] Make /dev/sda3 the default root device (rather than sda2)
  o [PPC64] Add functions to update and manage flash ROM under Linux on pSeries
  o [PPC64] Update defconfig and the example configs

Pete Zaitcev:
  o Unhork ymfpci broken by hasty janitors

Rik van Riel:
  o Reclaim inodes with highmem pages when low on memory

Tom Rini:
  o PPC32: Add support for the CPCI-405 board
  o PPC32: Fix cross-compilation from Solaris or Cygwin
  o PPC32: s/CONFIG_SMC2_UART/CONFIG_8xx_SMC2/g to match the code

