Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSEZDEU>; Sat, 25 May 2002 23:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSEZDET>; Sat, 25 May 2002 23:04:19 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33623 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315593AbSEZDET>; Sat, 25 May 2002 23:04:19 -0400
Date: Sat, 25 May 2002 23:04:12 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205260304.g4Q34C301122@devserv.devel.redhat.com>
To: nahshon@actcom.co.il
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: USB Keyboard problem
In-Reply-To: <mailman.1022340633.6466.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> Just bought an "HP Multimedia Keyboard Hub" (USB).
> Using with RedHat 7.2, kernels 2.4.9-81 and also
> various 2.4.19-pre.

Yeah. I am having a hell of a time with HP keyboards, and
I would like very much if you can help.

With 7.3 we roll a pretty stock 2.4.19-pre (called 2.4.18-4.x),
so there is practically no difference in this area. You may
be better off looking at stock kernels because the problem
is not Red Hat specific.

>[...]
> After "rmmod hid" and "modprobe hid" The usb
> keyboard works just fine - until I disconnect/reconnect
> it or until the next reboot.

Yep. "rmmod hid && insmod hid" fixes it, and this is what
makes it hard to debug. However, your hint about the disconnect
is very important.

> The keyboard works with other OS, or with the bios
> (after I enabled "USB Legasy Support").

This is also needed for Linux: LILO or GRUB won't work unless
this is enabled. Kernel does not care, naturally...

> I'm also looking for programs o test the HID event
> interface (evtest) as suggested in the docs, It is not in
> the suggested web page.

It is linked from this bug:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55878
Here's the link:
 https://bugzilla.redhat.com/bugzilla/showattachment.cgi?attach_id=39264

Please make sure that Vojtech is in the loop. I do not really
follow the input and HID code (after months of trying :).

-- Pete
