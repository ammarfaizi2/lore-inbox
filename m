Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTLGG1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 01:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTLGG1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 01:27:54 -0500
Received: from [66.62.77.7] ([66.62.77.7]:8083 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262130AbTLGG1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 01:27:52 -0500
Subject: USB/visor oops
From: Dax Kelson <dax@gurulabs.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070778430.25972.3.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 06 Dec 2003 23:27:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having had my Tre600 hotsyncing working fine with RHL9 I'm trying
again after upgrading to Fedora. So far all I get are oops and hangs.

This is with the Fedora kernel 2.4.22-1.2115.nptl. This is with the uhci
instead of usb-uhci.

hub.c: new USB device 00:1d.0-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x82d/0x300) is not claimed by any active driver.
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Handspring Visor / Treo / Palm 4. 0 / Clie 4.x
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clie 4.x converter detected
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clie 4.x converter now attache d to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clie 4.x converter now attache d to ttyUSB1 (or usb/tts/1 for devfs)
usbserial.c: USB Serial support registered for Sony Clie 3.5
visor.c: USB HandSpring Visor, Palm m50x, Treo, Sony Clie driver v1.7
uhci.c: bf80: host controller halted. very bad
usb.c: USB disconnect on device 00:1d.0-1 address 2
visor.c: Bytes In = 0  Bytes Out = 0
Unable to handle kernel NULL pointer dereference at virtual address 00000998
 printing eip:
f884556c
*pde = 37253067
*pte = 00000000
Oops: 0002
visor usbserial uhci i810_audio ac97_codec soundcore radeon agpgart vmnet vmmon parport_pc lp parport autofs orinoco_cs orinoco hermes ds yenta_socket pcmcia_
CPU:    0
EIP:    0060:[<f884556c>]    Tainted: PF
EFLAGS: 00010246
 
EIP is at usb_serial_disconnect [usbserial] 0x6c (2.4.22-1.2115.nptl)
eax: 00000000   ebx: f3830400   ecx: 00000000   edx: 00000000
esi: f383041c   edi: 00000000   ebp: f3830400   esp: f7bc9f14
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 71, stackpage=f7bc9000)
Stack: f383041c 00000000 00000064 f8847520 f8847500 00000000 f4cc0980 f883032f
       e42f9200 f3830400 e42f9204 00000002 00000000 e42f9200 00000100 0000000a
       f7355a00 00000000 f8833270 f7355b0c 00000001 00000010 f4cc05c0 f8832c9c
Call Trace:   [<f8847520>] usb_serial_driver [usbserial] 0x20 (0xf7bc9f20)
[<f8847500>] usb_serial_driver [usbserial] 0x0 (0xf7bc9f24)
[<f883032f>] usb_disconnect_R1a2445d3 [usbcore] 0x9f (0xf7bc9f30)
[<f8833270>] usb_hub_port_connect_change [usbcore] 0x270 (0xf7bc9f5c)
[<f8832c9c>] usb_hub_port_status [usbcore] 0x6c (0xf7bc9f70)
[<f8833568>] usb_hub_events [usbcore] 0x2e8 (0xf7bc9f90)
[<f8833605>] usb_hub_thread [usbcore] 0x45 (0xf7bc9fbc)
[<f88335c0>] usb_hub_thread [usbcore] 0x0 (0xf7bc9fc4)
[<f88335c0>] usb_hub_thread [usbcore] 0x0 (0xf7bc9fe0)
[<c010741d>] kernel_thread_helper [kernel] 0x5 (0xf7bc9ff0)
 
 
Code: 89 90 98 09 00 00 8d 4e 58 ff 43 74 0f 8e 96 05 00 00 0f b6
  


