Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVKSOUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVKSOUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 09:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKSOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 09:20:45 -0500
Received: from mail.aknet.ru ([82.179.72.26]:20746 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751006AbVKSOUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 09:20:45 -0500
Message-ID: <437F34C7.4010301@aknet.ru>
Date: Sat, 19 Nov 2005 17:20:55 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc1-mm1 Oops
Content-Type: multipart/mixed;
 boundary="------------020209000508060402060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020209000508060402060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
Everything works fine on plain 2.6.14.
Since 2.6.14-mm1 I am getting the attached Oops
(grabbed via netconsole, from 2.6.15-rc1-mm1).
After that Oops, the PC is completely dead.
The Oops happens when the saa7134 module is being
modprobed. Any ideas?


--------------020209000508060402060906
Content-Type: text/plain;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Unable to handle kernel NULL pointer dereference at 00000000000007d0 RIP: 
<ffffffff802b11e0>{input_register_device+16}
PGD 19c6e067 PUD 19c59067 PMD 0 
Oops: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev netconsole ipv6 lp autofs4 ipt_state ip_conntrack iptable_filter ip_tables nls_cp866 vfat fat usbhid video thermal processor fan button battery ac ohci_hcd ehci_hcd i2c_nforce2 shpchp snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii forcedeth floppy sata_nv libata
Pid: 2470, comm: modprobe Not tainted 2.6.15-rc1-mm2 #14
RIP: 0010:[<ffffffff802b11e0>] <ffffffff802b11e0>{input_register_device+16}
RSP: 0018:ffff810019c4bcc8  EFLAGS: 00010292
RAX: 0000000000000000 RBX: ffff81001b783270 RCX: 00000000000000a0
RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000000
RBP: ffff810019c4bcf8 R08: 00000000000000f9 R09: 00000000ffffffff
R10: 00000000ffffffff R11: 0000000000000246 R12: ffff81001b78321c
R13: 0000000000000000 R14: ffff81001b783000 R15: ffff810019d51800
FS:  00002aaaaadfc6e0(0000) GS:ffffffff80508000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000007d0 CR3: 0000000019cd9000 CR4: 00000000000006e0
Process modprobe (pid: 2470, threadinfo ffff810019c4a000, task ffff810001bb8450)
Stack: 0000000000000000 0000000000000246 ffff81001b783270 ffff81001b783270 
       ffff81001b78321c ffff810019b8e000 ffff810019c4bd48 ffffffff881bb2ca 
       00000000000007c8 0000000000000010 
Call Trace:<ffffffff881bb2ca>{:saa7134:saa7134_input_init1+890}
       <ffffffff881b2f3b>{:saa7134:saa7134_initdev+1403} <ffffffff802288cd>{pci_device_probe+93}
       <ffffffff802c585f>{driver_probe_device+79} <ffffffff802c59ca>{__driver_attach+90}
       <ffffffff802c5970>{__driver_attach+0} <ffffffff802c4b8f>{bus_for_each_dev+79}
       <ffffffff802c560c>{driver_attach+28} <ffffffff802c50e8>{bus_add_driver+136}
       <ffffffff802c5d65>{driver_register+117} <ffffffff8014c630>{kthread_stop_sem+256}
       <ffffffff8022850e>{__pci_register_driver+206} <ffffffff881b1e06>{:saa7134:saa7134_init+70}
       <ffffffff80154d18>{sys_init_module+312} <ffffffff8010df30>{tracesys+209}
       
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffff8010f71b>{show_trace+619}
PGD 19c6e067 PUD 19c59067 PMD 0 
Oops: 0000 [2] PREEMPT SMP 
CPU 0 
Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev netconsole ipv6 lp autofs4 ipt_state ip_conntrack iptable_filter ip_tables nls_cp866 vfat fat usbhid video thermal processor fan button battery ac ohci_hcd ehci_hcd i2c_nforce2 shpchp snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii forcedeth floppy sata_nv libata
Pid: 2470, comm: modprobe Not tainted 2.6.15-rc1-mm2 #14
RIP: 0010:[<ffffffff8010f71b>] <ffffffff8010f71b>{show_trace+619}
RSP: 0018:ffff810019c4b9f8  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: ffff810019cbd640
RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001
RBP: ffff810019c4ba38 R08: 0000000000000000 R09: ffff810019b38dc0
R10: 000000000000001f R11: 00000000000003d4 R12: ffff810019c4c000
R13: 0000000000000000 R14: ffffffff804ab0c0 R15: ffffffff80549100
FS:  00002aaaaadfc6e0(0000) GS:ffffffff80508000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000019cd9000 CR4: 00000000000006e0
Process modprobe (pid: 2470, threadinfo ffff810019c4a000, task ffff810001bb8450)
Stack: 0000000000000000 0000000000000000 0000000000000000 ffff810019c4bd18 
       000000000000000a ffffffff804ab0c0 ffffffff804a70c0 0000000000000000 
       ffff810019c4ba78 ffffffff8010f82a 
Call Trace:<ffffffff8010f82a>{show_stack+234} <ffffffff8010f8cb>{show_registers+139}
       <ffffffff8010fd88>{__die+168} <ffffffff8037f03a>{do_page_fault+1882}
       <ffffffff8037ce90>{preempt_schedule+96} <ffffffff8010ed6d>{error_exit+0}
       <ffffffff802b11e0>{input_register_device+16} <ffffffff8014075b>{__mod_timer+187}
       <ffffffff881bb2ca>{:saa7134:saa7134_input_init1+890}
       <ffffffff881b2f3b>{:saa7134:saa7134_initdev+1403} <ffffffff802288cd>{pci_device_probe+93}
       <ffffffff802c585f>{driver_probe_device+79} <ffffffff802c59ca>{__driver_attach+90}
       <ffffffff802c5970>{__driver_attach+0} <ffffffff802c4b8f>{bus_for_each_dev+79}
       <ffffffff802c560c>{driver_attach+28} <ffffffff802c50e8>{bus_add_driver+136}
       <ffffffff802c5d65>{driver_register+117} <ffffffff8014c630>{kthread_stop_sem+256}
       <ffffffff8022850e>{__pci_register_driver+206} <ffffffff881b1e06>{:saa7134:saa7134_init+70}
       <ffffffff80154d18>{sys_init_module+312} <ffffffff8010df30>{tracesys+209}
       
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffff8010f71b>{show_trace+619}
PGD 19c6e067 PUD 19c59067 PMD 0 
Oops: 0000 [3] PREEMPT SMP 
CPU 0 
Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev netconsole ipv6 lp autofs4 ipt_state ip_conntrack iptable_filter ip_tables nls_cp866 vfat fat usbhid video thermal processor fan button battery ac ohci_hcd ehci_hcd i2c_nforce2 shpchp snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii forcedeth floppy sata_nv libata
Pid: 2470, comm: modprobe Not tainted 2.6.15-rc1-mm2 #14
RIP: 0010:[<ffffffff8010f71b>] <ffffffff8010f71b>{show_trace+619}
RSP: 0018:ffff810019c4b728  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: ffff810019cbd640
RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001
RBP: ffff810019c4b768 R08: 0000000000000000 R09: ffff810019b38dc0
R10: 000000000000001f R11: 00000000000003d4 R12: ffff810019c4c000
R13: 0000000000000000 R14: ffffffff804ab0c0 R15: ffffffff80549100

       <ffffffff8010fd88>{__die+168} <ffffffff8037f03a>{do_page_fault+1882}
       <ffffffff80135cd8>{release_console_sem+424} <ffffffff801369ae>{vprintk+894}
       <ffffffff881b1e06>{:saa7134:saa7134_init+70} <ffffffff881b1e06>{:saa7134:saa7134_init+70}
       <ffffffff8010ed6d>{error_exit+0} <ffffffff8010f71b>{show_trace+619}

       <ffffffff802c560c>{driver_attach+28} <ffffffff802c50e8>{bus_add_driver+136}
       <ffffffff802c5d65>{driver_register+117} <ffffffff8014c630>{kthread_stop_sem+256}
       <ffffffff8022850e>{__pci_register_driver+206} <ffffffff881b1e06>{:saa7134:saa7134_init+70}
       <ffffffff80154d18>{sys_init_module+312} <ffffffff8010df30>{tracesys+209}
       
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
Stack: <ffffffff8010f717>{show_trace+615}<ffffffff801369ae>{vprintk+894}<ffffffff881b1e06>{:saa7134:saa7134_init+70}<ffffffff801369ae>{vprintk+894}<ffffffff881bb2ca>{:saa7134:saa7134_input_init1+890}<ffffffff802c585f>{driver_probe_device+79}<ffffffff8010df30>{tracesys+209}<ffffffff8010f82a>{show_stack+234}<ffffffff802288cd>{pci_device_probe+93}
       <ffffffff802c585f>{driver_probe_device+79} <ffffffff802c59ca>{__driver_attach+90}<ffffffff881b1e06>{:saa7134:saa7134_init+70}
--------------020209000508060402060906--
