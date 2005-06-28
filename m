Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVF1GaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVF1GaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVF1G2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:28:49 -0400
Received: from outmx027.isp.belgacom.be ([195.238.2.208]:40347 "EHLO
	outmx027.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261529AbVF1GEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:04:49 -0400
Message-ID: <42C0E879.5010605@skynet.be>
Date: Tue, 28 Jun 2005 08:04:41 +0200
From: Eric FAURE <eric.faure@skynet.be>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: eric.faure@skynet.be
Subject: tungsten t5 doesn't sync anymore with kernel 2.6.12
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
First, I tried to googled but I didn't find any answer!

CPU : athlon64 3500+
MB : k8t800pro (uhci and ehci)
FC 3

since I have installed kernel 2.6.12, my tungsten t5 doesn't sync anymore.
I push the sync button as usual, and after use jpilot or pilot-xfer
but I have an error from jpilot (pi_bind Invalid argument
Check your serial port and settings Exiting with status SYNC_ERROR_BIND)

and pilot-xfer : Error accessing: '/dev/pilot', Does '/dev/pilot' exist?

there is no special error messages,
dmesg output :

usb 3-2: new full speed USB device using uhci_hcd and address 5
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usb 3-2: USB disconnect, address 5
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 6
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usb 3-2: USB disconnect, address 6
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 7
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1

it looks ok. output of kernel 2.6.11.12 is mostly the same


I tried loading the visor driver with debug=1
and here, the messages are differents from the kernel 2.6.11.12
dmesg kernel 2.6.12 output :

usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony 
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: device descriptor read/64, error -71
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
usb 3-2: USB disconnect, address 2
drivers/usb/serial/visor.c: visor_shutdown
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 3
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 63 6e 79 73 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - data bits = 8
drivers/usb/serial/visor.c: visor_set_termios - parity = none
drivers/usb/serial/visor.c: visor_set_termios - stop bits = 1
drivers/usb/serial/visor.c: visor_set_termios - RTS/CTS is disabled
drivers/usb/serial/visor.c: visor_set_termios - XON/XOFF is disabled
drivers/usb/serial/visor.c: visor_set_termios - baud rate = 9600
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
visor ttyUSB1: visor_read_bulk_callback - length = 6, data = 01 ff 00 00 
00 16
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_close - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk 
status received: -2
usb 3-2: USB disconnect, address 3
drivers/usb/serial/visor.c: visor_shutdown
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected 
from ttyUSB1
visor 3-2:1.0: device disconnected
usb 3-2: new full speed USB device using uhci_hcd and address 4
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - length = 20, data = 01 01 00 00 4c 73 66 72 
00 67 00 00 00 00 00 00 01 01 00 00
visor 3-2:1.0: Handspring Visor / Palm OS converter detected
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1

something looks strange here,
let me know, if you need more infos.

Can you reply to me, because I'm not suscribed
Thanks in advance.
Eric
