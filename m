Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUBEMom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUBEMom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:44:42 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12458 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265216AbUBEMoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:44:38 -0500
Date: Thu, 5 Feb 2004 10:44:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-rc1
Message-ID: <Pine.LNX.4.58L.0402051037190.9788@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes the first release candidate.

It contains mostly networking updates, XFS update, amongst others.

This release contains a fix for excessive inode memory pressure with
highmem boxes. Help is specially wanted with testing this on heavy-load
highmem machines.


Summary of changes from v2.4.25-pre8 to v2.4.25-rc1
============================================

<chrisw:osdl.org>:
  o Verify interpreter arch

<davej:redhat.com>:
  o fix agpgart warning

<davem:nuts.davemloft.net>:
  o [IRDA]: Mark driver init/exit funcs static where possible
  o [SPARC64]: Fix TUNSETIFF ioctl compat, it takes an ifreq ptr not an int
  o [TG3]: Bump version and reldate
  o [SPARC64}: Fix ultra-III and later support of new-style SILO booting

<grundler:parisc-linux.org>:
  o [TG3]: Fix DMA test failures
  o [TG3]: Only fetch NVRAM_CMD reg if TG3_FLAG_NVRAM

<jlcooke:certainkey.com>:
  o [CRYPTO]: Help gcc optimize sha256/sha512 better

<jmorris:redhat.com>:
  o [CRYPTO]: Make padding[] array static in sha{256,512}_final()
  o Zero last byte of mount option page

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc1

<rml:ximian.com>:
  o Fix sys_readahead(): Count free pages on maximum ra size calculation

Adrian Bunk:
  o fix a compile warning in amd76x_pm.c
  o fix a compile warning in tipar.c
  o fix a compile warning in InterMezzo file.c

Ben Collins:
  o [SPARC64]: Add comment for HdrS ver 0x201
  o [SPARC64]: Add header for section boundary references
  o [SPARC64]: Changes to accomodate booting from non-phys_base memory

Chas Williams:
  o [ATM]: [idt77252] fix dma_addr_t type error with CONFIG_HIGHMEM64G=y (by "Randy.Dunlap" <rddunlap@osdl.org>)
  o [ATM]: [clip] check return code from kmem_cache_create (by "Randy.Dunlap" <rddunlap@osdl.org>)

Christoph Hellwig:
  o [XFS] Small ktrace fixes
  o [XFS] Don't fail pagebuf allocations

David Brownell:
  o usb/gadget/file_storage.c doesn't compile with gcc 2.95

David S. Miller:
  o [DECNET]: Fix filling in of header length field
  o [CREDITS]: Update Bjorn Ekwall's address

David Stevens:
  o [IPV4]: Add per-device sysctl to force IGMP version
  o [IPV4]: Fix IGMP device reference counting

Harald Welte:
  o [NETFILTER]: Fix ipt_conntrack/ipt_state module refcounting
  o [NETFILTER]: Really fix ipt_state/ipt_conntrack refcounting

Herbert Xu:
  o invalid kfree in ntfs_printcb

Luca Tettamanti:
  o Fix ac97_plugin_ad1980.c compilation warning
  o Fix aha1542.c compilation warning
  o Fix cpqfcTSi2c.c compilation warning
  o IEEE1394(r1123): Fix compile warning
  o Fix amd7930_fn.h compilation warning
  o Fix drivers/net/wan/8253x/crc32.c compilation warning
  o Fix vac-serial.c compilation warning

Mirko Lindner:
  o sk98lin: Reset Xmac when stopping the port

Nathan Scott:
  o [XFS] Remove xfsidbg debugger interfaces, not useful without kdb
  o [XFS] Fix a warning from some gcc variants after recent flags botch
  o [XFS] Add the security extended attributes namespace
  o [XFS] Remove no-longer-needed debug symbol exports

Patrick McHardy:
  o [NET_SCHED]: Add HFSC packet scheduler

Russell Cattelan:
  o [XFS] Christoph has signed over copyrights
  o [XFS] Move bits around to better manage common code.  No functional change
  o [XFS] Remove non 2.4 ifdefs from the linux-2.4 dir

Rusty Russell:
  o [NETFILTER]: ipt_limit fix for HZ=1000

Scott Feldman:
  o e100 sync with 2.6

