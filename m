Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423380AbWJZMaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423380AbWJZMaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423424AbWJZMaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:30:13 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:29064 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1423380AbWJZMaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:30:11 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: 2.6.18 kernel panic on boot with VIA power-off quirk.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45401DFE.4070605@candelatech.com>
References: <45401DFE.4070605@candelatech.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 13:30:00 +0100
Message-Id: <1161865800.3327.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 19:31 -0700, Ben Greear wrote:
> Is this a known problem?

I think yes, You have a fix for that 
http://lkml.org/lkml/2006/10/17/62

> 
> Kernel is 2.6.18, compiled for VIA C3 (FC5 distribution)
> Hardware is FWA7304 from i-Base.
> 
> I have noticed on 2.6.17 that 'init 0' on this thing causes it
> over-heat badly (when you would expect it to shut off), and I'm hopeful
> that the quirk in this stack trace is trying to fix that....
> 
> More info available, including remote console access if it helps.
> 
> Thanks,
> Ben
> 
> 
> ....
> 0000:00:10.4 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
> PCI: Bypassing VIA 8237 APIC De-Assert Message
> BUG: unable to handle kernel NULL pointer dereference at virtual address 000000c printing eip:
> c022a0b3
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c022a0b3>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.18c3 #7)
> EIP is at acpi_hw_low_level_read+0xa/0x70
> eax: 00000010   ebx: 00000001   ecx: 00000094   edx: c1463f5c
> esi: c1463f78   edi: 00000000   ebp: c1463f4c   esp: c1463f40
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, ti=c1462000 task=c1461530 task.ti=c1462000)
> Stack: 00000001 c1463f78 00000000 c1463f6c c022a175 00000088 00000000 00000000
>         c0389f48 deeb2000 c038a070 c1463f7c c0207e55 01eb2800 c0389f18 c1463f90
>         c0207933 deeb2000 00000000 00000000 c1463f9c c0206b24 c04562f4 c1463fe4
> Call Trace:
>   [<c01048c1>] show_stack_log_lvl+0xb1/0xe0
>   [<c0104b1e>] show_registers+0x1ce/0x260
>   [<c0104ccd>] die+0x11d/0x2c0
>   [<c0116ec2>] do_page_fault+0x272/0x57c
>   [<c0104319>] error_code+0x39/0x40
>   [<c022a175>] acpi_hw_register_read+0x5c/0x16c
>   [<c0207e55>] quirk_via_abnormal_poweroff+0x15/0x40
>   [<c0207933>] pci_fixup_device+0x53/0xa0
>   [<c0206b24>] pci_init+0x14/0x30
>   [<c0100320>] init+0x80/0x290
>   [<c0101005>] kernel_thread_helper+0x5/0x10
> Code: c0 68 f3 00 00 00 ff 35 ac 82 34 c0 e8 20 83 00 00 31 c0 83 c4 10 eb 07 8
> EIP: [<c022a0b3>] acpi_hw_low_level_read+0xa/0x70 SS:ESP 0068:c1463f40
>   <0>Kernel panic - not syncing: Attempted to kill init!
> 
> 
> 

