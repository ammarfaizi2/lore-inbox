Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUICM2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUICM2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUICM2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:28:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49094 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S269658AbUICM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:27:00 -0400
Date: Fri, 3 Sep 2004 08:26:58 -0400
From: Johann Koenig <explosive@hvc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Abit VP6: USB strangeness
Message-ID: <20040903082658.2d08bfb9@localhost.localdomain>
X-Mailer: Sylpheed-Claws 0.9.12cvs91 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bought an Abit VP6 recently, and have been fiddling around with it,
trying to make any number of things work. One that has been bothering me
for some time now is USB.

I use a MS Intellimouse Explorer USB, and thats pretty much it for what
I plug in there. I have used a APC BackUPS ES500 USB monitoring cable,
and a MS Sidewinder joystick. All of them have the following problem:

Using kernel 2.6.8.1 (2.6.7 did not let it get even this far), if I plug
the mouse in before starting Linux, all goes well. However, if I unplug
and replug the mouse from a running system, this shows up in dmesg:

usb 1-1: USB disconnect, address 2
usb 1-1: new low speed USB device using address 3
usb 1-1: device not accepting address 3, error -71
usb 1-1: new low speed USB device using address 4
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(T M)] on usb-0000:00:07.2-1
usb 1-1: USB disconnect, address 4
usb 1-1: new low speed USB device using address 5
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(T M)] on usb-0000:00:07.2-1

Notice the first time, it failed. Oddly, it worked after that. That
never happened before. In fact, I was unplugging it trying to make it
fail after I wrote most of this message, but then it worked. So I put
the message off to the side and added USB to my VMWare Virtual Machine,
which worked fine. Then a bit later, I was trying another virtual
machine and it failed on me:

usb 1-1: control timeout on ep0in
... Repeat 15x or so ...
usb 1-1: control timeout on ep0in
usb 1-1: USB disconnect, address 5
usb 1-1: new low speed USB device using address 6
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 6, error -110
usb 1-1: new low speed USB device using address 7
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 7, error -110
...
and so on, using progressively higher addresses.

Miscellaneous information I though might be useful is available at
http://mental-graffiti.com/kernel/usb/
.config, dmesg, lspci -vv, etc

Anything else needed, just ask.
Thanks
-- 
-johann koenig
Today is Setting Orange, the 26th day of Bureaucracy in the YOLD 3170
