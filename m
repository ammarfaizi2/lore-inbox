Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTK2SZR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 13:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTK2SZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 13:25:17 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:47336 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263866AbTK2SZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 13:25:04 -0500
Message-ID: <3FC8E479.7010708@blueyonder.co.uk>
Date: Sat, 29 Nov 2003 18:24:57 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031031
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test HD wakeup problems
References: <isZ24dsPk0000347e@smtp-out5.blueyonder.co.uk>
In-Reply-To: <isZ24dsPk0000347e@smtp-out5.blueyonder.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2003 18:25:04.0241 (UTC) FILETIME=[1BB88610:01C3B6A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I didn't have the problem with 2.6.0-test10-mm1, but I've had it with
> all the Linus 2.6.0-test kernels. When left unattended for some hours,
> the HD, monitor (some times) and USB fail to wake up. Athlon
> XP2200+/512M/IDE HD/Geforce FX5200 128M using the modded NVIDIA driver.
> With 2.6.0-test10-mm1 the HD spins up readily on hitting any key. ACPI
> is set to off and I'm not using SWSUSP.
> I don't see anywhere in the stuff below where it tries to wake up the HD
> at 12:12 when I hit a key.
>
> Nov 29 04:06:18 barrabas kernel: hdb: start_power_step(step: 0)
> Nov 29 04:06:18 barrabas kernel: hdb: completing PM request, suspend
> Nov 29 04:06:18 barrabas kernel: hda: start_power_step(step: 0)
> Nov 29 04:06:18 barrabas kernel: hda: start_power_step(step: 1)
> Nov 29 04:06:18 barrabas kernel: hda: complete_power_step(step: 1, stat:
> 50, err: 0)
> Nov 29 04:06:18 barrabas kernel: hda: completing PM request, suspend
> Nov 29 04:06:18 barrabas kernel: uhci_hcd 0000:00:11.3: suspend D0 --> D3
> Nov 29 04:06:18 barrabas kernel: drivers/usb/host/uhci-hcd.c: a800:
> suspend_hc
> Nov 29 04:06:18 barrabas kernel: uhci_hcd 0000:00:11.2: suspend D0 --> D3
> Nov 29 04:06:18 barrabas kernel: drivers/usb/host/uhci-hcd.c: b000:
> suspend_hc
> Nov 29 04:06:18 barrabas kernel: ehci_hcd 0000:00:09.2: suspend D0 --> D3
> Nov 29 04:06:18 barrabas kernel: ehci_hcd 0000:00:09.2: suspend to 3
> Nov 29 04:06:18 barrabas kernel: uhci_hcd 0000:00:09.1: suspend D0 --> D3
> Nov 29 04:06:18 barrabas kernel: drivers/usb/host/uhci-hcd.c: d400:
> suspend_hc
> Nov 29 04:06:18 barrabas kernel: uhci_hcd 0000:00:09.0: suspend D0 --> D3
> Nov 29 04:06:18 barrabas kernel: drivers/usb/host/uhci-hcd.c: d800:
> suspend_hc
> Nov 29 04:06:27 barrabas kernel: uhci_hcd 0000:00:09.0: resume from 
> state D3
> Nov 29 04:06:27 barrabas kernel: uhci_hcd 0000:00:09.1: resume from 
> state D3
> Nov 29 04:06:27 barrabas kernel: ehci_hcd 0000:00:09.2: resume from 
> state D3
> Nov 29 04:06:27 barrabas kernel: ehci_hcd 0000:00:09.2: resume
> Nov 29 04:06:27 barrabas kernel: eth0: link up, 100Mbps, full-duplex,
> lpa 0x45E1
> Nov 29 04:06:27 barrabas kernel: uhci_hcd 0000:00:11.2: resume from 
> state D3
> Nov 29 04:06:27 barrabas kernel: uhci_hcd 0000:00:11.3: resume from 
> state D3
> Nov 29 04:06:27 barrabas kernel: hda: Wakeup request inited, waiting for
> !BSY...
> Nov 29 04:06:27 barrabas kernel: hda: start_power_step(step: 1000)
> Nov 29 04:06:27 barrabas kernel: blk: queue df2a7df8, I/O limit 4095Mb
> (mask 0xffffffff)
> Nov 29 04:06:27 barrabas kernel: hda: completing PM request, resume
> Nov 29 04:06:27 barrabas kernel: hdb: Wakeup request inited, waiting for
> !BSY...
> Nov 29 04:06:27 barrabas kernel: hdb: start_power_step(step: 1000)
> Nov 29 04:06:27 barrabas kernel: hdb: completing PM request, resume
> Nov 29 04:06:27 barrabas kernel: drivers/usb/host/uhci-hcd.c: d400:
> wakeup_hc
> Nov 29 04:06:27 barrabas kernel: drivers/usb/host/uhci-hcd.c: a800:
> wakeup_hc
> Nov 29 04:06:27 barrabas kernel: drivers/usb/host/uhci-hcd.c: d800:
> wakeup_hc
> Nov 29 04:06:27 barrabas kernel: drivers/usb/host/uhci-hcd.c: b000:
> wakeup_hc
> Nov 29 04:06:27 barrabas kernel: hub 4-2:1.0: transfer --> -84
> Nov 29 04:06:29 barrabas last message repeated 4 times
> Nov 29 04:06:29 barrabas kernel: drivers/usb/host/uhci-hcd.c: d400:
> suspend_hc
> Nov 29 04:06:29 barrabas kernel: drivers/usb/host/uhci-hcd.c: a800:
> suspend_hc
> Nov 29 04:06:29 barrabas kernel: drivers/usb/host/uhci-hcd.c: d800:
> suspend_hc
> Nov 29 04:06:29 barrabas kernel: hub 4-2:1.0: transfer --> -84
> Nov 29 04:06:31 barrabas last message repeated 4 times
> Nov 29 04:06:31 barrabas kernel: hub 4-2:1.0: resetting for error -84
> Nov 29 04:06:31 barrabas kernel: usb 4-2.1: USB disconnect, address 3
> Nov 29 04:06:31 barrabas kernel: usb 4-2.1: usb_disable_device nuking
> all URBs
> Nov 29 04:06:31 barrabas kernel: usb 4-2.1: unregistering interface
> 4-2.1:1.0
> Nov 29 04:06:31 barrabas kernel: usb 4-2.1: hcd_unlink_urb d53cbf78 
> fail -22
> Nov 29 04:06:31 barrabas kernel: usb 4-2.1: hcd_unlink_urb d588df78 
> fail -22
> Nov 29 04:06:31 barrabas kernel: hub 4-2:1.0: transfer --> -84
> Nov 29 04:06:32 barrabas last message repeated 3 times
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.1: unregistering device
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.2: USB disconnect, address 4
> Nov 29 04:06:33 barrabas kernel: usb 4-2.2: usb_disable_device nuking
> all URBs
> Nov 29 04:06:33 barrabas kernel: usb 4-2.2: unregistering interface
> 4-2.2:1.0
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.2: unregistering device
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: USB disconnect, address 5
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: usb_disable_device nuking
> all URBs
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: unregistering interface
> 4-2.4:1.0
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: hcd_unlink_urb d527ef78 
> fail -22
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: hcd_unlink_urb d54eaf78 
> fail -22
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.4: unregistering device
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/usb.c: usb_hotplug
> Nov 29 04:06:33 barrabas kernel: usb 4-2.5: USB disconnect, address 6
> Nov 29 04:06:33 barrabas kernel: usb 4-2.5: usb_disable_device nuking
> all URBs
> Nov 29 04:06:33 barrabas kernel: usb 4-2.5: unregistering interface
> 4-2.5:1.0
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/file.c: removing 0 minor
> Nov 29 04:06:33 barrabas kernel: drivers/usb/core/file.c:
> release_usb_class_dev - lp0
> <stuff deleted>
> Nov 29 12:12:01 barrabas syslogd 1.4.1: restart.
> Nov 29 12:12:03 barrabas /sbin/hotplug[789]: no runnable
> /etc/hotplug/usb_host.agent is installed
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: loaded HCD: ehci-hcd
> Nov 29 12:12:03 barrabas /sbin/hotplug[830]: no runnable
> /etc/hotplug/usb_host.agent is installed
> Nov 29 12:12:03 barrabas /sbin/hotplug[869]: no runnable
> /etc/hotplug/usb_host.agent is installed
> Nov 29 12:12:03 barrabas /sbin/hotplug[908]: no runnable
> /etc/hotplug/usb_host.agent is installed
> Nov 29 12:12:03 barrabas /sbin/hotplug[947]: no runnable
> /etc/hotplug/usb_host.agent is installed
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: loaded HCD: uhci-hcd
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: loaded HCD: ehci-hcd
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: FATAL: Module
> mousedev not found.
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: FATAL: Module keybdev
> not found.
> Nov 29 12:12:03 barrabas /etc/hotplug/usb.rc[778]: FATAL: Module printer
> not found.
> <HARDWARE RESET done>
> Regards
> Sid.
>
> --
> Sid Boyce .... Linux Only Shop.
>
>
>


-- 
Sid Boyce .... Linux Only Shop.

