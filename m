Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTGRTmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270338AbTGRTmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:42:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5838 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270322AbTGRTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:42:07 -0400
Date: Fri, 18 Jul 2003 16:53:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre7
Message-ID: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here goes -pre7.

This is a feature freeze, only bugfixes will be accepted from now on.

-rc1 should be out in a couple of weeks.

-pre7 contains a bunch of updates (networking, sh/sparc64 merge, etc)
including another IO scheduler change which should improve overall
performance a lot.

Summary of changes from v2.4.22-pre6 to v2.4.22-pre7
============================================

<ja:ssi.bg>:
  o [IPV4/IPV6]: Fix use-after-free bugs in tunneling drivers

<lethal:unusual.internal.linux-sh.org>:
  o SH Merge
  o SH update

<tgraf:suug.ch>:
  o [NET]: Make {send,recv}msg return EMSGSIZE when msg_iovelen is too big, as per 1003.1
  o [NET]: Return EDESTADDRREQ as appropriate in sendmsg implementations

Alan Cox:
  o add quota autoload
  o typo bits

Ben Collins:
  o [SPARC64]: Fix OBP 4.6+ PCI probing, use pcic_present() consistently
  o Fix ALi15x3 DMA on sparc64 (maybe others)

Benjamin Herrenschmidt:
  o radeonfb: fix artifacts during boot

Chas Williams:
  o [ATM]: Add reference counting to atm_dev
  o [ATM]: Make ATM buildable as a module
  o [ATM]: Eliminate cli, make function names sane in net/atm/lec.c

Christoph Hellwig:
  o vmap() backport

Dave Kleikamp:
  o JFS: Possible trap/data loss when fixing directory index table

David S. Miller:
  o [SUNHME]: Set RXMAX/TXMAX large enough to handle VLAN frames
  o [NET]: Ok, sunhme is VLAN challenged after all
  o [SUNRPC]: Fix compiler warning in svcsock.c
  o [NETFILTER]: Fix build warnings in ipv6 modules, thanks Geert
  o [ATM]: Fix build, missing lec_priv member
  o [ATM]: Fix lec.c warning with bridging disabled
  o [SPARC64]: Fix assumptions about data section ordering and objects ending up in .data vs .bss
  o [SPARC{,64}]: Add barrier() to cpu_relax() for consistency with 2.5.x
  o [SPARC64]: Update defconfig
  o [Bluetooth]: Fix buggy CONFIG_ISDN test in cmtp Config.in
  o [SPARC64]: Do not break out of PCI controller probing loop too early

David Stevens:
  o [IPV4]: Do not sent IGMP leave messages unless IFF_UP

Gerd Knorr:
  o bttv driver update
  o tuner driver update
  o bttv documentation update
  o Update tv card i2c helper modules

Ivan Kokshaysky:
  o typecast bug in sched.c bites reschedule_idle

James Morris:
  o [NETLINK]: Just drop packets for kernel netlink socket with no data_ready handler

Jens Axboe:
  o more iosched work

Maksim Krasnyanskiy:
  o [Bluetooth] CMTP protocol depends on ISDN and ISDN CAPI

Marcel Holtmann:
  o [Bluetooth] Make READ_TRANSMIT_POWER_LEVEL available for normal users
  o [Bluetooth] Support for inquiry with unlimited responses
  o [Bluetooth] Support for AVM BlueFRITZ! USB
  o [Bluetooth] Add l2cap_load() function
  o [Bluetooth] Handle command complete event for inquiry cancel
  o [Bluetooth] Declare the function l2cap_load()
  o [Bluetooth] Update the maintainer entries for the Bluetooth subsystem

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre7
  o buffer.c: remove unused out_putf label

Mikael Pettersson:
  o clean crc temp files in lib/

Oleg Drokin:
  o Fix link/unlink race. By Chris Mason concurrent link/unlinks can create savelinks for files that still exist, the fix here is to be somewhat smarter about when we change the link count

Paul Mackerras:
  o PPC32: Fix the debug check in kunmap_atomic
  o PPC32: Fix IRQ sense and polarity setting on 405 and 440 cpus

Paul Mundt:
  o sh64: Fix ATM module build
  o sh64: defconfig update
  o sh64: Cayman IRQ handler updates

Roman Zippel:
  o hfs+: update copyright
  o hfs+: remove some smaller files
  o hfs+: volume/permission fixes
  o hfs+: fix rename of links
  o hfs+: check size of inode and sb info
  o hfs+: various cleanups
  o hfs+: link hfsplus before hfs
  o hfs+: export mark_page_accessed
  o hfs+: Makefile update

Tom Rini:
  o PPC32: Add support for the Motorola PowerPlus family of boards
  o PPC32: Remove trailing whitespace in numerous files

