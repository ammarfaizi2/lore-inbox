Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266047AbRGCWvW>; Tue, 3 Jul 2001 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGCWvD>; Tue, 3 Jul 2001 18:51:03 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:27148 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266045AbRGCWuy>; Tue, 3 Jul 2001 18:50:54 -0400
Date: Tue, 3 Jul 2001 17:49:50 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010703174950.A593@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com> <20010703171953.A16664@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010703171953.A16664@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Tue Jul 3 17:05:50 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After adding CONFIG_USB_SERIAL_GENERIC I wasn't able to hang the module
while initializing (I only made three tries, tho), but the driver
didn't seem to work either.


root@glitch[~]# modprobe keyspan debug=1

adric@glitch[~]$ coldsync -v -ms
Please press the HotSync button.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend. 
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
ACK Timeout. Attempting to resend.
Error: Can't get system info.
Error: Lost connection to Palm.

root@glitch[~]# tail -n 28 /var/log/kern.log
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Generic
Jul  3 17:32:18 glitch kernel: usb.c: registered new driver serial
Jul  3 17:32:18 glitch kernel: usbserial.c: v1.0.0 Greg Kroah-Hartman, greg@kroah.com, http://www.kroah.com/linux-usb/
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial Driver
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA18X - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19 - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19W - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28 - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28X - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA49W - (without firmware)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA18X
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19
Jul  3 17:32:18 glitch kernel: usbserial.c: Keyspan USA19 converter detected
Jul  3 17:32:18 glitch kernel: usbserial.c: Keyspan USA19 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA19W
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA28X
Jul  3 17:32:18 glitch kernel: usbserial.c: USB Serial support registered for Keyspan USA49W
Jul  3 17:32:18 glitch kernel: keyspan.c: v1.0.0 Hugh Blemings <hugh@linuxcare.com>
Jul  3 17:32:18 glitch kernel: keyspan.c: Keyspan USB to Serial Converter Driver
Jul  3 17:32:21 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 17:32:21 glitch kernel: keyspan.c: keyspan_usa28_send_setup already writing
Jul  3 17:32:21 glitch kernel: keyspan.c: keyspan_usa28_send_setup already writing
Jul  3 17:32:21 glitch kernel: keyspan.c: usa28_outcont_callback sending setup
Jul  3 17:32:21 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 17:32:28 glitch kernel: keyspan.c: keyspan_usa19_calc_baud 9600 ff b2.
Jul  3 17:32:48 glitch kernel: keyspan.c: usa28_indat_callbacknonzero status: fffffffe on endpoint
Jul  3 17:32:48 glitch kernel: 1.


On Tue, Jul 03, 2001 at 05:19:53PM -0500, Gregory T. Norris wrote:
> I'm pretty sure that I've hit this with CONFIG_USB_SERIAL_GENERIC set. 
> I'll retry it, just to be sure.
> 
> On Tue, Jul 03, 2001 at 10:38:00AM -0700, Greg KH wrote:
> > On Sat, Jun 30, 2001 at 12:33:23AM -0500, Gregory T. Norris wrote:
> > > CONFIG_USB_SERIAL=m
> > > # CONFIG_USB_SERIAL_GENERIC is not set
> > 
> > Can you enable CONFIG_USB_SERIAL_GENERIC and let me know if that fixes
> > the problem?
> > 
> > thanks,
> > 
> > greg k-h
