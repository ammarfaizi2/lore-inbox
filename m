Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbTLaXIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTLaXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:08:14 -0500
Received: from kiy.wanderer.org ([195.218.87.138]:15885 "EHLO kiy.wanderer.org")
	by vger.kernel.org with ESMTP id S265283AbTLaXIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:08:11 -0500
Message-ID: <3FF3436A.7050503@tv.debian.net>
Date: Wed, 31 Dec 2003 23:45:14 +0200
From: Tommi Virtanen <tv@tv.debian.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Love <rml@ximian.com>
Cc: Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>	 <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur>
In-Reply-To: <1072909218.11003.24.camel@fur>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love wrote:
>>One thing that I'm confused about with respect to device files is how
>>kernel arguments are supposed to work. Now, we _seem_ to have a
>>mish-mash of different ways to tell the kernel which device to open as
>>a console, which device to use as a suspend device, etc.... Now, all
>>of the device names are being migrated to userland. How is the kernel
>>supposed to determine which device to use when it is told use
>>/dev/hda3 or /dev/ide/host0/something/part3 as the suspend partition?
>>The kernel no longer knows to which device this string this device is
>>connected.
...

> The kernel uses the device number to understand what device user-space
> is trying to access.  The kernel associates the device with a device
> number.  Normally that number is static, and known a priori, so we just
> create a huge /dev directory with all possible devices and their
> assigned numbers (you can see these numbers with ls -la).

Let me try to rephrase Nathan's question more explicitly.

If user policy decides all naming, how does the kernel parse e.g. 
root=/dev/foo arguments? Or the swap partition to use for swsuspend?

