Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVLAVl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVLAVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVLAVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:41:29 -0500
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:47279
	"EHLO mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org
	with ESMTP id S932482AbVLAVl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:41:29 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <438F6DFF.2040603@eyal.emu.id.au>
Date: Fri, 02 Dec 2005 08:41:19 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>  <1133445903.16820.1.camel@localhost>  <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org> <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com> <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 1 Dec 2005, Felipe Alfaro Solana wrote:
> 
>>Exactly that's what I'm seeing with the propietary nVidia driver:
> 
> Does yours work despite the messages?
> 
> Also, can both of you apply this debugging patch that just adds a bit more 
> information about exactly what kind of mapping these drivers are trying to 
> do..

I am also getting the NVIDIA messages, here they are from a patched kernel.
my driver continues to work OK, however I am not running any gl apps.

# uname -a
Linux e7 2.6.15-rc4 #2 PREEMPT Fri Dec 2 08:09:23 EST 2005 i686 GNU/Linux

# dmesg
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 17
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:44:39 PST 2005
ACPI: PCI interrupt for device 0000:01:00.0 disabled
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 17
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:44:39 PST 2005
NVRM: not using NVAGP, an AGPGART backend is loaded!
NVRM: not using NVAGP, an AGPGART backend is loaded!
XFree86 does an incomplete pfn remappingvma: a761f000-a762f000 remap: a761f000-a7620000 pfn: 32186, prot: 27 [<c0145158>] incomplete_pfn_remap+0x112/0x11a
 [<f95ec336>] nv_kern_mmap+0x4ae/0x4e2 [nvidia]
 [<c0147fbd>] do_mmap_pgoff+0x398/0x7bb
 [<c0168446>] do_ioctl+0x76/0x96
 [<c010874f>] sys_mmap2+0x78/0xa7
 [<c0102be1>] syscall_call+0x7/0xb
XFree86 does an incomplete pfn remappingvma: b7f51000-b7f59000 remap: b7f51000-b7f52000 pfn: 32b60, prot: 27 [<c0145158>] incomplete_pfn_remap+0x112/0x11a
 [<f95ec336>] nv_kern_mmap+0x4ae/0x4e2 [nvidia]
 [<c0147fbd>] do_mmap_pgoff+0x398/0x7bb
 [<c0168446>] do_ioctl+0x76/0x96
 [<c010874f>] sys_mmap2+0x78/0xa7
 [<c0102be1>] syscall_call+0x7/0xb
NVRM: Xid: 17, Head=0 X=1920 Y=1200 Refresh=59
XFree86 does an incomplete pfn remappingvma: a754e000-a755e000 remap: a754e000-a754f000 pfn: 3307e, prot: 27 [<c0145158>] incomplete_pfn_remap+0x112/0x11a
 [<f95ec336>] nv_kern_mmap+0x4ae/0x4e2 [nvidia]
 [<c0147fbd>] do_mmap_pgoff+0x398/0x7bb
 [<c0168446>] do_ioctl+0x76/0x96
 [<c010874f>] sys_mmap2+0x78/0xa7
 [<c0102be1>] syscall_call+0x7/0xb

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
