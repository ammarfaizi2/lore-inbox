Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278082AbRJKDm6>; Wed, 10 Oct 2001 23:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278083AbRJKDmt>; Wed, 10 Oct 2001 23:42:49 -0400
Received: from [64.40.53.35] ([64.40.53.35]:8583 "HELO fortytwo.homeip.net")
	by vger.kernel.org with SMTP id <S278082AbRJKDmi>;
	Wed, 10 Oct 2001 23:42:38 -0400
Message-ID: <3BC51513.8040604@users.sourceforge.net>
Date: Wed, 10 Oct 2001 20:42:11 -0700
From: Colin Bayer <vogon_jeltz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB "raced timeout" errors on boot (2.4.11)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I boot with my brand-new 2.4.11 kernel, I get the following 
series of errors (this snippet's from /var/log/messages):

Oct  9 18:28:13 fortytwo kernel: uhci.c: USB UHCI at I/O 0xef80, IRQ 10
Oct  9 18:28:13 fortytwo kernel: usb.c: new USB bus registered, assigned 
bus number 1
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000000 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000180 
status 0 time left 0
Oct  9 18:28:13 fortytwo last message repeated 3 times
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000100 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: hub.c: USB hub found
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000180 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: hub.c: 2 ports detected
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000180 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000100 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000180 
status 0 time left 0
Oct  9 18:28:13 fortytwo kernel: usb: raced timeout, pipe 0x80000100 
status 0 time left 0

... and so on.  My USB devices seem to work just fine, but the errors 
are kind of annoying (and add about 10 seconds to my boot time).

My USB bus is hooked up like this:
	back of computer
	`- my keyboard
		`-my mouse

lspci -vvv:

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 
00 [UHCI])
         Subsystem: Intel Corporation 82801AA USB
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at ef80 [size=32]

dmesg:

input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] 
on usb1:3.0

(and my keyboard is a Microsoft Internet Keyboard Pro).  Oh, don't boo 
me... I'm using Linux, am I not? :)

					-- Colin

(P.S. Please CC me any replies to this message.)

