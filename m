Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVLEKLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVLEKLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLEKLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:11:51 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:2456 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751363AbVLEKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:11:51 -0500
Message-ID: <1133777490.4394125279c20@www.domainfactory-webmail.de>
Date: Mon, 05 Dec 2005 11:11:30 +0100
From: Clemens Ladisch <clemens@ladisch.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc4 RTC problems
References: <1133481374.21429.66.camel@localhost.localdomain>
In-Reply-To: <1133481374.21429.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> I am having troubles booting my 8-way P-III machine.
> On boot it hangs in init script boot.clock.
> It prints,
>
> "Setting up the CMOS clock"
>
> and hangs. So I disabled that script and brought up
> the machine and ran command manually. It looks like
> it waits forever to read from /dev/rtc.
>
> # strace /sbin/hwclock --adjust -u
> ....
> open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = 3
> ioctl(3, RTC_UIE_ON, 0)                 = 0
> read(3, <unfinished ...>

Are you using HPET? (see dmesg)
Do some interrupts arrive? (see /proc/interrupts)


Regards,
Clemens

