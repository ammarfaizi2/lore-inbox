Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266082AbRGDASv>; Tue, 3 Jul 2001 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266079AbRGDASd>; Tue, 3 Jul 2001 20:18:33 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:12292 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266074AbRGDASP>; Tue, 3 Jul 2001 20:18:15 -0400
Date: Tue, 3 Jul 2001 19:16:56 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010703191655.A1714@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com> <20010703171953.A16664@glitch.snoozer.net> <20010703174950.A593@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010703174950.A593@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Tue Jul 3 17:05:50 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the hopes that it might prove helpful, I reran coldsync after
loading usbserial.o and keyspan.o with the "debug=1" option.  Here's
what was logged:

----- <SNIP> -----
Jul  3 19:10:45 glitch kernel: usbserial.c: USB Serial support registered for Generic
Jul  3 19:10:45 glitch kernel: usb.c: registered new driver serial
Jul  3 19:10:45 glitch kernel: usbserial.c: none matched
Jul  3 19:10:45 glitch kernel: usbserial.c: v1.0.0 Greg Kroah-Hartman, greg@kroah.com, http://www.kroah.com/linux-usb/
Jul  3 19:10:45 glitch kernel: usbserial.c: USB Serial Driver
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA18X - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19 - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19W - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28 - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28X - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA49W - (without firmware)
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA18X
Jul  3 19:10:51 glitch kernel: usbserial.c: none matched
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19
Jul  3 19:10:51 glitch kernel: usbserial.c: descriptor matches
Jul  3 19:10:51 glitch kernel: usbserial.c: found bulk out
Jul  3 19:10:51 glitch last message repeated 2 times
Jul  3 19:10:51 glitch kernel: usbserial.c: found bulk in
Jul  3 19:10:51 glitch last message repeated 3 times
Jul  3 19:10:51 glitch kernel: usbserial.c: Keyspan USA19 converter detected
Jul  3 19:10:51 glitch kernel: usbserial.c: get_free_serial 1
Jul  3 19:10:51 glitch kernel: usbserial.c: get_free_serial - minor base = 0
Jul  3 19:10:51 glitch kernel: usbserial.c: usb_serial_probe - setting up 4 port structures for this device
Jul  3 19:10:51 glitch kernel: usbserial.c: Keyspan USA19 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19W
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28X
Jul  3 19:10:51 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA49W
Jul  3 19:10:51 glitch kernel: keyspan.c: v1.0.0 Hugh Blemings <hugh@linuxcare.com>
Jul  3 19:10:51 glitch kernel: keyspan.c: Keyspan USB to Serial Converter Driver
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_open
Jul  3 19:10:56 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5402
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_set_termios - port 0
Jul  3 19:10:56 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5402
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_set_termios - port 0
Jul  3 19:10:56 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 19:10:56 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:11:00 glitch kernel: usbserial.c: serial_write - port 0, 16 byte(s)
Jul  3 19:11:00 glitch kernel: usbserial.c: serial_write - port 0, 26 byte(s)
Jul  3 19:11:00 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:02 glitch kernel: usbserial.c: serial_write - port 0, 26 byte(s)
Jul  3 19:11:02 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_write - port 0, 26 byte(s)
Jul  3 19:11:04 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5402
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_set_termios - port 0
Jul  3 19:11:04 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_ioctl - port 0, cmd 0x5401
Jul  3 19:11:04 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:04 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:06 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:06 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:08 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:08 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:10 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:10 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:12 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:12 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:14 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:14 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:16 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:16 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:18 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:18 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:20 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:20 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:22 glitch kernel: usbserial.c: serial_write - port 0, 18 byte(s)
Jul  3 19:11:22 glitch kernel: usbserial.c: port_softint - port 0
Jul  3 19:11:24 glitch kernel: usbserial.c: serial_close - port 0
Jul  3 19:11:24 glitch kernel: keyspan.c: usa28_indat_callbacknonzero status: fffffffe on endpoint
Jul  3 19:11:24 glitch kernel: 1.
----- <SNIP> -----
