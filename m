Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRK0Ntu>; Tue, 27 Nov 2001 08:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRK0Ntk>; Tue, 27 Nov 2001 08:49:40 -0500
Received: from firewall.sfn.asso.fr ([193.49.43.1]:37287 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S279556AbRK0NtZ>;
	Tue, 27 Nov 2001 08:49:25 -0500
Date: Tue, 27 Nov 2001 14:49:00 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: linux-kernel@vger.kernel.org
Subject: Ieee1394
Message-ID: <20011127144900.A21231@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AFW-4300 card, Lacie pocket hard drive.
I compiled a fresh 2.4.16 (which works perfect :-) ).
I installed the latest modutils version I found at kernel.org (rpm -Uvh
--force --nodeps (nodeps because it won't install because of a tiny kde
app called ksysguard and I don't need it.)
I have also the hotplug package installed and he ieee1394.agent file.

First, I want to report a crash:

----------------------------------snip-----------------------------------
Nov 27 13:21:08 test17-248 kernel: ieee1394: received packet: ffc30160
ffc20000 00000000 58000020
Nov 27 13:21:08 test17-248 kernel: ieee1394: Node 1:1023 changed to
2:1023
Nov 27 13:21:08 test17-248 kernel: Unable to handle kernel paging
request at virtual address 00623430
Nov 27 13:21:08 test17-248 kernel:  printing eip:
Nov 27 13:21:08 test17-248 kernel: d11cae62
Nov 27 13:21:08 test17-248 kernel: *pde = 00000000
Nov 27 13:21:08 test17-248 kernel: Oops: 0002
Nov 27 13:21:08 test17-248 kernel: CPU:    0
Nov 27 13:21:08 test17-248 kernel: EIP:    0010:[<d11cae62>]    Not
tainted
Nov 27 13:21:08 test17-248 kernel: EFLAGS: 00010296
Nov 27 13:21:08 test17-248 kernel: eax: 00623430   ebx: cb80394c   ecx:
c026bec0   edx: d11c5000
Nov 27 13:21:08 test17-248 kernel: esi: c033c0e0   edi: c033c0e0   ebp:
cd42b000   esp: c14edf08
Nov 27 13:21:08 test17-248 kernel: ds: 0018   es: 0018   ss: 0018
Nov 27 13:21:08 test17-248 kernel: Process keventd (pid: 2,
stackpage=c14ed000)
Nov 27 13:21:08 test17-248 kernel: Stack: cb80394c cd42b000 c033c0e0
d11c50a0 00000246 0000ffc2 d11ca5fd cd42b000
Nov 27 13:21:08 test17-248 kernel:        c033c0e0 d11c5000 cb80394c
cf828c4c 00ff5000 d11b9dfe cb8038c0 20000058
Nov 27 13:21:08 test17-248 kernel:        00d04b20 0000ffc2 d11ba0a1
cf828c20 00ff5000 d11c5000 0000ffc2 c14edfa4
Nov 27 13:21:08 test17-248 kernel: Call Trace: [<d11ca5fd>] [<d11b9dfe>]
[<d11ba0a1>] [__run_task_queue+76/96] [context_thread+283/416]
Nov 27 13:21:08 test17-248 kernel:    [kernel_thread+40/56]
Nov 27 13:21:08 test17-248 kernel:
Nov 27 13:21:08 test17-248 kernel: Code: c7 00 00 00 00 00 8b 46 18 c7
40 04 00 00 00 00 8b 46 18 c7
----------------------------------snip-----------------------------------
I hope here is enough, and if you need more, I can send a lot more.
It happened while plugging Hard drives (I plugged 1, the second, and at
the third one, it crashed).
ieee1394 , ohci1394 and sbp2 modules were loaded.
I have the "Excessive debugging output" option enabled.

The second problem I have is:
I don't really understand what for is the hotplug ? can It automatically
mount any new firewire disk I plugged ? How should I do it?
Does someone have a sample script which does  something like:
fdisk -l /dev/$justplugged | awk ... | grep ... ; for i in
$mountabledevices ; do mkdir /mnt/$cnt ; mount ... ; done 
( I hope you got what I'm searching for.)

        Thanks for any help.
                Sam
