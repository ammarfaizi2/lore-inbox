Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBXWHp>; Mon, 24 Feb 2003 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTBXWHp>; Mon, 24 Feb 2003 17:07:45 -0500
Received: from ogre-out.blic.net ([217.23.192.21]:63963 "HELO ogre.blic.net")
	by vger.kernel.org with SMTP id <S261292AbTBXWHm>;
	Mon, 24 Feb 2003 17:07:42 -0500
Subject: kernel BUG at kernel/timer.c:155!
From: Igor =?iso-8859-2?Q?Lon=E8arevi=E6?= <anubis@IgorLoncarevic.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: axboe@suse.de
Content-Type: text/plain
Organization: Igor =?ISO-8859-1?Q?Lon=C4=8Darevi=C4=87?= Self-Organized
Message-Id: <1046125070.847.6.camel@anubis.bl.gozostudios.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 23:17:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel: all 2.5.x, including latest (2.5.63)
Bug: cannot use CD Writer on development kernels

Part of dmesg:

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W524E          Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0


When trying to access CD Writer I have:


hdd: lost interrupt
hdd: status error: status=0x20 { DeviceFault }
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
hdd: ATAPI reset complete
ide-scsi: abort called for 0
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0108136>]  [<c01156b0>]  [<c010834c>] 
[<c0213dca>]  [<c0213400>]  [<c0219499>]  [<c021298f>]  [<c02127e0>] 
[<c02127c0>]  [<c0212ab5>]  [<c0212c14>]  [<c0213916>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
ide-scsi: reset called for 0
bad: scheduling while atomic!
Call Trace: [<c0115643>]  [<c0120b9f>]  [<c011960d>]  [<c0120b30>] 
[<c0218600>]  [<c02195b1>]  [<c02194b0>]  [<c0212ed2>]  [<c0212f76>] 
[<c02137cb>]  [<c0213956>]  [<c0213a14>]  [<c0213960>]  [<c0107129>]  
------------[ cut here ]------------
kernel BUG at kernel/timer.c:155!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0120183>]    Not tainted
EFLAGS: 00010002
eax: 00000001   ebx: dfe2ed80   ecx: c02cd3e0   edx: c0358b08
esi: dfd24000   edi: dfe2eda4   ebp: c01fb600   esp: dfd25ea0
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 8, threadinfo=dfd24000 task=dfdcac80)
Stack: c011960d 0000000a dfe2ed80 dfd24000 00000096 c01fb4fe dfe2eda4
c0107129
       00026264 c010983f 00000000 00000032 00000000 c0358b08 c0358b08
00000000
       c01fbbed c0358b08 c01fb600 00000032 00000000 dfe2ed80 00000086
00000000
Call Trace: [<c011960d>]  [<c01fb4fe>]  [<c0107129>]  [<c010983f>] 
[<c01fbbed>]  [<c01fb600>]  [<c01fbc42>]  [<c021958a>]  [<c02194b0>] 
[<c0212ed2>]  [<c0212f76>]  [<c02137cb>]  [<c0213956>]  [<c0213a14>] 
[<c0213960>]  [<c0107129>]
Code: 0f 0b 9b 00 78 18 2a c0 eb 90 90 89 f6 83 ec 14 31 c0 89 7c
 <6>note: scsi_eh_0[8] exited with preempt_count 3
hdd: ATAPI reset complete




Regards,
Igor


Is knowledge knowable? If not, how do we know that?

