Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVIKU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVIKU5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVIKU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:57:13 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:26396 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750877AbVIKU5N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r8KCogOHRfOOftbRWrLyZbkznm2IMLXZTFjztRQ+EM8ubO7gNnq4CvW2pdqpAbN2nAhEC+TgzorfX5fZou5712t5R3o3Te4ZoxyX3TgDKufac+6HfcZNX0F4aWp1SL504GkfxGpF5sskzWYyZ1YlFad+jwQ6Px2MgxFG9GuD8Nk=
Message-ID: <6bffcb0e05091113576925a8e9@mail.gmail.com>
Date: Sun, 11 Sep 2005 22:57:07 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: oops plugsched, spa_ws, scsi, sata, ata_piix, threading 2.6.13-mm2
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4323896F.5050703@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4323896F.5050703@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:
Oops when starting system.

[2.] Full description of the problem/report:
Kernel boot params:
kernel /vmlinuz-2.6.13-mm2 root=/dev/sda1 ro cpusched=spa_ws

[3.] Keywords (i.e., modules, networking, kernel):
plugsched, spa_ws, scsi, sata, ata_piix, threading

[4.] Kernel version (from /proc/version):
Linux version 2.6.13-mm2 (root@ng02.pl) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #3 SMP PREEMPT Sun Sep 11 14:20:57 CEST 2005

[5.] Output of Oops
Process ksoftirqd/0 (pid: 3, threadinfo=c03e3000 task=c195e620)

Stack: c01f870f f7d0f24c f7d0f24c c1bccc80 f7d0e9e8 00000202 c0274562 f2d0e9e8
       00000000 00000024 00000001 00040000 00000024 c1bccc80 c02748e5 c1bccc80
       00000000 00000024 00000001 00000000 00000000 00000000 f7d0e9e8 00000024

Call trace:
[<c01f870f>] kobject_put+0x1f/0x30
[<c0274562>] scsi_end_request+0xd2/0xf0
[<c02748e5>] scsi_io_competition+0x235/0x460
[<c0274de5>] scsi_generic_done+0x35/0x50
[<c026f9ee>] scsi_finish_command+0x7e/0xa0
[<c026f8a0>] scsi_softirq+0xd0/0x150
[<c0125ee3>] tasklet_action+0x73/0xe0
[<c0125b86>] __do_softirq+0xd6/0xf0
[<c01055af>] do_softirq+0x4f/0x60
=======================
[<c0126165>] ksoftirqd+0x95/0x100
[<c01260d0>] ksoftirqd+0x0/0x100
[<c01367ba>] kthread+0xba/0xc0
[<c0136700>] kthread+0x0/0xc0
[<c0101275>] kernel_thread_helper+0x5/0x10

Code: 7d 07 00 89 44 24 04 89 1c 24 e8 67 69 ff ff ff eb a5 90 8d 74
26 00 55 57 56 53 83 ec 08 86 44 24 1c 89 44 24 04 8b 80 f8 00 00 00
<8b> 38 f6 80 7d 01 00 00 80 0f 85 96 00 00 00 8b 47 34 8d 6f 24

<0> Kernel panic - not syncing: Fatal exception in interrupt



  _|_|                _|
_|    _|  _|  _|_|  _|_|_|_|
_|    _|  _|_|        _|
_|    _|  _|          _|
  _|_|    _|            _|_|
OOPS Reporting Tool v.b5
www.wsi.edu.pl/~piotrowskim/
/files/ort/beta/

Regards,
Michal Piotrowski
