Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281011AbRKGWIR>; Wed, 7 Nov 2001 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281006AbRKGWII>; Wed, 7 Nov 2001 17:08:08 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:12502
	"EHLO janus") by vger.kernel.org with ESMTP id <S280997AbRKGWHk>;
	Wed, 7 Nov 2001 17:07:40 -0500
Message-ID: <3BE9BDD0.2070703@gutschke.com>
Date: Thu, 08 Nov 2001 00:03:44 +0100
From: Stephan Gutschke <stephan@gutschke.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

didn't work :-(

This is the output of /var/log/syslog if I connect to ttyUSB0
I am not sure yet though that the problem is in your module.
I know the jpilot worked, before, but I will still try later
to connect to the clie with coldsync as well.
Lets see if that gives anything different.
Let me know what else I can do to help.


Stephan


> Nov  7 21:13:28 yvette kernel: hub.c: port 1 connection change
> Nov  7 21:13:28 yvette kernel: hub.c: port 1, portstatus 101, change 1, 12 Mb/s
> Nov  7 21:13:28 yvette kernel: hub.c: port 1, portstatus 103, change 0, 12 Mb/s
> Nov  7 21:13:28 yvette kernel: hub.c: USB new device connect on bus1/1, assigned device number 6
> Nov  7 21:13:28 yvette kernel: usb.c: kmalloc IF ddcbcf00, numif 1
> Nov  7 21:13:28 yvette kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
> Nov  7 21:13:28 yvette kernel: usb.c: USB device number 6 default language ID 0x409
> Nov  7 21:13:28 yvette kernel: Manufacturer: Sony Corp.
> Nov  7 21:13:28 yvette kernel: Product: Palm Handheld
> Nov  7 21:13:28 yvette kernel: usbserial.c: Sony Clie 4.0 converter detected
> Nov  7 21:13:28 yvette kernel: visor.c: visor_startup
> Nov  7 21:13:28 yvette kernel: visor.c: visor_startup - Set config to 1
> Nov  7 21:13:28 yvette kernel: visor.c: Sony Clie 4.0: Number of ports: 2
> Nov  7 21:13:28 yvette kernel: visor.c: Sony Clie 4.0: port 1, is for Generic use and is bound to ttyUSB0
> Nov  7 21:13:28 yvette kernel: visor.c: Sony Clie 4.0: port 2, is for HotSync use and is bound to ttyUSB1
> Nov  7 21:13:28 yvette kernel: usb-uhci.c: interrupt, status 2, frame# 930
> Nov  7 21:13:31 yvette kernel: usb_control/bulk_msg: timeout
> Nov  7 21:13:31 yvette kernel: visor.c: visor_startup - error getting first unknown palm command
> Nov  7 21:13:34 yvette kernel: usb_control/bulk_msg: timeout
> Nov  7 21:13:34 yvette kernel: visor.c: visor_startup - error getting second unknown palm command
> Nov  7 21:13:34 yvette kernel: usbserial.c: Sony Clie 4.0 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
> Nov  7 21:13:34 yvette kernel: usbserial.c: Sony Clie 4.0 converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
> Nov  7 21:13:34 yvette kernel: usb.c: serial driver claimed interface ddcbcf00
> Nov  7 21:13:34 yvette kernel: usb.c: kusbd: /sbin/hotplug add 6
> Nov  7 21:13:34 yvette kernel: usb.c: kusbd policy returned 0xfffffffe
> Nov  7 21:13:38 yvette kernel: visor.c: visor_open - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_openport->read_urb c65b0cc0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_openport->serial->dev de451a00
> Nov  7 21:13:38 yvette kernel: visor.c: visor_openport->read_urb->transfer_buffer c1b50960
> Nov  7 21:13:38 yvette kernel: visor.c: visor_openport->read_urb->transfer_buffer_length 64
> Nov  7 21:13:38 yvette kernel: visor.c: visor_open just after reading and submitting urb 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
> Nov  7 21:13:38 yvette kernel: visor.c: visor_read_bulk_callback - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_read_bulk_callback - length = 6, data = 01 ff 00 00 00 16 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 41 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - returns 16896
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = ff 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 08 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_bulk_callback - port 0
> Nov  7 21:13:38 yvette last message repeated 10 times
> Nov  7 21:13:38 yvette kernel: visor.c: visor_read_bulk_callback - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_read_bulk_callback - length = 22, data = 90 01 00 00 00 00 00 00 00 20 00 00 00 08 00 00 01 00 00 00 00 00 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - returns 18432
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 90 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 41 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_room - returns 5376
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 20 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 5e 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - length = 1, data = 40 
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write - no more free urbs
> Nov  7 21:13:38 yvette kernel: visor.c: visor_write_bulk_callback - port 0
> Nov  7 21:13:38 yvette last message repeated 23 times
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5402
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - data bits = 8
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - parity = none
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - stop bits = 1
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - RTS/CTS is disabled
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - XON/XOFF is disabled
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - baud rate = 9600
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
> Nov  7 21:13:38 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5403
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_set_termios - nothing to change...
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - port 0
> Nov  7 21:13:38 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
> Nov  7 21:14:00 yvette kernel: usb-uhci.c: interrupt, status 3, frame# 495
> Nov  7 21:14:00 yvette kernel: visor.c: visor_read_bulk_callback - port 0
> Nov  7 21:14:00 yvette kernel: visor.c: visor_read_bulk_callback - nonzero read bulk status received: -84
> Nov  7 21:14:00 yvette kernel: hub.c: port 1 connection change
> Nov  7 21:14:00 yvette kernel: hub.c: port 1, portstatus 100, change 3, 12 Mb/s
> Nov  7 21:14:00 yvette kernel: usb.c: USB disconnect on device 6
> Nov  7 21:14:00 yvette kernel: visor.c: visor_shutdown
> Nov  7 21:14:00 yvette kernel: visor.c: visor_close - port 0
> Nov  7 21:14:00 yvette kernel: usbserial.c: Sony Clie 4.0 converter now disconnected from ttyUSB0
> Nov  7 21:14:00 yvette kernel: usbserial.c: Sony Clie 4.0 converter now disconnected from ttyUSB1
> Nov  7 21:14:00 yvette kernel: usb.c: kusbd: /sbin/hotplug remove 6
> Nov  7 21:14:00 yvette kernel: usb.c: kusbd policy returned 0xfffffffe
> Nov  7 21:14:00 yvette kernel: hub.c: port 1 enable change, status 100



Greg KH wrote:

> On Tue, Nov 06, 2001 at 03:27:46PM +0100, Stephan Gutschke wrote:
> 
>>Hi Greg,
>>
>>the output is below, I also added a couple of debug-lines in the
>>visor_open() function. Seems to me like port->read_urb is null and
>>maybe that shouldn't be?
>>
> 
> Hm, yes, port->read_urb should _NOT_ be NULL.  Thanks for adding this
> check.
> 
> Can you send the output of /proc/bus/usb/devices right after you press
> the sync button on the Clie?  Don't try syncing :)
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Stephan Gutschke

