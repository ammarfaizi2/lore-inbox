Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVABG25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVABG25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 01:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVABG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 01:28:57 -0500
Received: from mx.freeshell.org ([192.94.73.21]:50385 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261209AbVABG2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 01:28:52 -0500
Date: Sun, 2 Jan 2005 06:28:06 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501011631.36884.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501020622080.16181@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501011631.36884.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2005, Dmitry Torokhov wrote:

> What does /proc/bus/input/devices show? Do you have Synaptics touchpad/
> driver in your box?

Dmitry,

I do not have a Synaptics touchpad on this computer nor do I have the 
driver installed (though all I know is 'grep SYN .config' returned 
empty, so I may be mistaken).  Does the Synaptics driver mess with the 
keyboard at all?


Regarding /proc/bus/input/devices, listing (a) is from 2.6.7 and (b) is 
from 2.6.10.  Note that the mouse and keyboard have switched devices 
(event0 and event1) between kernel versions.  Does this affect it at all 
maybe? BTW, I do have a USB Wacom tablet attached.  Interestingly, 2.6.7 
does not seem to list it in /proc/bus/input/devices.



Thanks!
Roey


listing (a):

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Logitech Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0003 Vendor=046d Product=c50e Version=2500
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:10.1-2/input0
H: Handlers=mouse1 event2
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

listing (b):

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Logitech Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0003 Vendor=046d Product=c50e Version=2500
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:10.1-2/input0
H: Handlers=mouse1 event2
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0003 Vendor=056a Product=0022 Version=0101
N: Name="Tablet GD-0912-U"
P: Phys=usb-0000:00:10.3-2/input0
H: Handlers=mouse2 event3
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103
