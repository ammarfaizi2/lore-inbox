Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274992AbTHFKDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274993AbTHFKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:03:52 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:60427 "EHLO
	mail3.cybertrails.com") by vger.kernel.org with ESMTP
	id S274992AbTHFKDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:03:48 -0400
Date: Wed, 6 Aug 2003 03:03:37 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (lost
 USB mouse)
Message-Id: <20030806030337.5a9dd2c6.dickson@permanentmail.com>
In-Reply-To: <20030806021621.2da5a850.dickson@permanentmail.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:

> But all is not perfect.  I'll attach the problems I had as replies (so
> each has it's own message thread).

After spending the day visiting relatives, I came back to the notebook and
put something down nearby.  I then went away for a moment and upon
returning discovered the screen unblanked but the mouse not functioning. 
Flipping workspaces relieved my fear that 2.6.0-test2 had crashed, but
still no mouse.

So I decided to unplug and replug in the mouse (its USB after all).

This allowed the mouse to function again.

This is what was recorded in the message log:


Aug  3 22:55:21 violet kernel: hub 1-0:0: port 1 disabled by hub (EMI?), re-enabling...<6>usb 1-1: USB disconnect, address 2
Aug  3 22:55:21 violet kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
Aug  3 22:55:21 violet kernel: Call Trace:
Aug  3 22:55:21 violet kernel:  [<c011b5b1>] __might_sleep+0x61/0x80
Aug  3 22:55:21 violet kernel:  [<c029f22c>] hcd_endpoint_disable+0xcc/0x1b0
Aug  3 22:55:21 violet kernel:  [<c029f160>] hcd_endpoint_disable+0x0/0x1b0
Aug  3 22:55:21 violet kernel:  [<c0299bea>] nuke_urbs+0x4a/0x60
Aug  3 22:55:21 violet kernel:  [<c029a8c2>] usb_disconnect+0xa2/0x140
Aug  3 22:55:21 violet kernel:  [<c029d40f>] hub_port_connect_change+0x33f/0x350
Aug  3 22:55:21 violet kernel:  [<c029d74c>] hub_events+0x32c/0x3b0
Aug  3 22:55:21 violet kernel:  [<c029d805>] hub_thread+0x35/0xf0
Aug  3 22:55:21 violet kernel:  [<c011a1d0>] default_wake_function+0x0/0x30
Aug  3 22:55:21 violet kernel:  [<c029d7d0>] hub_thread+0x0/0xf0
Aug  3 22:55:22 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  3 22:55:22 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  3 22:55:22 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  3 22:55:22 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  3 22:55:22 violet kernel:  [<c01091a9>] kernel_thread_helper+0x5/0xc
Aug  3 22:55:24 violet modprobe: FATAL: Module ide_probe_mod not found. 
Aug  3 22:55:24 violet kernel: 
Aug  3 22:55:25 violet kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Aug  3 22:55:25 violet kernel: hub 1-0:0: new USB device on port 1, assigned address 3
Aug  3 22:55:25 violet kernel: input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:07.2-1
Aug  3 22:55:25 violet modprobe: FATAL: Module ide_probe not found. 
Aug  3 22:55:25 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug  3 22:55:25 violet modprobe: FATAL: Module ohci1394 already in kernel. 
Aug  3 22:55:25 violet /etc/hotplug/usb.agent: Setup hid for USB product 1241/1111/100
Aug  3 22:55:26 violet modprobe: FATAL: Module hid not found. 
Aug  3 22:55:26 violet modprobe: FATAL: Error running install command for hid 
Aug  3 22:55:26 violet /etc/hotplug/usb.agent: ... can't load module hid
Aug  3 22:55:26 violet /etc/hotplug/usb.agent: missing kernel or user mode driver hid 
Aug  3 22:55:26 violet kernel: drivers/usb/core/message.c: usb_control/bulk_msg: timeout
Aug  3 22:55:27 violet devlabel: devlabel service started/restarted
Aug  3 22:55:28 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  3 22:55:28 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  3 22:55:28 violet kernel: hde: Write Cache FAILED Flushing!
Aug  3 22:55:28 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  3 22:55:28 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  3 22:55:28 violet kernel: hde: Write Cache FAILED Flushing!
Aug  3 22:55:28 violet devlabel: devlabel service started/restarted


I'm guessing this is where the USB Mouse was disconnected and reconnected
(there where no lines between these two sections, nor for several hours
before and after):


Aug  3 22:56:40 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  3 22:56:40 violet kernel: usb 1-1: USB disconnect, address 3
Aug  3 22:56:40 violet kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
Aug  3 22:56:40 violet kernel: Call Trace:
Aug  3 22:56:40 violet kernel:  [<c011b5b1>] __might_sleep+0x61/0x80
Aug  3 22:56:40 violet kernel:  [<c029f22c>] hcd_endpoint_disable+0xcc/0x1b0
Aug  3 22:56:40 violet kernel:  [<c029f160>] hcd_endpoint_disable+0x0/0x1b0
Aug  3 22:56:40 violet kernel:  [<c0299bea>] nuke_urbs+0x4a/0x60
Aug  3 22:56:40 violet kernel:  [<c029a8c2>] usb_disconnect+0xa2/0x140
Aug  3 22:56:40 violet kernel:  [<c029d40f>] hub_port_connect_change+0x33f/0x350
Aug  3 22:56:40 violet kernel:  [<c029cc7b>] hub_port_status+0x3b/0xb0
Aug  3 22:56:40 violet kernel:  [<c029d769>] hub_events+0x349/0x3b0
Aug  3 22:56:40 violet kernel:  [<c029d805>] hub_thread+0x35/0xf0
Aug  3 22:56:40 violet kernel:  [<c011a1d0>] default_wake_function+0x0/0x30
Aug  3 22:56:40 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  3 22:56:41 violet modprobe: FATAL: Module ide_probe_mod not found. 
Aug  3 22:56:41 violet kernel:  [<c029d7d0>] hub_thread+0x0/0xf0
Aug  3 22:56:41 violet kernel:  [<c01091a9>] kernel_thread_helper+0x5/0xc
Aug  3 22:56:41 violet modprobe: FATAL: Module ide_probe not found. 
Aug  3 22:56:41 violet kernel: 
Aug  3 22:56:41 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug  3 22:56:41 violet modprobe: FATAL: Module ohci1394 already in kernel. 
Aug  3 22:56:41 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  3 22:56:41 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  3 22:56:41 violet kernel: hde: Write Cache FAILED Flushing!
Aug  3 22:56:42 violet devlabel: devlabel service started/restarted
Aug  3 22:56:43 violet kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Aug  3 22:56:43 violet kernel: hub 1-0:0: new USB device on port 1, assigned address 4
Aug  3 22:56:43 violet kernel: input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:07.2-1
Aug  3 22:56:43 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  3 22:56:44 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  3 22:56:47 violet /etc/hotplug/usb.agent: Setup hid for USB product 1241/1111/100
Aug  3 22:56:47 violet modprobe: FATAL: Module hid not found. 
Aug  3 22:56:47 violet modprobe: FATAL: Error running install command for hid 
Aug  3 22:56:47 violet /etc/hotplug/usb.agent: ... can't load module hid
Aug  3 22:56:47 violet /etc/hotplug/usb.agent: missing kernel or user mode driver hid 
Aug  3 22:56:47 violet /etc/hotplug/usb.agent: Setup mousedev for USB product 1241/1111/100
Aug  3 22:56:48 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  3 22:56:48 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  3 22:56:48 violet kernel: hde: Write Cache FAILED Flushing!
Aug  3 22:56:48 violet devlabel: devlabel service started/restarted


About 9 hours later it happened again, only I did not have to disconnect
the mouse for it to recover (in fact, I did not even know the situation
happened again until I looked in the log).


Aug  4 07:53:13 violet kernel: hub 1-0:0: port 1 disabled by hub (EMI?), re-enabling...<6>usb 1-1: USB disconnect, address 4
Aug  4 07:53:13 violet kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
Aug  4 07:53:13 violet kernel: Call Trace:
Aug  4 07:53:13 violet kernel:  [<c011b5b1>] __might_sleep+0x61/0x80
Aug  4 07:53:13 violet kernel:  [<c029f22c>] hcd_endpoint_disable+0xcc/0x1b0
Aug  4 07:53:13 violet kernel:  [<c029f160>] hcd_endpoint_disable+0x0/0x1b0
Aug  4 07:53:13 violet kernel:  [<c0299bea>] nuke_urbs+0x4a/0x60
Aug  4 07:53:13 violet kernel:  [<c029a8c2>] usb_disconnect+0xa2/0x140
Aug  4 07:53:13 violet kernel:  [<c029d40f>] hub_port_connect_change+0x33f/0x350
Aug  4 07:53:13 violet kernel:  [<c029d74c>] hub_events+0x32c/0x3b0
Aug  4 07:53:13 violet kernel:  [<c029d805>] hub_thread+0x35/0xf0
Aug  4 07:53:13 violet kernel:  [<c011a1d0>] default_wake_function+0x0/0x30
Aug  4 07:53:13 violet kernel:  [<c029d7d0>] hub_thread+0x0/0xf0
Aug  4 07:53:13 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  4 07:53:13 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  4 07:53:13 violet kernel:  [<c01091a9>] kernel_thread_helper+0x5/0xc
Aug  4 07:53:14 violet /etc/hotplug/usb.agent: Bad USB agent invocation
Aug  4 07:53:14 violet /sbin/hotplug: no runnable /etc/hotplug/input.agent is installed
Aug  4 07:53:14 violet kernel: 
Aug  4 07:53:14 violet modprobe: FATAL: Module ide_probe_mod not found. 
Aug  4 07:53:14 violet kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Aug  4 07:53:14 violet modprobe: FATAL: Module ide_probe not found. 
Aug  4 07:53:14 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug  4 07:53:14 violet kernel: hub 1-0:0: new USB device on port 1, assigned address 5
Aug  4 07:53:14 violet kernel: input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:07.2-1
Aug  4 07:53:14 violet modprobe: FATAL: Module ohci1394 already in kernel. 
Aug  4 07:53:15 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  4 07:53:15 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  4 07:53:15 violet kernel: hde: Write Cache FAILED Flushing!
Aug  4 07:53:15 violet devlabel: devlabel service started/restarted
Aug  4 07:53:17 violet /etc/hotplug/usb.agent: Setup hid for USB product 1241/1111/100
Aug  4 07:53:17 violet modprobe: FATAL: Module hid not found. 
Aug  4 07:53:17 violet modprobe: FATAL: Error running install command for hid 
Aug  4 07:53:17 violet /etc/hotplug/usb.agent: ... can't load module hid
Aug  4 07:53:18 violet /etc/hotplug/usb.agent: missing kernel or user mode driver hid 
Aug  4 07:53:18 violet /etc/hotplug/usb.agent: Setup mousedev for USB product 1241/1111/100
Aug  4 07:53:18 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  4 07:53:18 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  4 07:53:18 violet kernel: hde: Write Cache FAILED Flushing!
Aug  4 07:53:19 violet devlabel: devlabel service started/restarted


This is the last occurrence in 40 hours.

	-Paul

