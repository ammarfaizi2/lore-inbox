Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUGZG6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUGZG6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 02:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUGZG6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 02:58:38 -0400
Received: from zasran.com ([198.144.206.234]:21948 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S264936AbUGZG6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 02:58:37 -0400
Message-ID: <4104AB98.8070506@bigfoot.com>
Date: Sun, 25 Jul 2004 23:58:32 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040722 Debian/1.7.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <410450CA.9080708@hispalinux.es> <pan.2004.07.26.05.35.49.669188@dungeon.inka.de>
In-Reply-To: <pan.2004.07.26.05.35.49.669188@dungeon.inka.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus wrote:
> On Mon, 26 Jul 2004 00:34:51 +0000, Ramón Rey Vicente wrote:
> 
>>With udev you can do that, and without important bugs :). And the more
>>important thing is _udev is in active development_
> 
> 
> devfs has the "open /dev/somefile" to load $somedriver
> mechanism. it is said to be racy, as far as I know.
> 
> udev works very differently. mostly, the idea is kernel detects hardware,
> kernel calls hotplug, hotplug loads driver, driver registers device
> structure in kernel, kernel calls hotplug for the new device, udev creates
> the device in /dev.
> 
> with this mechanism, the kernel always has all drivers for hardware
> currently available loaded, and udev provides the /dev devices.
> 
> devfs allowes you to not have the driver loaded till you try to use it.
> so udev _cannot_ do what devfs does.
> 
> still I agree that the way kernel/hotplug/udev work is much better and
> supporting the old style devfs works is not necessary. but please be
> honest about the differences.

   which means that now iPod automatically connects to firewire (and 
looses info on random tracks, sometime some other settings), instead of 
only connecting when I try to actually access it (the device).

   it looks like there is no user level (end user, not admin) control on 
when the device drivers are loaded anymore - or is there?

   Is there any way to load drivers on demand (obviously it's not job of 
udev but whose job it is?). What about unloading them - I unmount the 
disk and i think the iPod is disconnecred but it still says connected - 
is there any way to disconnect it (I guess similar problems arise with 
other hotplug devices)

	erik
