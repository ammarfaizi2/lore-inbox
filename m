Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTKZUzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTKZUzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:55:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:56253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264324AbTKZUzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:55:02 -0500
Date: Wed, 26 Nov 2003 12:55:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Beaver in Detox!
Message-ID: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 for everybody who thought "stoned beaver" wasn't an appropriate name for
a kernel (yeah, I'm sure IBM really minds my naming scheme, and is deathly
afraid it will scare away customers), I'm happy to tell you that the
beaver just went into detox, and I'm taking the Thanksgiving weekend off.

I give you "Beaver in Detox", aka linux-2.6.0-test11. This is mainly
brought on by the fact that the old aic7xxx driver was broken in -test10,
and Ingo found this really evil test program that showed an error case in
do_fork() that we had never handled right. Well, duh!

While at it, this also pulls in some firewire fixes and a few potential
skbuff leakage points.

Please don't even bother sending me patches, because I'll be stuffing my
face away from email over the next few days. And after that it will be up
to Andrew to say how to go on from here.

Mmmm. Turkey.


		Linus


Summary of changes from v2.6.0-test10 to v2.6.0-test11
============================================

Bart De Schuymer:
  o [BRIDGE]: Fix netfilter config tests

Ben Collins:
  o Lastminute IEEE-1394 fixes

Benjamin Herrenschmidt:
  o [libata] Fix flush of Device Control register to device

Dave Kleikamp:
  o JFS: Avoid segfault when dirty inodes are written on readonly mount

David Mosberger:
  o ia64: Correct FIXADDR_USER_END so that single-stepping in the gate
    DSO works again
  o ia64: Make core-dumps work even when executing in the gate DSO

David S. Miller:
  o [NET]: In sock_queue_rcv_skb(), do not deref skb->len after it is
    queued to the socket
  o [PPPOE]: Do not leak SKB if sock_queue_rcv_skb() fails
  o [ECONET]: Do not leak SKBs if ec_queue_packet() fails

David Stevens:
  o [IPV6]: Multicast output bypasses netfilter hooks, fix

Hideaki Yoshifuji:
  o [IPV6]: Redo stateless addrconf properly

James Bottomley:
  o Updated state model for SCSI devices
  o Fix locking problems in scsi_report_bus_reset() causing aic7xxx to
    hang

Jan Marek:
  o fix smsc-ircc2.c double free

Jean Tourrilhes:
  o [IRDA]: Fix SKB leaks

Jeff Garzik:
  o [libata] bump versions for core and serverworks driver

Linus Torvalds:
  o Fix error return on concurrent fork() with threaded exit()

Mike Anderson:
  o scsi device ref count (update)

Pekka Pietikäinen:
  o [libata] add Promise PCI id

Pete Zaitcev:
  o [SPARC]: Add stub sched_clock() implementation
  o [SPARC]: Fix build failures in IGA frame buffer introduced by
    janitor changes

Stephen Hemminger:
  o prevent oops from read of proc entry for tty drivers

