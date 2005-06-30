Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVF3Fey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVF3Fey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 01:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVF3Fe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 01:34:28 -0400
Received: from outmx022.isp.belgacom.be ([195.238.2.203]:47520 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262846AbVF3FeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 01:34:05 -0400
Message-ID: <42C38444.7000504@skynet.be>
Date: Thu, 30 Jun 2005 07:33:56 +0200
From: Eric FAURE <eric.faure@skynet.be>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tungsten t5 doesn't sync anymore with kernel 2.6.12
References: <42C0E879.5010605@skynet.be> <20050628083644.GA4246@kroah.com> <42C27DCD.1090107@skynet.be> <20050630000132.GD19727@kroah.com>
In-Reply-To: <20050630000132.GD19727@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried to push the button, before, on going, after...
if it looks ok for you, then I will send it to the pilot-link list
Thanks anyway.
Eric

Greg KH wrote:
> On Wed, Jun 29, 2005 at 12:54:05PM +0200, Eric FAURE wrote:
> 
>>hi,
>>I don't know if it's normal, but I see the line
>>visor_set_termios - nothing to change...
>>several times in the kernel 2.6.12 (not working one...)
>>
>>here under, the output of kernel 2.6.12 and 2.6.11
>>thanks,
>>eric
>>
>>
>>here the dmesg with kernel 2.6.11 from the visor debug=1 (the working one):
>>
>>drivers/usb/serial/visor.c: visor_write - port 1
> 
> 
> <snip>  This isn't the "startup" output, right?  Looks like you are in
> the middle of a sync.
> 
> 
>>and here the dmesg from kernel 2.6.12 (not working) :
>>
>>usbcore: registered new driver usbserial
>>drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
>>usbcore: registered new driver usbserial_generic
>>drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
>>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
>>Handspring Visor / Palm OS
>>drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
>>Clie 3.5
>>drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
>>Clie 5.0
>>usbcore: registered new driver visor
>>drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
>>usb 3-2: new full speed USB device using uhci_hcd and address 2
>>usb 3-2: device descriptor read/64, error -71
>>drivers/usb/serial/visor.c: visor_probe
>>drivers/usb/serial/visor.c: palm_os_4_probe
>>usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
>>00 67 00 00 00 00 00 00 01 01 00 00
>>visor 3-2:1.0: Handspring Visor / Palm OS converter detected
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
>>usb 3-2: USB disconnect, address 2
>>drivers/usb/serial/visor.c: visor_shutdown
>>visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
>>from ttyUSB0
>>visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
>>from ttyUSB1
>>visor 3-2:1.0: device disconnected
> 
> 
> The device was disconnected here, what happened?
> 
> 
>>usb 3-2: new full speed USB device using uhci_hcd and address 3
>>drivers/usb/serial/visor.c: visor_probe
>>drivers/usb/serial/visor.c: palm_os_4_probe
>>usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 63 6e 79 73 
>>00 67 00 00 00 00 00 00 01 01 00 00
>>visor 3-2:1.0: Handspring Visor / Palm OS converter detected
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
>>drivers/usb/serial/visor.c: visor_open - port 1
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - data bits = 8
>>drivers/usb/serial/visor.c: visor_set_termios - parity = none
>>drivers/usb/serial/visor.c: visor_set_termios - stop bits = 1
>>drivers/usb/serial/visor.c: visor_set_termios - RTS/CTS is disabled
>>drivers/usb/serial/visor.c: visor_set_termios - XON/XOFF is disabled
>>drivers/usb/serial/visor.c: visor_set_termios - baud rate = 9600
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
>>visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 ff 00 00 00 16
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_close - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk status received: -2
> 
> 
> Ok, this looks fine, someone opened the port, and then closed it.  Did
> you try to sync with it at that moment?
> 
> 
>>drivers/usb/serial/visor.c: visor_open - port 1
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_close - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk status received: -2
> 
> 
> Again, an open and close.
> 
> 
> 
>>drivers/usb/serial/visor.c: visor_open - port 1
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
>>drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - port 1
>>drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
>>drivers/usb/serial/visor.c: visor_write_room - port 1
>>drivers/usb/serial/visor.c: visor_close - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
>>drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk status received: -2
> 
> 
> Another open and close.
> 
> 
>>usb 3-2: USB disconnect, address 3
> 
> 
> Then the device disappears (they usually disconnect themselves.)
> 
> 
>>drivers/usb/serial/visor.c: visor_shutdown
>>visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
>>visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
>>visor 3-2:1.0: device disconnected
> 
> 
> It completes disconnection.
> 
> 
> 
>>usb 3-2: new full speed USB device using uhci_hcd and address 4
>>drivers/usb/serial/visor.c: visor_probe
>>drivers/usb/serial/visor.c: palm_os_4_probe
>>usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
>>00 67 00 00 00 00 00 00 01 01 00 00
>>visor 3-2:1.0: Handspring Visor / Palm OS converter detected
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
>>usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
> 
> 
> Did you press the button on it again?
> 
> I don't see anything odd here in the kernel log.  Have you tried asking
> this on the pilot-link mailing list?
> 
> thanks,
> 
> greg k-h
> 
> 
