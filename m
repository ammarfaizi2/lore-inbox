Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbSKFQEc>; Wed, 6 Nov 2002 11:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265750AbSKFQEb>; Wed, 6 Nov 2002 11:04:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43025 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265747AbSKFQEY>; Wed, 6 Nov 2002 11:04:24 -0500
Message-Id: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: dmesg of 2.5.45 boot on NFS client
Date: Wed, 6 Nov 2002 18:57:45 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Registering system device cpu0
adding '' to cpu class interfaces
      ^^^^

;) What's this?


Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
    ^^

;) 

register interface 'mouse' with class 'input

there's no closing '

TCP: Hash tables configured (established 4096 bind 5461)
Sending DHCP requests .fix old protocol handler ic_bootp_recv+0x0/0x3a0!
.fix old protocol handler ic_bootp_recv+0x0/0x3a0!
,fix old protocol handler ic_bootp_recv+0x0/0x3a0!
 OK

Aha... todo for me...

IP-Config: Got DHCP answer from 255.255.255.255, my address is 172.16.42.177
IP-Config: Complete:
      device=eth0, addr=172.16.42.177, mask=255.255.255.0, gw=172.16.42.98,
     host=(none), domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=172.16.42.75, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.42.75
Looking up port of RPC 100005/1 on 172.16.42.75
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 604k freed

~30 seconds of no apparent activity
I pressed SysRq-P couple of times, they all looked the same:

SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c01071aa>] CPU: 0
EIP is at default_idle+0x2a/0x50
 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c0466000 ECX: c0447800 EDX: c0466000
ESI: c0107180 EDI: c0466000 EBP: 0008e000 DS: 0068 ES: 0068
CR0: 8005003b CR2: 40001000 CR3: 07d54000 CR4: 000006d0
Call Trace:
 [<c010725a>] cpu_idle+0x3a/0x50
 [<c0105000>] stext+0x0/0x70

No need for ksymoops. Wow.

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 93M
agpgart: agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xf0000000
