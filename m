Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRKHSQf>; Thu, 8 Nov 2001 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKHSQ0>; Thu, 8 Nov 2001 13:16:26 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:35726
	"EHLO janus") by vger.kernel.org with ESMTP id <S276956AbRKHSQR>;
	Thu, 8 Nov 2001 13:16:17 -0500
Message-ID: <3BEAD904.2050406@gutschke.com>
Date: Thu, 08 Nov 2001 20:12:04 +0100
From: Stephan Gutschke <stephan@gutschke.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE9BDD0.2070703@gutschke.com> <20011107151806.A22444@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi greg,

I am using coldsync version 2.2.3, which seems to be the
newest snapshot. I read the doc and it says in the changelog
that they removed the  "usb_m50x" flag. Seems that using protocol
"simple" should now do the trick.

I do:

coldsync -mb /tmp/ -t serial  -p /dev/ttyUSB0

with an .coldsyncrc like this:

listen serial {
                protocol: simple;
                }
	
pda "My Palm" {
	#	snum: XXXX;
		username: "Stephan Gutschke";
		userid: 256;
		default;
	}
	
coldsync just says:
Warning: no device on /dev/ttyUSB0. Sleeping
Please press the HotSync button.  <- comes after i press the hotsync 
button on my clie



And than i get the things below, which

Nov  8 19:58:53 yvette kernel: hub.c: port 1 connection change
Nov  8 19:58:53 yvette kernel: hub.c: port 1, portstatus 101, change 1, 
12 Mb/s
Nov  8 19:58:53 yvette kernel: hub.c: port 1, portstatus 103, change 0, 
12 Mb/s
Nov  8 19:58:53 yvette kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 4
Nov  8 19:58:53 yvette kernel: usb.c: kmalloc IF cb82a620, numif 1
Nov  8 19:58:53 yvette kernel: usb.c: new device strings: Mfr=1, 
Product=2, SerialNumber=0
Nov  8 19:58:53 yvette kernel: usb.c: USB device number 4 default 
language ID 0x409
Nov  8 19:58:53 yvette kernel: Manufacturer: Sony Corp.
Nov  8 19:58:53 yvette kernel: Product: Palm Handheld
Nov  8 19:58:53 yvette kernel: usbserial.c: Sony Clie 4.0 converter detected
Nov  8 19:58:53 yvette kernel: visor.c: visor_startup
Nov  8 19:58:53 yvette kernel: visor.c: visor_startup - Set config to 1
Nov  8 19:58:53 yvette kernel: visor.c: Sony Clie 4.0: Number of ports: 2
Nov  8 19:58:53 yvette kernel: visor.c: Sony Clie 4.0: port 1, is for 
Generic use and is bound to ttyUSB0
Nov  8 19:58:53 yvette kernel: visor.c: Sony Clie 4.0: port 2, is for 
HotSync use and is bound to ttyUSB1
Nov  8 19:58:53 yvette kernel: usb-uhci.c: interrupt, status 2, frame# 1802
Nov  8 19:58:56 yvette kernel: usb_control/bulk_msg: timeout
Nov  8 19:58:56 yvette kernel: visor.c: visor_startup - error getting 
first unknown palm command
Nov  8 19:58:59 yvette kernel: usb_control/bulk_msg: timeout
Nov  8 19:58:59 yvette kernel: visor.c: visor_startup - error getting 
second unknown palm command
Nov  8 19:58:59 yvette kernel: usbserial.c: Sony Clie 4.0 converter now 
attached to ttyUSB0 (or usb/tts/0 for devfs)
Nov  8 19:58:59 yvette kernel: usbserial.c: Sony Clie 4.0 converter now 
attached to ttyUSB1 (or usb/tts/1 for devfs)
Nov  8 19:58:59 yvette kernel: usb.c: serial driver claimed interface 
cb82a620
Nov  8 19:58:59 yvette kernel: usb.c: kusbd: /sbin/hotplug add 4
Nov  8 19:58:59 yvette kernel: usb.c: kusbd policy returned 0xfffffffe
Nov  8 19:59:01 yvette kernel: visor.c: visor_open - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_openport->read_urb db335840
Nov  8 19:59:01 yvette kernel: visor.c: visor_openport->serial->dev de430c00
Nov  8 19:59:01 yvette kernel: visor.c: 
visor_openport->read_urb->transfer_buffer ce39af20
Nov  8 19:59:01 yvette kernel: visor.c: 
visor_openport->read_urb->transfer_buffer_length 64
Nov  8 19:59:01 yvette kernel: visor.c: visor_open just after reading 
and submitting urb 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5402
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - data bits = 8
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - parity = none
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - stop bits = 1
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - RTS/CTS is 
disabled
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - XON/XOFF is 
disabled
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - baud rate = 
230400
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5402
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - data bits = 8
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - parity = none
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - stop bits = 1
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - RTS/CTS is 
disabled
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - XON/XOFF is 
disabled
Nov  8 19:59:01 yvette kernel: visor.c: visor_set_termios - baud rate = 9600
Nov  8 19:59:01 yvette kernel: visor.c: visor_ioctl - port 0, cmd 0x5401
Nov  8 19:59:01 yvette kernel: visor.c: visor_chars_in_buffer - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_read_bulk_callback - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_read_bulk_callback - 
length = 6, data = 01 ff 00 00 00 16
Nov  8 19:59:01 yvette kernel: visor.c: visor_chars_in_buffer - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_chars_in_buffer - returns 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_read_bulk_callback - port 0
Nov  8 19:59:01 yvette kernel: visor.c: visor_read_bulk_callback - 
length = 22, data = 90 01 00 00 00 00 00 00 00 20 00 00 00 08 00 00 01 
00 00 00 00 00
Nov  8 20:00:01 yvette kernel: usb-uhci.c: interrupt, status 3, frame# 1889
Nov  8 20:00:01 yvette kernel: visor.c: visor_read_bulk_callback - port 0
Nov  8 20:00:01 yvette kernel: visor.c: visor_read_bulk_callback - 
nonzero read bulk status received: -84
Nov  8 20:00:01 yvette kernel: hub.c: port 1 connection change
Nov  8 20:00:01 yvette kernel: hub.c: port 1, portstatus 100, change 3, 
12 Mb/s
Nov  8 20:00:01 yvette kernel: usb.c: USB disconnect on device 4
Nov  8 20:00:01 yvette kernel: visor.c: visor_shutdown
Nov  8 20:00:01 yvette kernel: visor.c: visor_close - port 0
Nov  8 20:00:01 yvette kernel: usbserial.c: Sony Clie 4.0 converter now 
disconnected from ttyUSB0
Nov  8 20:00:01 yvette kernel: usbserial.c: Sony Clie 4.0 converter now 
disconnected from ttyUSB1
Nov  8 20:00:01 yvette kernel: usb.c: kusbd: /sbin/hotplug remove 4
Nov  8 20:00:01 yvette kernel: usb.c: kusbd policy returned 0xfffffffe
Nov  8 20:00:01 yvette kernel: hub.c: port 1 enable change, status 100


Greg KH wrote:

> On Thu, Nov 08, 2001 at 12:03:44AM +0100, Stephan Gutschke wrote:
> 
>>didn't work :-(
>>
>>This is the output of /var/log/syslog if I connect to ttyUSB0
>>I am not sure yet though that the problem is in your module.
>>I know the jpilot worked, before, but I will still try later
>>to connect to the clie with coldsync as well.
>>Lets see if that gives anything different.
>>Let me know what else I can do to help.
>>
> 
> Yes, you will have to use coldsync to talk to this device right now, as
> pilot-link doesn't have support for the 4.x Palm OS USB protocol yet
> (jpilot uses pilot-link.)
> 
> Let me know if coldsync fails (remember you have to tell coldsync that
> you are a m50x, and that you want the "simple" protocol, check the docs
> for the proper config file setting.)
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

