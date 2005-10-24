Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVJXUt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVJXUt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJXUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:49:26 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:61676 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbVJXUtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:49:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=e9tLMHLEE6gLnQv7+yRm15dd2Y11BsY+rfW1d1YqvleVTI33Lut5i5CrG6f9oZR1Zb5MOwcyFpE8ULceodzDleUbC3bkx4W7m4/hurv6ePdm3MMiw+5vxZs7mPtsyTruSbN2F5EokL+M8Jb7aBTv2vTHpXsfCpX/SSUmL+mlFXE=
Subject: Re: 2.6.14-rc5-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
References: <20051024014838.0dd491bb.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 13:48:47 -0700
Message-Id: <1130186927.6831.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> 

I can't seem to keep my AMD64 machine up with 2.6.14-rc5-mm1.
Keep running into following. qlogic driver problem ?

Thanks,
Badari

NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: qlogicfc qla2300 qla2200 qla2xxx firmware_class
ohci_hcd hw_r andom usbcore dm_mod
Pid: 4414, comm: modprobe Not tainted 2.6.14-rc5-mm1 #3
RIP: 0010:[<ffffffff80401d94>] <ffffffff80401d94>{.text.lock.spinlock
+34}
RSP: 0000:ffff81019da91c28  EFLAGS: 00000086
RAX: 0000000000000000 RBX: ffff81017991f288 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff81017991f290
RBP: ffff81019da91c28 R08: 0000000000000034 R09: 0000000000000000
R10: ffff81019da91c08 R11: 0000000000000000 R12: ffff81017991f290
R13: 00000000fffffff4 R14: ffff81017991c000 R15: 0000000000000100
FS:  00002aaaaade36e0(0000) GS:ffffffff80649800(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000836018 CR3: 00000001bdf2a000 CR4: 00000000000006e0
Process modprobe (pid: 4414, threadinfo ffff81019da90000, task
ffff81019e3bb500)
Stack: ffff81019da91cb8 ffffffff80400dec ffff81019da91c78
ffffffff80142ed0
       0000000000000000 0000000000000000 0000000000000001
0000000000000001
       ffff81017991c000 0000000000000100
Call Trace:<ffffffff80400dec>{wait_for_completion+28}
<ffffffff80142ed0>{group_s end_sig_info+128}
       <ffffffff80142f89>{kill_proc_info+73}
<ffffffff8805753c>{:qla2xxx:qla2x00 _free_device+188}
       <ffffffff8805880b>{:qla2xxx:qla2x00_probe_one+4187}
       <ffffffff80132ce0>{set_cpus_allowed+336}
<ffffffff8012dca3>{__wake_up_com mon+67}
       <ffffffff8029741a>{kobject_get+26}
<ffffffff8807c01d>{:qla2200:qla2200_pr obe_one+13}
       <ffffffff802a516c>{pci_device_probe+252}
<ffffffff80308d29>{driver_probe_ device+89}
       <ffffffff80308da0>{__driver_attach+0}
<ffffffff80308de2>{__driver_attach+ 66}
       <ffffffff803086af>{bus_for_each_dev+79}
<ffffffff80308bbc>{driver_attach+ 28}
       <ffffffff80308108>{bus_add_driver+136}
<ffffffff80308f0c>{driver_register +76}
       <ffffffff802a4ebe>{pci_register_driver+158}
<ffffffff8804d010>{:qla2200:q la2200_init+16}
       <ffffffff80154072>{sys_init_module+274}
<ffffffff8010dd2e>{system_call+12 6}


Code: 83 3f 00 7e f9 e9 67 fd ff ff e8 71 ac e9 ff e9 82 fd ff ff
console shuts up ...
scsi3 : QLogic ISP2200 SCSI on PCI bus 19 device 08 irq 21 base 0x4000



