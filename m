Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbRGCAjc>; Mon, 2 Jul 2001 20:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265550AbRGCAjW>; Mon, 2 Jul 2001 20:39:22 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:20499 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265517AbRGCAjG>; Mon, 2 Jul 2001 20:39:06 -0400
Date: Mon, 2 Jul 2001 19:38:53 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702193853.B1451@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010701154910.A15335@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's something interesting...

Twice today while I was playing with usbserial/keyspan I got the
following:

     root@glitch[~]# modprobe keyspan
     usbserial.c: ezusb_set_reset_Re254f24d- 1 failed
     keyspan.c: ezusb_writememory failed for Keyspanfirmware (-110 0000 e0b4518d 3)
     usbserial.c: ezusb_set_reset_Re254f24d- 0 failed

Afterwards, not only did the keyspan driver still work, but it was
*much* faster than before.  I was able to perform a full sync with the
Palm in about 15-20 seconds, while it was taking about two minutes
before.

Weird!

