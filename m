Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVBODzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVBODzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVBODzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:55:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:29627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbVBODzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:55:44 -0500
Message-ID: <42117047.6020209@osdl.org>
Date: Mon, 14 Feb 2005 19:45:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Aur=E9lien_G=C9R=D4ME?= <ag@roxor.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: RTC Inappropriate ioctl for device
References: <20050213214145.GN12421@roxor.cx>
In-Reply-To: <20050213214145.GN12421@roxor.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurélien GÉRÔME wrote:
> Hi,
> 
> Having CONFIG_RTC=y, I tried on x86 the rtctest program found in
> linux-2.6.10/Documentation/rtc.txt. However, it failed at:
> 
> ioctl(fd, RTC_UIE_ON, 0);
> 
> with:
> 
> ioctl: Inappropriate ioctl for device
> 
> Did I miss something? Maybe something else conflicts with CONFIG_RTC?
> 
> Cheers.

Do you have an HPET timer enabled?  That could cause a conflict.

Does /proc/interrupts report rtc interrupts increasing when you
run rtctest?
I.e., does the number of this line increase like this?

   8:        131    IO-APIC-edge  rtc

rtctest works for me (2.6.11-rc4).  Maybe send me the strace
output when you run rtctest and your .config file.
Oh, and your kernel boot log, maybe there are some rtc driver
messages in it.

-- 
~Randy
