Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUAZE1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUAZE1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:27:22 -0500
Received: from [211.167.76.68] ([211.167.76.68]:55007 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265477AbUAZE1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:27:17 -0500
Date: Mon, 26 Jan 2004 12:16:31 +0800
From: Hugang <hugang@soulinfo.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] Linux-2.6.1 suspend/resume
Message-Id: <20040126121632.70097914@localhost>
In-Reply-To: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
References: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004 02:25:40 +0100
"Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:

>  [<c02fc028>] usb_hcd_pci_resume+0x38/0x90
>  [<c023ac54>] pci_device_resume+0x24/0x30
>  [<c028a3e7>] resume_device+0x27/0x30
>  [<c028a424>] dpm_resume+0x34/0x60
>  [<c028a469>] device_resume+0x19/0x30
>  [<c01337e9>] drivers_resume+0x39/0x40
>  [<c0133aba>] do_magic_resume_2+0x5a/0xe0
>  [<c0133ad2>] do_magic_resume_2+0x72/0xe0
>  [<c03576af>] do_magic+0x11f/0x130
>  [<c0133cfb>] do_software_suspend+0x6b/0x90
>  [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
>  [<c0253833>] acpi_system_write_sleep+0x0/0xcd
>  [<c0150398>] vfs_write+0xd8/0x140
>  [<c01504b2>] sys_write+0x42/0x70
>  [<c0109387>] syscall_call+0x7/0xb
> 
> bad: scheduling while atomic!
> Call Trace:
>  [<c011a7d3>] schedule+0x563/0x570
>  [<c0356e7d>] pci_read+0x3d/0x50
>  [<c0125ff3>] schedule_timeout+0x63/0xc0
>  [<c0125f80>] process_timeout+0x0/0x10
>  [<c02387b3>] pci_set_power_state+0xd3/0x160
>  [<c02a3708>] e100_resume+0x28/0x70
>  [<c023ac54>] pci_device_resume+0x24/0x30

I think if you can let usb, e100 as module, before suspend rmmod it, 
resume will be ok.

pls try.

thanks.
-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
