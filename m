Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUFRUoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUFRUoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUFRUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:41:38 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:58414 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S261763AbUFRUZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:25:00 -0400
Message-ID: <40D34F90.1060907@travellingkiwi.com>
Date: Fri, 18 Jun 2004 21:24:48 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi S3 never wakes up
References: <20040618154025.15708106@damned.travellingkiwi.com>
In-Reply-To: <20040618154025.15708106@damned.travellingkiwi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamie wrote:

>Hi.
>
>I have an IBM r50p that I'd really really really like to have ACPI usable on. The battery works fine, the temp shows fine, the processor speeds up & slows down. All great, until I try to suspend (to RAM or to disk).
>
>Firstly to RAM.
>
>I hit Fn=F4 (Or cat 3 > /proc/acpi/sleep). System says I'm suspending. & goes to sleep. Fine so far. Unlike APM, the Fn key doesn't wake it up any more, so I press the power button. It LOOKS like it's starting up again, fan starts, CD spins, but no display... Doesn't matter whether I'm running X, or from the console. After wakup, nothing seems to work. Fn-F4 will send me to sleep again though... CTRL-ALT-Fx, does nothing...
>
>Now should I get the lock icon again (I lock my machine with a poweron pass BIOS + Disk, NOT supervisor) like on APM? Or not? SHould I come up directly back where I was before? Or something else? Anyone know? I've seen reference to people having success, but I've had nothing but bad luck with ACPi & suspending so far.
>
>Anyone got any ideas? I really really really hate having to boot my laptop 3x a day...
>
>Oh. I've tried all kinds of kernels. Current is 2.6.6 and 2.6.7, both do exactly the same thing.
>
>  
>

Hi all.

Some logs from kern.log... It's definately coming back from suspend... 
Just no video... It even suspends a second time... And wakes... No video 
still..

Jun 18 15:59:05 ballbreaker kernel: uhci_hcd 0000:00:1d.0: remove, state 1
Jun 18 15:59:05 ballbreaker kernel: usb usb2: USB disconnect, address 1
Jun 18 15:59:05 ballbreaker kernel: uhci_hcd 0000:00:1d.0: USB bus 2 
deregistered
Jun 18 15:59:05 ballbreaker kernel: uhci_hcd 0000:00:1d.1: remove, state 1
Jun 18 15:59:05 ballbreaker kernel: usb usb3: USB disconnect, address 1
Jun 18 15:59:05 ballbreaker kernel: uhci_hcd 0000:00:1d.1: USB bus 3 
deregistered
Jun 18 15:59:05 ballbreaker kernel: uhci_hcd 0000:00:1d.2: remove, state 1
Jun 18 15:59:05 ballbreaker kernel: usb usb4: USB disconnect, address 1
Jun 18 15:59:06 ballbreaker kernel: uhci_hcd 0000:00:1d.2: USB bus 4 
deregistered
Jun 18 15:59:09 ballbreaker kernel: ehci_hcd 0000:00:1d.7: remove, state 1
Jun 18 15:59:09 ballbreaker kernel: usb usb1: USB disconnect, address 1
Jun 18 15:59:09 ballbreaker kernel: ehci_hcd 0000:00:1d.7: USB bus 1 
deregistered
Jun 18 15:59:33 ballbreaker kernel: PM: Preparing system for suspend
Jun 18 15:59:33 ballbreaker kernel: Stopping tasks: 
================================================|
Jun 18 15:59:33 ballbreaker kernel: PM: Entering state.
Jun 18 15:59:33 ballbreaker kernel:  hwsleep-0304 [767] 
acpi_enter_sleep_state: Entering sleep state [S3]
Jun 18 15:59:33 ballbreaker kernel: Back to C!
Jun 18 15:59:33 ballbreaker kernel: PM: Finishing up.
Jun 18 15:59:33 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.0 to 64
Jun 18 15:59:33 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.1 to 64
Jun 18 15:59:33 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.2 to 64
Jun 18 15:59:33 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.7 to 64
Jun 18 15:59:33 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1f.5 to 64
Jun 18 15:59:33 ballbreaker kernel: Restarting tasks... done
Jun 18 16:00:07 ballbreaker kernel: PM: Preparing system for suspend
Jun 18 16:00:29 ballbreaker kernel: Stopping tasks: 
=================================================|
Jun 18 16:00:29 ballbreaker kernel: PM: Entering state.
Jun 18 16:00:29 ballbreaker kernel:  hwsleep-0304 [921] 
acpi_enter_sleep_state: Entering sleep state [S3]
Jun 18 16:00:29 ballbreaker kernel: Back to C!
Jun 18 16:00:29 ballbreaker kernel: PM: Finishing up.
Jun 18 16:00:29 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.0 to 64
Jun 18 16:00:29 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.1 to 64
Jun 18 16:00:29 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.2 to 64
Jun 18 16:00:29 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1d.7 to 64
Jun 18 16:00:29 ballbreaker kernel: PCI: Setting latency timer of device 
0000:00:1f.5 to 64
Jun 18 16:00:29 ballbreaker kernel: Restarting tasks... done

(Then it's power switch time).

Can anyone give me a hint as to where the kernel should be 
re-initialising the video?

>TIA
>
>Hamish., 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

