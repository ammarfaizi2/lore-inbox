Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267560AbUBSUlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267567AbUBSUlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:41:03 -0500
Received: from wiggis.ethz.ch ([129.132.86.197]:235 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S267560AbUBSUkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:40:42 -0500
From: Thom Borton <borton@phys.ethz.ch>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Oops 2.4.25: USB visor module - Clie synchro
Date: Thu, 19 Feb 2004 21:40:15 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200402192140.15756.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody

I occasionally run into a kernel Oops when I try to sync my sony clie, 
(PEG-SJ33) with kpilot. This is with a stock 2.4.25 kernel, but the same 
happened to me with the previous .24 and .23 kernels.

Strangely, it helps making a "pilot-xfer -l" the first time. This downloads a 
list of files on the clie (and never fails), and then kpilot will work as 
well.

As it is a kernel Oops, I thought this might be the best place to report, if 
it's a kde issue, tell me, I will ask there.

Best regards, John

Excerpt from /var/log/syslog:

Feb 19 21:23:07 grisu kernel: hub.c: new USB device 00:07.2-1, assigned 
address 4
Feb 19 21:23:07 grisu kernel: usb.c: USB device 4 (vend/prod 0x54c/0x9a) is 
not claimed by any active driver.
Feb 19 21:23:08 grisu /etc/hotplug/usb.agent: Setup visor for USB product 
54c/9a/100
Feb 19 21:23:08 grisu kernel: usb.c: registered new driver serial
Feb 19 21:23:08 grisu kernel: usbserial.c: USB Serial support registered for 
Generic
Feb 19 21:23:08 grisu kernel: usbserial.c: USB Serial Driver core v1.4
Feb 19 21:23:08 grisu kernel: usbserial.c: USB Serial support registered for 
Handspring Visor / Treo / Palm 4.0 / Clié 4.x
Feb 19 21:23:08 grisu kernel: usbserial.c: Handspring Visor / Treo / Palm 
4.0 / Clié 4.x converter detected
Feb 19 21:23:08 grisu kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000018
Feb 19 21:23:08 grisu kernel:  printing eip:
Feb 19 21:23:08 grisu kernel: c91926f8
Feb 19 21:23:08 grisu kernel: *pde = 00000000
Feb 19 21:23:08 grisu kernel: Oops: 0000
Feb 19 21:23:08 grisu kernel: CPU:    0
Feb 19 21:23:08 grisu kernel: EIP:    0010:
[serial:__insmod_serial_S.data_L16832+1312824/24566664]    Not tainted
Feb 19 21:23:08 grisu kernel: EFLAGS: 00010046
Feb 19 21:23:08 grisu kernel: eax: 00000000   ebx: c9194aa0   ecx: 00000017   
edx: 00000300
Feb 19 21:23:08 grisu kernel: esi: 00000000   edi: 00000246   ebp: c616b920   
esp: c21ebeac
Feb 19 21:23:08 grisu kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 21:23:08 grisu kernel: Process kpilotDaemon (pid: 3164, 
stackpage=c21eb000)
Feb 19 21:23:08 grisu kernel: Stack: c3c8081c c3c80800 ffffffea c918c790 
c3c8081c c2c3a000 00000000 00000000 
Feb 19 21:23:08 grisu kernel:        c017203f c2c3a000 c21ebf50 c42727c0 
c2f3f35c c012f55c c01430e3 c1890980 
Feb 19 21:23:08 grisu kernel:        00000246 c1890980 c2c3a000 c616b920 
00000001 00000145 c016f3b3 c2c3a000 
Feb 19 21:23:08 grisu kernel: Call Trace:    
[serial:__insmod_serial_S.data_L16832+1288400/24591088] [normal_poll+207/352] 
[__get_free_pages+12/80] [__pollwait+51/144] [tty_poll+99/144]
Feb 19 21:23:08 grisu kernel:   [sock_poll+31/48] [do_select+249/544] 
[sys_select+677/1216] [system_call+51/56]
Feb 19 21:23:08 grisu kernel: 
Feb 19 21:23:08 grisu kernel: Code: 83 78 18 8d 0f 44 f2 83 c3 04 49 79 eb 57 
9d 8b 0d 80 4a 19 
Feb 19 21:23:08 grisu kernel:  <4>usb-uhci.c: interrupt, status 3, frame# 1718
Feb 19 21:23:11 grisu kernel: usb_control/bulk_msg: timeout
Feb 19 21:23:11 grisu kernel: visor.c: visor_startup - error -110 getting 
connection info
Feb 19 21:23:11 grisu kernel: usbserial.c: Handspring Visor / Treo / Palm 
4.0 / Clié 4.x converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Feb 19 21:23:11 grisu kernel: usbserial.c: Handspring Visor / Treo / Palm 
4.0 / Clié 4.x converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Feb 19 21:23:11 grisu kernel: usbserial.c: USB Serial support registered for 
Sony Clié 3.5
Feb 19 21:23:11 grisu kernel: visor.c: USB HandSpring Visor, Palm m50x, Treo, 
Sony Clié driver v1.7
Feb 19 21:23:11 grisu /etc/hotplug/usb.agent: missing kernel or user mode 
driver visor 


-- 
Thom Borton
Switzerland
