Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbUEKLmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUEKLmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEKLmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:42:38 -0400
Received: from [80.72.36.106] ([80.72.36.106]:5781 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263154AbUEKLmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:42:25 -0400
Date: Tue, 11 May 2004 13:42:19 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 Oops disconnecting speedtouch usb modem
In-Reply-To: <1084274778.2262.7.camel@taz.graycell.biz>
Message-ID: <Pine.LNX.4.58.0405111337410.22862@alpha.polcom.net>
References: <1084274778.2262.7.camel@taz.graycell.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That seems to be the same problem as mine posted a while ago. It was 
reported against some 2.6.6-rc and was titled something like "3 usb 
regressions that should be fixed before 2.6.6". But unfortunatelly they 
were not. But the fixes probably exists in bk repositories and are waiting 
for inclusion into mainline (I strongly hope).

As a workaround you probably should try to apply usb-bk.patch from 
2.6.6-mm? kernel or use the bitkeeper to download and apply the right 
patch (I do not use bk so ask somebody else how to do it).


Grzegorz Kulewski



On Tue, 11 May 2004, Nuno Ferreira wrote:

> After upgrading from 2.6.5 to 2.6.6 I got this error while disconnecting
> my Speedtouch USB ADSL modem.
> 
> May 10 23:31:57 taz kernel: usb 1-1: USB disconnect, address 2
> May 10 23:31:57 taz kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> May 10 23:31:57 taz kernel:  printing eip:
> May 10 23:31:57 taz kernel: c02315d4
> May 10 23:31:57 taz kernel: *pde = 00000000
> May 10 23:31:57 taz kernel: Oops: 0000 [#1]
> May 10 23:31:57 taz kernel: CPU:    0
> May 10 23:31:57 taz kernel: EIP:    0060:[destroy_async+84/128]    Not tainted
> May 10 23:31:57 taz kernel: EFLAGS: 00010013   (2.6.6)
> May 10 23:31:57 taz kernel: EIP is at destroy_async+0x54/0x80
> May 10 23:31:57 taz kernel: eax: dcd656ac   ebx: 00000286   ecx: 00000000   edx: dcd65690
> May 10 23:31:57 taz kernel: esi: dcd656ac   edi: dcd65690   ebp: dd39e424   esp: ddd75ea0
> May 10 23:31:57 taz kernel: ds: 007b   es: 007b   ss: 0068
> May 10 23:31:57 taz kernel: Process khubd (pid: 5, threadinfo=ddd75000 task=ddfa6030)
> May 10 23:31:57 taz kernel: Stack: c022e368 ddd13294 c0330ba0 dd39e400 c02316c9 dcd65690 dcd656ac c022873a
> May 10 23:31:57 taz kernel:        ddd13294 ddd13294 dd15f648 ddd132a4 c0330bc0 c01f6a94 ddd132a4 ddd132cc
> May 10 23:31:57 taz kernel:        ddd132a4 dd39e4cc c01f6bc5 ddd132a4 ddd132fc ddd132a4 dd39e4cc c01f5b2d
> May 10 23:31:57 taz kernel: Call Trace:
> May 10 23:31:57 taz kernel:  [usb_disable_interface+56/80] usb_disable_interface+0x38/0x50
> May 10 23:31:57 taz kernel:  [driver_disconnect+57/64] driver_disconnect+0x39/0x40
> May 10 23:31:57 taz kernel:  [usb_unbind_interface+122/128] usb_unbind_interface+0x7a/0x80
> May 10 23:31:57 taz kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
> May 10 23:31:57 taz kernel:  [bus_remove_device+85/160] bus_remove_device+0x55/0xa0
> May 10 23:31:57 taz kernel:  [device_del+93/160] device_del+0x5d/0xa0
> May 10 23:31:57 taz kernel:  [device_unregister+19/48] device_unregister+0x13/0x30
> May 10 23:31:57 taz kernel:  [usb_disable_device+111/176] usb_disable_device+0x6f/0xb0
> May 10 23:31:57 taz kernel:  [usb_disconnect+150/240] usb_disconnect+0x96/0xf0
> May 10 23:31:57 taz kernel:  [hub_port_connect_change+625/640] hub_port_connect_change+0x271/0x280
> May 10 23:31:57 taz kernel:  [hub_port_status+67/176] hub_port_status+0x43/0xb0
> May 10 23:31:57 taz kernel:  [hub_events+672/768] hub_events+0x2a0/0x300
> May 10 23:31:57 taz kernel:  [hub_thread+45/240] hub_thread+0x2d/0xf0
> May 10 23:31:57 taz kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 10 23:31:57 taz kernel:  [hub_thread+0/240] hub_thread+0x0/0xf0
> May 10 23:31:57 taz kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
> May 10 23:31:57 taz kernel:
> May 10 23:31:57 taz kernel: Code: 8b 51 04 8b 01 89 50 04 89 02 89 49 04 89 09 53 9d 8b 41 20
> 
> I also had another problem before that one, modem_run complained that it
> couldn't read interrupts and exited. The connections stayed up, though.
> 
> May 10 23:22:31 taz modem_run[1364]: [monitoring report] ADSL link went
> up
> May 10 23:22:50 taz modem_run[874]: ADSL synchronization has been obtained
> May 10 23:22:50 taz modem_run[874]: ADSL line is up (512 kbit/s down | 128 kbit/s up)
> May 10 23:22:50 taz modem_run[1364]: Error reading interrupts
> May 10 23:22:50 taz modem_run[1364]: [monitoring report] ADSL link went down
> May 10 23:22:51 taz modem_run[1364]: Device disconnected, shutting down
> 
> Neither of these problems happen with the same setup running 2.6.5. I'll
> try to find more find more information about this second problem when I
> get home.
> 
> Anyone else having problems with the speedtouch usb on 2.6.6?
> -- 
> Nuno Ferreira
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
