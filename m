Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270817AbTHAQPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 12:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270820AbTHAQPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 12:15:54 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:21964 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270817AbTHAQPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 12:15:48 -0400
Date: Fri, 1 Aug 2003 13:19:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.22-pre10
Message-ID: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here goes -pre10, hopefully the last -pre of 2.4.22. 

It contains a bunch of important fixes, detailed below.

Please help testing.


Summary of changes from v2.4.22-pre9 to v2.4.22-pre10
============================================

<achirica:telefonica.net>:
  o [wireless airo] sync with 2.6
  o [wireless airo] Simplify dynamic buffer code in Cisco extensions
  o [wireless airo] Update  structs with the new fields in latest firmwares
  o [wireless airo] Make locking "per thread" so it's fully preemptive
  o [wireless airo] Don't sleep when the stats are requested
  o [wireless airo] Don't call MIC functions if the card doesn't support them
  o [wireless airo] Fix small endianness bug
  o [wireless airo] Returns proper status in case of transmission error
  o [wireless airo] Checks for small packets before transmitting them
  o [wireless airo] Return channel in infrastructure mode
  o [wireless airo] Update to wireless extensions 15 (add monitor mode)
  o [wireless airo] Update to wireless extensions 16 (new spy API)
  o [wireless airo] fix Tx race
  o [wireless airo] safer shutdown sequence
  o [wireless airo] eliminate infinite loop
  o [wireless airo] makes the card passive when entering monitor mode
  o [wireless airo] adds support for noise level reporting (if available)

<bjorn.helgaas:hp.com>:
  o trivial 2.4 HCDP documentation/config patch

<herbert:13thfloor.at>:
  o ROOT NFS fixes

<marcelo:logos.cnet>:
  o NMI watchdog documentation for x86-64

<mike.miller:hp.com>:
  o cciss update: author change
  o cciss update: Fix problem with shared IRQs

Adam Radford:
  o 3ware driver update

Adrian Bunk:
  o fix IPMI build error #if CONFIG_ACPI_HT_ONLY

Benjamin Herrenschmidt:
  o ppc32: export hash_table_lock on SMP for MacOnLinux

Dave Kleikamp:
  o JFS: write_super_lockfs should mark superblock clean

Jan Harkes:
  o Coda fixes

Jay Vosburgh:
  o [netdrvr bonding] fix ifenslave ia64 build

Jeff Garzik:
  o [netdrvr] add new broadcom 440x net driver, "b44"

Marc-Christian Petersen:
  o Fix AGPGART problem with 4GB RAM
  o Fix irq handling of IO-APIC edge IRQs on UP
  o MXCSR Handler Unspecified Vulnerability
  o Fix /proc/self security issue
  o Add missing -EFAULT for sysctl

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre10

Oleg Drokin:
  o reiserfs: fix savelinks for bigendian arches

Petr Vandrovec:
  o ncpfs: Support for clustered NetWare volumes
  o matroxfb: extended support for mplayer

Shmulik Hen:
  o [bonding] fix ifenslave ABI bug
  o [netdrvr bonding] fix ARP monitoring bug

Trond Myklebust:
  o If an RPC request has to be resent due to a timeout, it turns out that call_encode() may cause rq_rcv_buf to be reset despite the fact that a reply might be delivered at any moment by a softirq.
  o If xdr_kmap() fails, we need to ensure that it unmaps all the pages, and returns 0. We don't want to be sending partial RPC requests to the server.

Willy Tarreau:
  o ACPI poweroff fix
  o [netdrvr bonding] fix a typo in the MODULE_PARM_DESC
  o [netdrvr bonding] fix kernel panic when optional feature used


