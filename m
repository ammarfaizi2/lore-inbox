Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVIWXGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVIWXGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVIWXGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:06:40 -0400
Received: from xenotime.net ([66.160.160.81]:63127 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932097AbVIWXGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:06:39 -0400
Date: Fri, 23 Sep 2005 16:06:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6 panic
Message-Id: <20050923160636.07135828.rdunlap@xenotime.net>
In-Reply-To: <20050923121538.88627.qmail@web8509.mail.in.yahoo.com>
References: <20050923121538.88627.qmail@web8509.mail.in.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005 13:15:38 +0100 (BST) manomugdha biswas wrote:

> Hi,
> I have a kernel module. I can install (insmod) my
> module successfully. I start my module by ioctl() from
> user application and also use ioctl() to stop my
> module from user application. But sometimes after
> removing (stoping) my module kernel panic happens.
> Following is the dump:
> 
> Sep 23 02:40:09 localhost kernel: Unable to handle
> kernel NULL pointer dereference at virtual address
> 00000025
> Sep 23 02:40:09 localhost kernel:  printing eip:
> Sep 23 02:40:09 localhost kernel: c0163516
> Sep 23 02:40:09 localhost kernel: *pde = 00000000
> Sep 23 02:40:09 localhost kernel: Oops: 0000 [#1]
> Sep 23 02:40:09 localhost kernel: Modules linked in:
> vnicclient(U) i915 parport_pc lp parport autofs4
> i2c_dev i2c_core sunrpc dm_mod button battery ac md5
> ipv6 uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec
> snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
> snd_page_alloc snd_mpu401_uart snd_rawmidi
> snd_seq_device snd soundcore e100 mii floppy ext3 jbd
> Sep 23 02:40:09 localhost kernel: CPU:    0
> Sep 23 02:40:09 localhost kernel: EIP:   
> 0060:[<c0163516>]    Not tainted VLI
> Sep 23 02:40:09 localhost kernel: EFLAGS: 00010202  
> (2.6.9-11.EL)
> Sep 23 02:40:09 localhost kernel: EIP is at
> sys_read+0x1d/0x62
> Sep 23 02:40:09 localhost kernel: eax: 00000001   ebx:
> 00000001   ecx: f2067380   edx: 00000001 Sep 23
> 02:40:09 localhost kernel: esi: fffffff7   edi:
> 00000000   ebp: f29e5000   esp: f29e5fac
> Sep 23 02:40:09 localhost kernel: ds: 007b   es: 007b 
>  ss: 0068
> Sep 23 02:40:09 localhost kernel: Process bash (pid:
> 10171, threadinfo=f29e5000 task=f21111a0)
> Sep 23 02:40:09 localhost kernel: Stack: 00000000
> 00000000 00000000 00000000 bffdcbaf c03036f3 00000000
> bffdcbaf
> Sep 23 02:40:09 localhost kernel:        00000001
> bffdcbaf 00000000 bffdcbb8 00000003 0000007b 0000007b
> 00000003
> Sep 23 02:40:09 localhost kernel:        006e77a2
> 00000073 00000246 bffdcb94 0000007b
> Sep 23 02:40:09 localhost kernel: Call Trace:
> Sep 23 02:40:09 localhost kernel:  [<c03036f3>]
> syscall_call+0x7/0xb
> Sep 23 02:40:09 localhost kernel: Code: 00 e8 ed fc 01
> 00 89 d8 5d 5b 5e 5f 5d c3 56 be f7 ff ff ff 53 83 ec
> 0c 8b 44 24 18 8d 54 24 08 e8 8c 0d 00 00 85 c0 89 c3
> 74 3d <8b> 40 24 8b 53 28 89 04 24 89 e0 89 54 24 04
> 50 8b 54 24 20 89 Sep 23 02:40:09 localhost kernel: 
> <0>Fatal exception: panic in 5 seconds
> 
> vnicclient is my module. 
> Could you please tell me what is meant by  "Not
> tainted VLI" ?

It's normal.  "Not tainted" means that there are no
proprietary modules loaded, only GPL modules.
VLI means Variable Length Instructions.  It's just a flag
to software that reads these reports that the "Code" bytes
are not fixed-length instructions.

> This is happening after comming out my module. 
> Could you please give some light on this issue?

Sure, just tell us where to find/get your GPL source code
and someone will probably take a look at it.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
