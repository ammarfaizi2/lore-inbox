Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVAMACS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVAMACS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVALX7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:59:20 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:21923 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261600AbVALX5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:57:20 -0500
Date: Thu, 13 Jan 2005 00:57:16 +0100 (CET)
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.2.27-rc2
Message-ID: <010501130042170.1701@vobbx.ybpny>
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here goes 2nd release candidate of v2.2.27. It contains security fixes 
including todays discovered SMP pagefault race, amongst others.


2.2.27-rc2
----------
o	CAN-2005-0001: fixed expand_stack() SMP race		(Redhat)
o	CAN-2004-0883, CAN-2004-0949: smbfs: fixed client	(Stefan Esser)
 	  overflow. There are two bugs in the handling of SMB
 	  responses that result in remote kernel overflows. Due
 	  to the nature of the bugs both seem to be very hard
 	  to exploit (in the sense of remote code execution or
 	  local privilege escalation) but are trivial remote
 	  kernel crashes.
o	rose_rt_ioctl: lack of bounds checking			(Coverity)
o	sdla_xfer: lack of bounds checking			(Coverity)
o	coda: bounds checking for tainted scalars		(Coverity)
o	sendmsg compat wrapper fixes for 64bit compat mode	(Olaf Kirch)



2.2.27-rc1
----------
o	CAN-2004-0497: fixed missing DAC check on sys_chown	(Thomas Biege)
o	CAN-2004-1016: fixed a buffer overflow vulnerability	(Paul Starzetz)
 	  in the "__scm_send" function which handles the sending
 	  of UDP network packets. A wrong validity check of the
 	  cmsghdr structure allowed a local attacker to modify
 	  kernel memory, thus causing an endless loop (DoS) or
 	  possibly even root privilege escalation.
o	CAN-2004-1333: fixed integer overflow in the vc_resize	(Georgi Guninski)
 	  function allows local users to cause a denial of
 	  service (kernel crash) via a short new screen value,
 	  which leads to a buffer overflow. Make sure VC
 	  resizing fits in s16.
o	If the user makes ip_cmsg_send call ip_options_get	(Georgi Guninski)
 	  multiple times, we leak kmalloced IP options data.
o	fixed moxa serial bound checking issue			(Alan Cox)
o	menu cleanups						(me)



2.2.27-pre2
-----------
o	A more correct fix to last mremap (2) bug		(Dan Yefimov/Solar Designer)
o	renamed imho *bogus* _vsnprintf to vsnprintf		(me)
o	fixed 'noexec' behaviour (2.4 backport)			(me)
 	  from Ulrich Drepper


2.2.27-pre1
-----------
o	fixed TCP keepalive bug					(Neal Cardwell)
o       fixed tcp seq nr wrapping bug				(Ulrik De Bie)
o	added cciss root translation table			(Eduard Bloch)
o	VIA KL133/KM133 northbridge: vga console going crazy	(Roberto Biancardi)
o	speedup 'make dep'					(Benoit Poulot-Cazajous)
o	disabled MCE only on Pentiums by default (2.4 backport)	(Herbert Xu)
 	  (boot with 'mce' if your MCE works as expected)
o	skb_realloc_headroom() panics when new headroom is	(James Morris)
 	  smaller than existing headroom
o	invalid nh.raw use after free				(Julian Anastasov)
o	fix a local APIC initaliziation ordering bug that	(Andrea Arcangeli)
 	  triggers on the P4
o	TSC calibration must be dynamic and not a compile	(Andrea Arcangeli)
 	  time thing because gettimeofday is dynamic and it
 	  depends on the TSCs to be in sync
o	fix deadlock on shutdown in 8139too			(Herbert Xu)
o	support for ELF executables which use an a.out format	(Solar Designer)
 	  interpreter (dynamic linker) moved into a separate
 	  configuration option and disabled by default
o	fixed sys_utimes perm check according to sys_utim	(Al Viro)
o	show us the saved kernel command line (2.4 backport)	(me)
o	some whitespace cleanups, some coding style cleanups	(me)
o	fixed some gcc warnings					(me)
o	add PCI ID for 82820 NIC to eepro100 network driver	(me)
o	move 'Network device support' near 'Networking options'	(me)

