Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDOUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDOUP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:15:56 -0400
Received: from misav02.sasknet.sk.ca ([142.165.20.163]:23308 "EHLO
	misav02.sasknet.sk.ca") by vger.kernel.org with ESMTP
	id S261179AbUDOUPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:15:53 -0400
Date: Thu, 15 Apr 2004 14:15:45 -0600
From: Dusty Phillips <dusty@buchuki.com>
Subject: Mouse button not recognized
To: linux-kernel@vger.kernel.org
Message-id: <407EED71.90604@buchuki.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040303)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.6.5 on Arch Linux distribution.  I think this
problem is kernel related as opposed to XFree86 related, but I am not
certain.  It may be related to the following bugs, but again, I am not
certain:

http://bugzilla.kernel.org/show_bug.cgi?id=1034
http://bugzilla.kernel.org/show_bug.cgi?id=2063
http://bugzilla.kernel.org/show_bug.cgi?id=2287
http://bugzilla.kernel.org/show_bug.cgi?id=1255

I have a Logitech Cordless Trackman; a four-button trackball. I've been
running it on PS/2, but recently switched to USB (it had a USB-to-PS/2
converter) to see if it resolved this problem.

The driver appears to be recognizing all button 4 clicks as button 2
clicks. I've checked this in xev using several protocols in XFree86, and
also noticed that the output when running cat </dev/input/mouse0 is the
same for both buttons.  I have not found any workaround.

I first noticed the problem when I tried kernel 2.6.0-test9. It was not
resolved when I tried 2.6.1, nor now on 2.6.5. It works fine for all
versions of kernel 2.4 that I have tried (several since about 2.4.19). I
understand that the pointer device handling has changed substantially in
2.6.

Bug 1255 hints at something called kvm and psmouse.proto options. This
sounds promising, but I'm not certain what is being referred to!

For additional information, I use the fourth button to enable the
"EmulateWheel" functionality provided by XFree86 4.3 +.  While holding
button 4 down, I can scroll by moving the trackball back and fourth.  I
can work around the issue by making button 2 my "EmulateWheelButton",
but this disables button 2 for other activities, such as pasting
selected text. With this configuration, both button 2 and button 4 have
the same behaviour (scrolling).

One of the bugs requested the contents of /proc/bus/input/devices. On my
system, the mouse-related information is:

I: Bus=0003 Vendor=046d Product=c501 Version=0910
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:11.2-1/input0
H: Handlers=mouse0
B: EV=2000f
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103
B: ABS=100 0
B: LED=fc00

I am not subscribed to the kernel mailing list, so please CC any
responses to me. I will subscribe if anybody thinks there is something
more I can do or information I can provide.

I was not certain whether to post this as a question, a new bug report,
or an addendum to one of the bugs mentioned. Please advise.

Thank you,
Dusty Phillips

