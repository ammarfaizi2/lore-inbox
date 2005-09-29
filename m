Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVI2HOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVI2HOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVI2HOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:14:19 -0400
Received: from web31607.mail.mud.yahoo.com ([68.142.198.153]:64442 "HELO
	web31607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932109AbVI2HOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:14:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1jx+/4JJJDI7nrKpz63dy/EfwFXnNoo6pf6nLCW0eZAEjlLJrQy6V6sE6oKWboH4H8OxlSmFnakZEwZihHmg7IqFPplLdOLA6vVpyZiYwYPtU3fJl360qSUF+EYM6N/CYAx/Z+qZKJogQTAHcZf/t81EatPMNFCg2xPWXuBNudc=  ;
Message-ID: <20050929071418.13722.qmail@web31607.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 00:14:18 -0700 (PDT)
From: fil fil <grossebaf@yahoo.com>
Subject: Crash during rrmod lpfc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During rmmod lpfc with 2.6.12.2 i have this crash :

Sep 27 14:30:55 je kernel: Unable to handle kernel
NULL pointer dereference at
virtual address 00000004
Sep 27 14:30:55 je kernel:  printing eip:
Sep 27 14:30:55 je kernel: c0149415
Sep 27 14:30:55 je kernel: *pde = 3725a001
Sep 27 14:30:55 je kernel: Oops: 0002 [#1]
Sep 27 14:30:55 je kernel: SMP
Sep 27 14:30:55 je kernel: Modules linked in: md5 ipv6
parport_pc lp parport
autofs4 i2c_dev i2c_core sunrpc ipt_REJECT ipt_ state
ip_conntrack
iptable_filter ip_tables dm_mod video button battery
ac uhci_hcd ehci_hcd
hw_random tg3 floppy ext3 jbd s csi_transport_fc cciss
sd_mod scsi_mod
Sep 27 14:30:55 je kernel: CPU:    0
Sep 27 14:30:55 je kernel: EIP:    0060:[<c0149415>]  
 Not tainted VLI
Sep 27 14:30:55 je kernel: EFLAGS: 00010006  
(2.6.12-Test_LPFC)
Sep 27 14:30:55 je kernel: EIP is at
free_block+0x6a/0xd5
Sep 27 14:30:55 je kernel: eax: 00000000   ebx:
f76a6000   ecx: f76a6180
edx: f7d1e000
Sep 27 14:30:55 je kernel: esi: f7fff680   edi:
0000000d   ebp: 0000001e
esp: c54a1efc
Sep 27 14:30:55 je kernel: ds: 007b   es: 007b   ss:
0068
Sep 27 14:30:55 je kernel: Process events/0 (pid: 10,
threadinfo=c54a1000
task=f7fefa80)
Sep 27 14:30:55 je kernel: Stack: f7fff6a8 f7ff7010
f7ff7010 f7ff7000 0000001e
f7fff680 c0149a2b f7fff7a8
Sep 27 14:30:55 je kernel:        f7fff680 00000004
f7fff6d0 c0149bbf f7fff7a8
f7fff704 00000292 00000000
Sep 27 14:30:55 je kernel:        c548e400 c539a104
00000292 c012fb6d 00000000
000f41fb c03aafd0 c548e428
Sep 27 14:30:55 je kernel: Call Trace:
Sep 27 14:30:55 je kernel:  [<c0149a2b>]
drain_array_locked+0x45/0x77
Sep 27 14:30:55 je kernel:  [<c0149bbf>]
cache_reap+0x162/0x1c7
Sep 27 14:30:55 je kernel:  [<c012fb6d>]
worker_thread+0x1b0/0x23a
Sep 27 14:30:55 je kernel:  [<c0149a5d>]
cache_reap+0x0/0x1c7
Sep 27 14:30:55 je kernel:  [<c011cfcf>]
default_wake_function+0x0/0xc
Sep 27 14:30:55 je kernel:  [<c011cfcf>]
default_wake_function+0x0/0xc
Sep 27 14:30:55 je kernel:  [<c012f9bd>]
worker_thread+0x0/0x23a
Sep 27 14:30:55 je kernel:  [<c0133650>]
kthread+0x8a/0xb2
Sep 27 14:30:55 je kernel:  [<c01335c6>]
kthread+0x0/0xb2
Sep 27 14:30:55 je kernel:  [<c01023d1>]
kernel_thread_helper+0x5/0xb
Sep 27 14:30:55 je kernel: Code: 43 04 83 c7 01 39 ef
7d 71 8b 44 24 04 8b 15
10 06 42 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0 c c1 e0
05 8b 5c 10 1c 8b 53 04
8b 03 <89> 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c
c7 03 00 01 10 00

The system is a proliant G4 smp 2 P4 HT with 8 Gb of
ram but compiled with 4Gb for High memory support. The
kernel is a kernel.org and the lpfc module was
compiled into the source tree kernel.

Best regards



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
