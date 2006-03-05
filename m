Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWCEWyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWCEWyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCEWyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:54:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:43416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751277AbWCEWyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:54:05 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm2
Date: Sun, 5 Mar 2006 23:54:02 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060303045651.1f3b55ec.akpm@osdl.org>
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603052354.02828.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3. March 2006 13:56, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.
>6.16-rc5-mm2/

hi,
I don't know why, but it seems that the kernel doesn't use the correct BIOS 
time. I set it to the 23:30 and after booting I got ~01:00 (next day).

Here is another bug I got after mounting /mnt/extHDD2 a second time (it was 
already mounted).

Kernel BUG at fs/super.c:838
invalid opcode: 0000 [1] PREEMPT SMP
last sysfs file: /block/sdc/size
CPU 0
Modules linked in: radeon drm ppp_deflate zlib_deflate bsd_comp ppp_async 
ohci_hcd i2c_viapro ehci_hcd uhci_hcd r8169 snd_bt87x
Pid: 9213, comm: mount Not tainted 2.6.16-rc5-mm2 #5
RIP: 0010:[<ffffffff810cee79>] <ffffffff810cee79>{do_kern_mount+121}
RSP: 0018:ffff810036497ce8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003ea3f2d0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff81003c7752e0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff81130b00 R12: ffffffff813fda40
R13: ffff810036485000 R14: 0000000000000000 R15: 000000000000000f
FS:  00002aee57e24cf0(0000) GS:ffffffff814f2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000526000 CR3: 000000003787d000 CR4: 00000000000006e0
Process mount (pid: 9213, threadinfo ffff810036496000, task ffff81003b92b110)
Stack: 000000000000000e 0000000000000000 ffff8100379e4000 ffff810037975000
       ffff810036485000 ffffffff810d8689 ffff8100372b60c8 0000000000000000
       ffff8100372b60c8 ffffffff81025531
Call Trace: <ffffffff810d8689>{do_mount+1753} <ffffffff81025531>{__up_read+33}
       <ffffffff810749c5>{_spin_unlock_irqrestore+21} 
<ffffffff8100b027>{do_page_fault+1271}
       <ffffffff81013b1f>{poison_obj+63} 
<ffffffff81037114>{cache_free_debugcheck+660}
       <ffffffff8100a517>{get_page_from_freelist+759} 
<ffffffff81044c1b>{__get_free_pages+27}
       <ffffffff81057eab>{sys_mount+155} <ffffffff8106cbde>{system_call+126}

Code: 0f 0b 68 e7 33 38 81 c2 46 03 48 83 78 68 00 75 0a 0f 0b 68
RIP <ffffffff810cee79>{do_kern_mount+121} RSP <ffff810036497ce8>

--
dominik
