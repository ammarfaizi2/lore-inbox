Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271295AbTHHLaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 07:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271298AbTHHLaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 07:30:06 -0400
Received: from [212.18.235.100] ([212.18.235.100]:62373 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S271295AbTHHLaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 07:30:02 -0400
Subject: NMI watchdog and reboots
From: Justin Cormack <justin@street-vision.com>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 08 Aug 2003 12:30:15 +0100
Message-Id: <1060342215.24400.10.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I had a couple of NMI watchdog-detected lockups recently, and despite
the kernel command line being
root=/dev/hda2 nmi_watchdog=1 panic=60 console=ttyS0,115200
I dont actually get a reboot, just the console shuts up message:
NMI Watchdog detected LOCKUP on CPU1, eip c01f0ec1, registers:
CPU:    1
EIP:    0010:[<c01f0ec1>]    Tainted: P
EFLAGS: 00000086
eax: f7e1bc80   ebx: f7e1bc80   ecx: 00000001   edx: 00000001
esi: 04000001   edi: 00000286   ebp: c19b5f54   esp: c19b5ef0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c19b5000)
Stack: f88070c7 c19b5f00 00000000 f7e33600 04000001 00000001 c19b5f54
c0109169
       0000001a f7e1bc80 c19b5f54 c0305500 0000001a f7e33600 00000d00
c0109388
       0000001a c19b5f54 f7e33600 00000001 f7e30c00 f7e30c70 00000001
ffffe000
Call Trace:    [<c0109169>] [<c0109388>] [<c010bf08>] [<c01af80b>]
[<c01af6e0>]
  [<c01af6e0>] [<c01054e2>] [<c011d505>] [<c011d770>]

Code: 7e f5 e9 52 fa ff ff 80 3d 28 28 2b c0 00 f3 90 7e f5 e9 0f
console shuts up ...

I would expect a reboot after this. Also I would expect a reboot from
the i810-tco module which is enabled and running.

Ther kernel is 2.4.21 and the machine is an Intel 7505 chipset, dual
Xeons.

Any ideas abou what is going on would be good...

Justin


