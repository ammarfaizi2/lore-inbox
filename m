Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbVG3UNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVG3UNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbVG3ULr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:11:47 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:48058 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S263158AbVG3UJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:09:44 -0400
Message-ID: <42EBDEA9.60505@schau.com>
Date: Sat, 30 Jul 2005 22:10:17 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz>
In-Reply-To: <20050730194215.GA9188@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Hehe - the WSLs are already reality.  Sitecom is a producer of
these and you can get another brand from ThinkGeek.

Sitecom device:
http://www.sitecom.com/products_info.php?product_id=293&grp_id=1

ThinkGeek:
http://www.thinkgeek.com/gadgets/security/698d/

Why in kernel?   Well, the device is based on the Cypress Ultra
Mouse.  So with a non WSL aware kernel the events from the WSL
will be merged into the standard mouse input queue which will
make your mouse pointer move uncontrollable - it'll jump across
the screen in a couple of steps every 3 seconds or so.
Quite amusing but not very handy!
The problem is described here:

http://www.qbik.ch/usb/devices/showdev.php?id=3095

The WSL kernel driver will translate the device packets to a
separate event queue.

And you're right.  The WSL driver is not a standalone thingy -
you'll some userland tools as well.  These can be gotten from:

http://www.schau.com/l/wsl/index.html

The tools contains a patch for xscreensaver (patch submitted to
maintainer) and a small WSL monitor program which will monitor
in-range/out-of-range signals and disable/enable xscreensaver
as needed.

/brian



Pavel Machek wrote:
> Hi!
> 
> 
>>I've attached a gzipped version of my Wireless Security Lock patch
>>for v2.6.13-rc4.
>>A Wireless Security Lock (WSL or weasel :-) is made up of two parts.
>>One part is a receiver which you plug into any available USB port.
>>The other part is a transmitter which at fixed intervals sends
>>"ping packets".
>>A "ping packet" usually consists of an ID and a flag telling if the
>>transmitter has just been turned on.
> 
> 
> Idea is good... but why don't you simply use bluetooth (built into
> many notebooks) and bluetooth-enabled phone?
> 
> Probably could be done in userspace, too :-).
> 								Pavel
> 
