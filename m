Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbULDVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbULDVmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbULDVmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:42:20 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:12490 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261170AbULDVmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:42:16 -0500
Date: Sat, 4 Dec 2004 22:42:11 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Ari Pollak <aripollak@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc3
In-Reply-To: <877jnxago0.fsf@sycorax.lbl.gov>
Message-ID: <Pine.LNX.4.58.0412042241070.13328@tux.rsn.bth.se>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
 <pan.2004.12.04.09.06.09.707940@nn7.de> <87oeha6lj1.fsf@sycorax.lbl.gov>
 <cosrt1$j67$1@sea.gmane.org> <87eki66jx8.fsf@sycorax.lbl.gov>
 <1102195032.1560.58.camel@tux.rsn.bth.se> <877jnxago0.fsf@sycorax.lbl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2004, Alex Romosan wrote:

> thank you. the laptop wakes up now but i get the following when it
> resumes (this is the output from dmesg):
>
> scheduling while atomic: sleepbtn.sh/0x00000001/3201
>  [<c0103557>] dump_stack+0x17/0x20
>  [<c030e4e2>] schedule+0x522/0x530
>  [<c030e97b>] schedule_timeout+0x5b/0xb0
>  [<c011fbaf>] msleep+0x2f/0x40
>  [<e1079387>] ehci_hub_resume+0xd7/0x1c0 [ehci_hcd]
>  [<e10cce6a>] hcd_hub_resume+0x1a/0x20 [usbcore]
>  [<e10c9ff2>] usb_resume_device+0xa2/0xc0 [usbcore]
>  [<c022c50a>] resume_device+0x1a/0x20
>  [<c022c5b7>] dpm_resume+0xa7/0xb0
>  [<c022c5d4>] device_resume+0x14/0x30
>  [<c012f27b>] suspend_finish+0xb/0x30
>  [<c012f2ed>] enter_state+0x4d/0x70
>  [<c01f6bd6>] acpi_suspend+0x3d/0x4b
>  [<c01f6cbb>] acpi_system_write_sleep+0x64/0x76
>  [<c014e042>] vfs_write+0xa2/0x100
>  [<c014e151>] sys_write+0x41/0x70
>  [<c0102ffb>] syscall_call+0x7/0xb

That's an usb2.0 bug, the ehci driver sleeps when it can't sleep.

/Martin
