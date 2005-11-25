Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVKYHxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVKYHxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 02:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVKYHxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 02:53:11 -0500
Received: from ns.km0613.keymachine.de ([62.141.48.135]:25002 "EHLO
	km0613.keymachine.de") by vger.kernel.org with ESMTP
	id S1751414AbVKYHxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 02:53:10 -0500
Message-ID: <4386C2DA.6070002@hartl-it.de>
Date: Fri, 25 Nov 2005 08:52:58 +0100
From: Manuel Hartl <mhartl@hartl-it.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051016)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB module crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

last night (i think again) usb module(s) crashed. the running usb 
devices are a avm fritz usb dsl 2 and a usb mouse. i do not think this 
is avm related (cdslusb2 module), maybe an acpi/power management error?

please loook at the included stack trace.
can someone tell me (by looking at the trace), what could be the problem 
here?

hardware:
asus a8v deluxe (via k8t800 chipset) / socket 939 / amd64 3000+
cool and quiet was active in bios, but no module was loaded 
(powernow_k8), acpi/apic is enabled.



Nov 25 02:26:40 media kernel:  [<c029b1ec>] kref_get+0x3c/0x40
Nov 25 02:26:40 media kernel:  [<f89a2f9c>] usb_get_urb+0xc/0x10 [usbcore]
Nov 25 02:26:40 media kernel:  [<f89a212a>] hcd_submit_urb+0xda/0x1f0 
[usbcore]
Nov 25 02:26:40 media kernel:  [<f89a31b6>] usb_submit_urb+0x216/0x3e0 
[usbcore]
Nov 25 02:26:40 media kernel:  [<f89a31b6>] usb_submit_urb+0x216/0x3e0 
[usbcore]
Nov 25 02:26:40 media kernel:  [<fa59e2cb>] LeaveCritical+0xb/0x10 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa60943e>] usb_write+0xee/0xf0 [fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa609494>] usb_read+0x54/0xa0 [fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa6095c1>] os_usb_submit_tx+0x61/0x80 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa609d65>] OSHWTxBuffer+0x65/0x80 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa5e7e00>] Block_TxHandler+0x0/0x10 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa5e7e71>] Block_TxSend+0x21/0x70 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa5e84cc>] Block_RxHandler+0x42c/0x500 
[fcdslusb2]
Nov 25 02:26:40 media kernel:  [<fa609110>] rx_handler+0xc0/0xd0 [fcdslusb2]
Nov 25 02:26:40 media kernel:  [<c011b72a>] tasklet_action+0x3a/0x60
Nov 25 02:26:40 media kernel:  [<c011b492>] __do_softirq+0x42/0x90
Nov 25 02:26:40 media kernel:  [<c011b506>] do_softirq+0x26/0x30
Nov 25 02:26:40 media kernel:  [<c0104a2e>] do_IRQ+0x1e/0x30
Nov 25 02:26:40 media kernel:  [<c0103516>] common_interrupt+0x1a/0x20
Nov 25 02:26:40 media kernel:  [<c02e1bf3>] acpi_processor_idle+0x0/0x27f
Nov 25 02:26:40 media kernel:  [<c02e1cf4>] acpi_processor_idle+0x101/0x27f
Nov 25 02:26:40 media kernel:  [<c0100ca2>] cpu_idle+0x42/0x60
Nov 25 02:26:40 media kernel:  [<c04a281f>] start_kernel+0x16f/0x1b0
Nov 25 02:26:40 media kernel:  [<c04a2380>] unknown_bootoption+0x0/0x1d0


greetings,
	manuel.
