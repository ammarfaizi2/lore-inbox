Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTIARkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIARky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:40:54 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:56336 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263176AbTIARk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:40:26 -0400
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.4.22: OOPS on disconnect PL2303 adapter - see also 2.6.0-test4 - PL2303 annoyances
Date: Tue, 2 Sep 2003 01:37:17 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309020115.29965.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the troubles with 2.6, rebooted with 2.4.22, First use of USB
with 2.4.22 ;) 

Behaviour same + an oops...

Sorry, the call trace DOES not make sense - I checked that I use the correct symbols ;

Regards 
Michael

Sep  1 18:49:03 mhfl2 kernel: Linux version 2.4.22-mhf58 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #12 Mon Sep 1 18:17:25 HKT 2003

[]

Sep  1 18:50:10 mhfl2 kernel: usb.c: registered new driver usbdevfs
Sep  1 18:50:10 mhfl2 kernel: usb.c: registered new driver hub
Sep  1 18:50:10 mhfl2 kernel: SCSI subsystem driver Revision: 1.00
Sep  1 18:50:10 mhfl2 kernel: Initializing USB Mass Storage driver...
Sep  1 18:50:10 mhfl2 kernel: usb.c: registered new driver usb-storage
Sep  1 18:50:10 mhfl2 kernel: USB Mass Storage support registered.
Sep  1 18:50:11 mhfl2 kernel: usb.c: registered new driver serial
Sep  1 18:50:11 mhfl2 kernel: usbserial.c: USB Serial Driver core v1.4
Sep  1 18:50:11 mhfl2 kernel: usbserial.c: USB Serial support registered for PL-2303
Sep  1 18:50:11 mhfl2 kernel: pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
Sep  1 18:50:11 mhfl2 modprobe: modprobe: Can't locate module parport_lowlevel
Sep  1 18:50:11 mhfl2 kernel: lp: driver loaded but no devices found
Sep  1 18:50:24 mhfl2 kernel: usb-ohci.c: USB OHCI at membase 0xcf958000, IRQ 11
Sep  1 18:50:24 mhfl2 kernel: usb-ohci.c: usb-00:14.0, ALi Corporation USB 1.1 Controller
Sep  1 18:50:24 mhfl2 kernel: usb.c: new USB bus registered, assigned bus number 1
Sep  1 18:50:24 mhfl2 kernel: Product: USB OHCI Root Hub
Sep  1 18:50:24 mhfl2 kernel: SerialNumber: cf958000
Sep  1 18:50:24 mhfl2 kernel: hub.c: USB hub found
Sep  1 18:50:24 mhfl2 kernel: hub.c: 2 ports detected
Sep  1 18:50:25 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/001 PRODUCT=0/0/0 TYPE=9/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:50:25 mhfl2 kernel: hub.c: new USB device 00:14.0-2, assigned address 2
Sep  1 18:50:25 mhfl2 kernel: usbserial.c: PL-2303 converter detected
Sep  1 18:50:25 mhfl2 kernel: usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Sep  1 18:50:25 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:50:25 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/002 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:50:25 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:50:31 mhfl2 /etc/hotplug/usb.agent: Setup pl2303 for USB product 67b/2303/200
Sep  1 18:50:32 mhfl2 /etc/hotplug/usb.agent: ... no modules for USB product 0/0/0
Sep  1 18:53:09 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-2 address 2
Sep  1 18:53:09 mhfl2 kernel: usbserial.c: PL-2303 converter now disconnected from ttyUSB0
Sep  1 18:53:09 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/002 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:53:09 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:53:13 mhfl2 kernel: hub.c: new USB device 00:14.0-2, assigned address 3
Sep  1 18:53:13 mhfl2 kernel: usbserial.c: PL-2303 converter detected
Sep  1 18:53:13 mhfl2 kernel: usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Sep  1 18:53:13 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/003 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:53:13 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:53:17 mhfl2 /etc/hotplug/usb.agent: Setup pl2303 for USB product 67b/2303/200
Sep  1 18:53:39 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-2 address 3
Sep  1 18:53:39 mhfl2 kernel: usbserial.c: PL-2303 converter now disconnected from ttyUSB0
Sep  1 18:53:39 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/003 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:53:39 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:53:42 mhfl2 kernel: hub.c: new USB device 00:14.0-2, assigned address 4
Sep  1 18:53:42 mhfl2 kernel: usbserial.c: PL-2303 converter detected
Sep  1 18:53:42 mhfl2 kernel: usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Sep  1 18:53:42 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/004 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:53:42 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:53:46 mhfl2 /etc/hotplug/usb.agent: Setup pl2303 for USB product 67b/2303/200
Sep  1 18:54:00 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-2 address 4
Sep  1 18:54:00 mhfl2 kernel: usbserial.c: PL-2303 converter now disconnected from ttyUSB0
Sep  1 18:54:00 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/004 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:54:00 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:54:03 mhfl2 kernel: hub.c: new USB device 00:14.0-2, assigned address 5
Sep  1 18:54:03 mhfl2 kernel: usbserial.c: PL-2303 converter detected
Sep  1 18:54:03 mhfl2 kernel: usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Sep  1 18:54:03 mhfl2 /sbin/hotplug: arguments (usb) env (DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/005 INTERFACE=255/0/0 PRODUCT=67b/2303/200 TYPE=0/0/0 DEBUG=kernel _=/bin/env)
Sep  1 18:54:03 mhfl2 /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Sep  1 18:54:07 mhfl2 /etc/hotplug/usb.agent: Setup pl2303 for USB product 67b/2303/200
Sep  1 18:54:10 mhfl2 kernel: usb.c: USB disconnect on device 00:14.0-2 address 5
Sep  1 18:54:10 mhfl2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 000009a4
Sep  1 18:54:10 mhfl2 kernel:  printing eip:
Sep  1 18:54:10 mhfl2 kernel: cf944de4
Sep  1 18:54:10 mhfl2 kernel: *pde = 00000000
Sep  1 18:54:10 mhfl2 kernel: Oops: 0002
Sep  1 18:54:10 mhfl2 kernel: CPU:    0
Sep  1 18:54:10 mhfl2 kernel: EIP:    1010:[<cf944de4>]    Not tainted
Sep  1 18:54:10 mhfl2 kernel: EFLAGS: 00010246
Sep  1 18:54:10 mhfl2 kernel: eax: 00000000   ebx: cc96541c   ecx: cb783efc   edx: 00000286
Sep  1 18:54:10 mhfl2 kernel: esi: 00000001   edi: cc965400   ebp: 00000000   esp: cb783f38
Sep  1 18:54:10 mhfl2 kernel: ds: 1018   es: 1018   ss: 1018
Sep  1 18:54:10 mhfl2 kernel: Process khubd (pid: 2440, stackpage=cb783000)
Sep  1 18:54:10 mhfl2 kernel: Stack: cf945fc0 cb057fc0 cf945fe0 cf8fb0ba ca743000 cc965400 00000002 00000100 
Sep  1 18:54:10 mhfl2 kernel:        cdadde00 00000002 00000000 ca743000 cf8fd7d4 cdaddf14 00000002 00000001 
Sep  1 18:54:10 mhfl2 kernel:        cdadde00 cb6a62c0 00000004 cdaddf10 c0306443 00003246 0000000a cf8fdb06 
Sep  1 18:54:10 mhfl2 kernel: Call Trace:    [<cf945fc0>] [<cf945fe0>] [<cf8fb0ba>] [<cf8fd7d4>] [<cf8fdb06>]
Sep  1 18:54:10 mhfl2 kernel:   [<cf905f20>] [<cf8fdcac>] [<c01066c0>]
Sep  1 18:54:10 mhfl2 kernel: 
Sep  1 18:54:10 mhfl2 kernel: Code: c7 80 a4 09 00 00 00 00 00 00 8d 4b 5c ff 43 5c 0f 8e a0 03 
Sep  1 18:55:45 mhfl2 kernel:  <7>usb-storage: usb_stor_exit() called
Sep  1 18:55:45 mhfl2 kernel: usb.c: deregistering driver usb-storage
Sep  1 18:55:45 mhfl2 kernel: usbserial.c: USB Serial deregistering driver PL-2303

[mhf@mhfl2 01:30:54 mhf]$ oops
ksymoops 2.4.5 on i686 2.6.0-test4-mhf60.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-mhf58 (specified)
     -m /boot/System.map-2.4.22-mhf58 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep  1 18:54:10 mhfl2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 000009a4
Sep  1 18:54:10 mhfl2 kernel: cf944de4
Sep  1 18:54:10 mhfl2 kernel: *pde = 00000000
Sep  1 18:54:10 mhfl2 kernel: Oops: 0002
Sep  1 18:54:10 mhfl2 kernel: CPU:    0
Sep  1 18:54:10 mhfl2 kernel: EIP:    1010:[<cf944de4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  1 18:54:10 mhfl2 kernel: EFLAGS: 00010246
Sep  1 18:54:10 mhfl2 kernel: eax: 00000000   ebx: cc96541c   ecx: cb783efc   edx: 00000286
Sep  1 18:54:10 mhfl2 kernel: esi: 00000001   edi: cc965400   ebp: 00000000   esp: cb783f38
Sep  1 18:54:10 mhfl2 kernel: ds: 1018   es: 1018   ss: 1018
Sep  1 18:54:10 mhfl2 kernel: Process khubd (pid: 2440, stackpage=cb783000)
Sep  1 18:54:10 mhfl2 kernel: Stack: cf945fc0 cb057fc0 cf945fe0 cf8fb0ba ca743000 cc965400 00000002 00000100
Sep  1 18:54:10 mhfl2 kernel:        cdadde00 00000002 00000000 ca743000 cf8fd7d4 cdaddf14 00000002 00000001
Sep  1 18:54:10 mhfl2 kernel:        cdadde00 cb6a62c0 00000004 cdaddf10 c0306443 00003246 0000000a cf8fdb06
Sep  1 18:54:10 mhfl2 kernel: Call Trace:    [<cf945fc0>] [<cf945fe0>] [<cf8fb0ba>] [<cf8fd7d4>] [<cf8fdb06>]
Sep  1 18:54:10 mhfl2 kernel:   [<cf905f20>] [<cf8fdcac>] [<c01066c0>]
Sep  1 18:54:10 mhfl2 kernel: Code: c7 80 a4 09 00 00 00 00 00 00 8d 4b 5c ff 43 5c 0f 8e a0 03


>>EIP; cf944de4 <END_OF_CODE+f5f2fcc/????>   <=====

>>ebx; cc96541c <END_OF_CODE+c613604/????>
>>ecx; cb783efc <END_OF_CODE+b4320e4/????>
>>edi; cc965400 <END_OF_CODE+c6135e8/????>
>>esp; cb783f38 <END_OF_CODE+b432120/????>

Trace; cf945fc0 <END_OF_CODE+f5f41a8/????>
Trace; cf945fe0 <END_OF_CODE+f5f41c8/????>
Trace; cf8fb0ba <END_OF_CODE+f5a92a2/????>
Trace; cf8fd7d4 <END_OF_CODE+f5ab9bc/????>
Trace; cf8fdb06 <END_OF_CODE+f5abcee/????>
Trace; cf905f20 <END_OF_CODE+f5b4108/????>
Trace; cf8fdcac <END_OF_CODE+f5abe94/????>
Trace; c01066c0 <arch_kernel_thread+28/38>

Code;  cf944de4 <END_OF_CODE+f5f2fcc/????>
00000000 <_EIP>:
Code;  cf944de4 <END_OF_CODE+f5f2fcc/????>   <=====
   0:   c7 80 a4 09 00 00 00      movl   $0x0,0x9a4(%eax)   <=====
Code;  cf944deb <END_OF_CODE+f5f2fd3/????>
   7:   00 00 00
Code;  cf944dee <END_OF_CODE+f5f2fd6/????>
   a:   8d 4b 5c                  lea    0x5c(%ebx),%ecx
Code;  cf944df1 <END_OF_CODE+f5f2fd9/????>
   d:   ff 43 5c                  incl   0x5c(%ebx)
Code;  cf944df4 <END_OF_CODE+f5f2fdc/????>
  10:   0f 8e a0 03 00 00         jle    3b6 <_EIP+0x3b6>

1 error issued.  Results may not be reliable.

