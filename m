Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTD1Shg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTD1Shg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:37:36 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:32764 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261236AbTD1She (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:37:34 -0400
Message-Id: <5.1.0.14.2.20030428114706.10382f08@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 28 Apr 2003 11:49:42 -0700
To: Greg KH <greg@kroah.com>, Ricardo Galli <gallir@uib.es>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: BUG: 2.5.68 uhci: host controlled halted and then kills
  the kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030427043521.GA4330@kroah.com>
References: <200304252314.13085.gallir@uib.es>
 <200304252314.13085.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:35 PM 4/26/2003, Greg KH wrote:
>On Fri, Apr 25, 2003 at 11:14:13PM +0200, Ricardo Galli wrote:
>> Sorry, again me :-(
>> 
>> Playing aroung with the mouse, I've got the following error:
>> 
>> usb 1-1: USB disconnect, address 2
>> drivers/usb/host/uhci-hcd.c: 8800: host controller halted. very bad
>>                                                            ^^^^^^^^
>
>Do you get this error when running 2.4.21-rc1 when using the uhci.o
>driver?
btw I get that error too with Bluetooth device on my Compaq laptop. 
2.4.21-rc1 works fine.

>> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
>> ...
>> 
>> 
>> The USB didn't wok anymore, then I stopped hotplug and the system died 
>> just after the message "Stopping hotplug subsystem" appeared in the 
>> konsole.
>
>That's because there's a nasty bug you hit when unloading the usb host
>controller driver.
So you guys know about it. I was going sent a note on usb list.
'modprobe -r uhci-hcd' totally kills the machine.

Max


