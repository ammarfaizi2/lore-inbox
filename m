Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbTISNYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTISNYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:24:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62130 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261559AbTISNYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:24:44 -0400
From: tomepperly@comcast.net
To: linux-kernel@vger.kernel.org
Subject: Re: Trouble with Cisco Aironet 350 PCMCIA in 2.4.21 & 2.4.22 (Unable to handle kernel NULL pointer upon removal)
Date: Fri, 19 Sep 2003 13:24:42 +0000
X-Mailer: AT&T Message Center Version 1 (Sep 12 2003)
X-Authenticated-Sender: dG9tZXBwZXJseUBjb21jYXN0Lm5ldA==
Message-Id: <S261559AbTISNYo/20030919132444Z+13866@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time I got another log message when I pulled the Aironet PCMCIA card out
while running x86 2.4.22.

Sep 18 15:58:07 driftcreek kernel: Linux version 2.4.22 (root@driftcreek) (gcc
version 2.95.4 20011002 (Debian prerelease)) #7 Thu Sep 18 14:49:08 PDT 2003
Sep 18 15:58:58 driftcreek kernel: Uniform CD-ROM driver Revision: 3.12
Sep 18 15:59:38 driftcreek cardmgr[510]: initializing socket 1
Sep 18 15:59:39 driftcreek kernel: cs: memory probe 0x0c0000-0x0fffff: excluding
0xc0000-0xcffff 0xe0000-0xfffff
Sep 18 15:59:39 driftcreek cardmgr[510]: socket 1: 350 Series Wireless LAN Adapter
Sep 18 15:59:39 driftcreek cardmgr[510]:   product info: "Cisco Systems", "350
Series Wireless LAN Adapter"
Sep 18 15:59:39 driftcreek cardmgr[510]:   manfid: 0x015f, 0x000a  function: 6
(network)
Sep 18 15:59:39 driftcreek cardmgr[510]: executing: 'modprobe airo_cs'
Sep 18 15:59:39 driftcreek kernel: airo:  Probing for PCI adapters
Sep 18 15:59:39 driftcreek kernel: airo:  Finished probing for PCI adapters
Sep 18 15:59:39 driftcreek kernel: airo: register interrupt 0 failed, rc -16
Sep 18 15:59:39 driftcreek kernel: airo_cs: RequestConfiguration: Operation
succeeded
Sep 18 15:59:40 driftcreek cardmgr[510]: get dev info on socket 1 failed:
Resource temporarily unavailable

This is what appeared in the log when I removed the card.


Sep 18 15:59:59 driftcreek kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000028
Sep 18 15:59:59 driftcreek kernel:  printing eip:
Sep 18 15:59:59 driftcreek kernel: f0db4947
Sep 18 15:59:59 driftcreek kernel: *pde = 2f9d5067
Sep 18 15:59:59 driftcreek kernel: *pte = 00000000
Sep 18 15:59:59 driftcreek kernel: Oops: 0000
Sep 18 15:59:59 driftcreek kernel: CPU:    0
Sep 18 15:59:59 driftcreek kernel: EIP:    0010:[<f0db4947>]    Not tainted
Sep 18 15:59:59 driftcreek kernel: EFLAGS: 00013202
Sep 18 15:59:59 driftcreek kernel: eax: 01800003   ebx: 00000000   ecx: 01800002
  edx: eefb0a80
Sep 18 15:59:59 driftcreek kernel: esi: 00000008   edi: 00000001   ebp: effda000
  esp: effdbf3c
Sep 18 15:59:59 driftcreek kernel: ds: 0018   es: 0018   ss: 0018
Sep 18 15:59:59 driftcreek kernel: Process keventd (pid: 2, stackpage=effdb000)
Sep 18 15:59:59 driftcreek kernel: Stack: eefb0880 00000008 f0d80ca6 00000008
00000001 eefb08bc ee11d800 00000080 
Sep 18 15:59:59 driftcreek kernel:        effdbfe0 f0d80cd3 ee11d800 00000008
00000001 ee11d800 f0d80d56 ee11d800 
Sep 18 15:59:59 driftcreek kernel:        effdbfa4 effdbfa4 00000020 f0d87dee
ee11d800 00000080 c011a27c f0d8908c 
Sep 18 15:59:59 driftcreek kernel: Call Trace:    [<f0d80ca6>] [<f0d80cd3>]
[<f0d80d56>] [<f0d87dee>] [<c011a27c>]
Sep 18 15:59:59 driftcreek kernel:   [<f0d8908c>] [<f0d890cc>] [<f0d890cc>]
[<c01213d7>] [<c0105548>]
Sep 18 15:59:59 driftcreek kernel: 
Sep 18 15:59:59 driftcreek kernel: Code: 8b 4b 28 b8 02 00 00 00 0f b3 41 2c 19
c0 85 c0 74 0c 8b 41 
Sep 19 06:14:35 driftcreek syslogd 1.4.1#11: restart
> My Aironet 350 PCMCIA card works fine with 2.4.20 and hasn't worked with vanilla
> 2.4.21  or 2.4.22 (with Debian patches). I've got a Dell Latitude with a 1.2GHz
> mobile P3.
> 
> Here is what appears in my /var/log/syslog when I plug the card into the laptop.
> Sep 18 13:35:56 driftcreek cardmgr[510]: initializing socket 1
> Sep 18 13:35:57 driftcreek kernel: cs: memory probe 0x0c0000-0x0fffff: excluding
> 0xc0000-0xcffff 0xe0000-0xfffff
> Sep 18 13:35:57 driftcreek cardmgr[510]: socket 1: 350 Series Wireless LAN 
> Adapter
> Sep 18 13:35:57 driftcreek cardmgr[510]:   product info: "Cisco Systems", "350
> Series Wireless LAN Adapter"
> Sep 18 13:35:57 driftcreek cardmgr[510]:   manfid: 0x015f, 0x000a  function: 6
> (network)
> Sep 18 13:35:57 driftcreek cardmgr[510]: executing: 'modprobe airo_cs'
> Sep 18 13:35:57 driftcreek kernel: airo:  Probing for PCI adapters
> Sep 18 13:35:57 driftcreek kernel: airo:  Finished probing for PCI adapters
> Sep 18 13:35:57 driftcreek kernel: airo: register interrupt 0 failed, rc -16
> Sep 18 13:35:57 driftcreek kernel: airo_cs: RequestConfiguration: Operation
> succeeded
> Sep 18 13:35:58 driftcreek cardmgr[510]: get dev info on socket 1 failed:
> Resource temporarily unavailable
> 
> At this point, the system ignores the keyboard. Otherwise, the system is
> responsive to my USB mouse and X11 continues responding.
> 
> Tom

