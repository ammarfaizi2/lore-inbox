Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUFPUsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUFPUsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUFPUsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:48:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264788AbUFPUqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:46:30 -0400
Date: Wed, 16 Jun 2004 15:33:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre6
Message-ID: <20040616183343.GA9940@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -pre6. It contains a significant amount of USB fixes, JFS update, 
netfilter/sctp fixes, CDROM driver update, tg3 update, SPARC/Alpha fixes.

And more importantly the FPU x86/x86-64 crash fix.

Read the detailed changelog for more details.

Summary of changes from v2.4.27-pre5 to v2.4.27-pre6
============================================

<andrej.filipcic:ijs.si>:
  o USB: pl2303 & input overruns

<chaapala:cisco.com>:
  o [CRYPTO]: Fix digest.c kmapping sg entries > page in length

<hadi:zynx.com>:
  o [NETFILTER]: Small interface cleanup for {ipt,ip6t,arpt}_find_target

<jan:ccsinfo.com>:
  o USB ftdi device ids for 2.4

<jhh:lucent.com>:
  o [SCTP] Fix to not setup a new association if the endpoint is in SHUTDOWN_ACK_SENT state and recognizes that the peer has restarted. 
  o [SCTP] Fix to not start a new association on a 1-many style sendmsg() with MSG_EOF/MSG_ABORT flag and no data.

<juhl-lkml:dif.dk>:
  o [NET]: Remove junk from packet_mmap.txt

<kumar.gala:freescale.com>:
  o Simple build fix for PPC 826x

<martin.lubich:gmx.at>:
  o USB: add Clie TH55 Support in visor kernel module

<nickpiggin:yahoo.com.au>:
  o rwsem race fixes backported from 2.6

<raven:themaw.net>:
  o minor autofs4 fs/namei.c fix, URL update

<shurick:sectorb.msk.ru>:
  o i2c-matroxfb and i2c initialization order

Andi Kleen:
  o Fix argument parsing in x86-64 machine check handler
  o Fix LDT/TSS limit on x86-64
  o Fix compilation without CONFIG_SWIOTLB on x86-64
  o Fix boot loader warnings on x86-64
  o Add missing memory clobber to i386
  o Fix K8 machine check decoding
  o Fix FPU delayed exceptions on x86-64 too

Andreas Dilger:
  o [IPV4]: Fix bug in arp_tables.c fix

Bartlomiej Zolnierkiewicz:
  o clarify help entries for Promise IDE drivers a bit
  o ide: add new nForce IDE/SATA device IDs to amd74xx.c

Ben Collins:
  o video1394: Bugfix for low res format7 images
  o sbp2: Default sbp2_serialize_io to 1
  o pcilynx: Disable LCtrl bit with IRM contender

Dave Kleikamp:
  o JFS: Handle out of space errors more gracefully
  o JFS: Better RAS when btstack is overrun
  o JFS: Don't allow reading beyond the inode map's EOF
  o JFS: Fix compilation error

David Brownell:
  o EHCI fixes (byteswap, BIOS)
  o EHCI fixes (byteswap, BIOS)

David S. Miller:
  o [TG3]: Use HOST TXDs always
  o [IPV4]: Fix unaligned accesses in arp_tables.c
  o [TG3]: Chip support update and a power-save bug fix
  o [TG3]: Update driver version and reldate
  o [SPARC]: Report si_addr in SIGINFO more accurately

Greg Kroah-Hartman:
  o USB: fix empty write issue in pl2303 driver

Harald Welte:
  o [NETFILTER]: Don't assign new helper after NAT when there are already expectations present

Herbert Xu:
  o Fix /proc/ide/hpt366 crash

Hideaki Yoshifuji:
  o [UDPv4]: Pass correct socket to ip_mc_sf_allow

Ivan Kokshaysky:
  o Alpha: don't put IDE disks in standby mode on halt
  o Alpha: fix PCI bridge swizzle on takara and eiger

Jamal Hadi Salim:
  o [NET]: Add ARPHRD_NONE and use it in tun driver

Jens Axboe:
  o DVD-RW write support
  o cdrom hardware defect mgt header length

Marcelo Tosatti:
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20040606231521|43962
  o Thomas Winischhofer: sisfb update
  o Alexander Nyberg/Andi/Sergey: Fix x86 "clear_cpu()" macro
  o Changed EXTRAVERSION to -pre6
  o Michael Reinelt: Add support for NetMos 9835 serial cards
  o John Carlson: Remove bogus ";" from USB gadgets's usb_descriptor_fillbuf

Mike Miller:
  o cciss update

Neil Brown:
  o Fix hard-to-hit BUG in raid5 resync code

Nuno Monteiro:
  o Fix rwsem-fix typo
  o Complete rwsem typo fix

Pete Zaitcev:
  o Fix USB serial race
  o USB: Update mct_u232
  o USB: unusual_dev.h add Sony Handycam HC-85

Sridhar Samudrala:
  o [SCTP] Fix the use of cached non-zero vtag in an INIT that is resent after a stale cookie error.
  o [SCTP] Fix missing VTAG validation on certain incoming packets
  o [SCTP] Fix to wakeup blocking connect() after max INIT retries failed
  o [SCTP] Fix poll() on a 1-1 style socket so that it returns when the association is aborted by peer.

