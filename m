Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTIYKek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbTIYKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:34:40 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:14053 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261861AbTIYKed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:34:33 -0400
Date: Thu, 25 Sep 2003 12:34:30 +0200 (CEST)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
X-X-Sender: donald@duck.sh.cvut.cz
To: linux-kernel@vger.kernel.org
Subject: Problems with USB/VISOR module
Message-ID: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks:

I got problems using the visor module and hotsyncing my PDA with Linux.

My configuration is probably correct, since everything worked just fine
until I bought a new motherboard - D865GBF by Intel (Intel Bayfield).
With the new board, I am not able to connect to the PDA.

PDA: Palm m515, USB craddle
PC: D865GBF board, Intel Celeron, 2GHz, 400MHz System Bus
Kernel: 2.4.22 and 2.4.21 tried (it worked with 2.4.21 formerly)
Software: pilot-link version 0.9.5.0-8 (Debian "testing" package)
(used to work with my previous CPU and board - some Intel based on i845)

Problem decription: the PDA is detected after pressing the HotSync button,
but the syncing process hangs just after opening the port. Nothing is read
or written.

I have already tried various USB configurations in BIOS ("slow/fast" etc).
I also tried switching APIC on and off.

Please do you have any ideas what can be wrong? Is anyone using visor
module with this particular board? I can assist you in running more tests
and sending more outputs if you needed that.


Please CC any replies to me. Thanks for any help...
   - M -


# lspci -v

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at e000 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at e400 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at ec00 [size=32]

# modprobe visor debug=1
# modprobe usb-uhci

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Handspring Visor / Treo / Palm 4.0 / Clié 4.x
usbserial.c: USB Serial support registered for Sony Clié 3.5
visor.c: USB HandSpring Visor, Palm m50x, Treo, Sony Clié driver v1.7
usb-uhci.c: $Revision: 1.275 $ time 01:14:46 Sep 24 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c7eac780, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7eac780
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF c7eac880, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7eac880
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF c7eac980, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7eac980
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Setting latency timer of device 00:1d.3 to 64
usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
usb.c: kmalloc IF c7eaca80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: ec00
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7eaca80
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver

# (press the HotSync button)

hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:1d.0-1, assigned address 2
usb.c: kmalloc IF c7eacb20, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=5
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Palm, Inc.
Product: Palm Handheld
SerialNumber: 00T0PBC2A512
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter detected
visor.c: visor_startup
visor.c: visor_startup - Set config to 1
visor.c: visor_startup - length = 20, data = 01 00 00 00 63 6e 79 73 02 00 00 00 00 51 00 09 00 03 27 00
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb.c: serial driver claimed interface c7eacb20
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s

# pilot-xfer -l

visor.c: visor_open - port 0
visor.c: visor_ioctl - port 0, cmd 0x5401
visor.c: visor_ioctl - port 0, cmd 0x5401
visor.c: visor_ioctl - port 0, cmd 0x5402
visor.c: visor_set_termios - port 0
visor.c: visor_set_termios - data bits = 8
visor.c: visor_set_termios - parity = none
visor.c: visor_set_termios - stop bits = 1
visor.c: visor_set_termios - RTS/CTS is disabled
visor.c: visor_set_termios - XON/XOFF is disabled
visor.c: visor_set_termios - baud rate = 9600
visor.c: visor_ioctl - port 0, cmd 0x5401
visor.c: visor_ioctl - port 0, cmd 0x5401
visor.c: visor_ioctl - port 0, cmd 0x5403
visor.c: visor_chars_in_buffer - port 0
visor.c: visor_chars_in_buffer - returns 0
visor.c: visor_set_termios - port 0
visor.c: visor_set_termios - nothing to change...
visor.c: visor_chars_in_buffer - port 0
visor.c: visor_chars_in_buffer - returns 0
visor.c: visor_write_room - port 0
visor.c: visor_write_room - returns 18432
visor.c: visor_chars_in_buffer - port 0
visor.c: visor_chars_in_buffer - returns 0
visor.c: visor_write_room - port 0
visor.c: visor_write_room - returns 18432
visor.c: visor_ioctl - port 0, cmd 0x5403
visor.c: visor_chars_in_buffer - port 0
visor.c: visor_chars_in_buffer - returns 0
visor.c: visor_set_termios - port 0
visor.c: visor_set_termios - data bits = 8
visor.c: visor_set_termios - parity = none
visor.c: visor_set_termios - stop bits = 1
visor.c: visor_set_termios - RTS/CTS is disabled
visor.c: visor_set_termios - XON/XOFF is disabled
visor.c: visor_set_termios - baud rate = 9600
visor.c: visor_close - port 0
usb-uhci.c: interrupt, status 2, frame# 774
visor.c: visor_read_bulk_callback - port 0
visor.c: visor_read_bulk_callback - nonzero read bulk status received: -2
visor.c: Bytes In = 0  Bytes Out = 0
