Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935747AbWK1HOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935747AbWK1HOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935749AbWK1HOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 02:14:51 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:32936 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S935747AbWK1HOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 02:14:51 -0500
Message-ID: <456BE2A8.7080103@sandall.us>
Date: Mon, 27 Nov 2006 23:18:00 -0800
From: Eric Sandall <eric@sandall.us>
Organization: Source Mage GNU/Linux
User-Agent: Mail/News 1.5.0.8 (X11/20061121)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: suspend broken in 2.6.18.1
References: <45144C61.5020104@sandall.us> <20060923110954.GD20778@elf.ucw.cz> <453406F0.5020803@sandall.us> <20061127113501.GC14416@elf.ucw.cz>
In-Reply-To: <20061127113501.GC14416@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Mon 2006-10-16 15:25:52, Eric Sandall wrote:
>> Pavel Machek wrote:
>>> Hi!
>>>
>>>> After updating from 2.6.17.13 to 2.6.18 (using `make oldconfig`),
>>>> suspend no longer suspends my laptop (Dell Inspiron 5100).
>>>>
>>>> # s2ram -f
>>>> Switching from vt7 to vt1
>>>> s2ram_do: Invalid argument
>>>> switching back to vt7
>>>>
>>>> The screen blanks, but then comes back up after a few seconds. This
>>>> happens both with and without X running.
>>>>
>>>> I've attached the output of `lspci -vvv` and my
>>>> /usr/src/linux-2.6.18/.config for more information. Please let me know
>>>> if there are any patches to try or if more information is required.
>>> Relevant part of dmesg after failed attempt is neccessary... and you
>>> can probably read it yourself and figure what is wrong. I'd guess some
>>> device just failed to suspend... rmmod it.
>> (This is now with 2.6.18.1)
>>
>> Stopping tasks: =====================================================|
>> ACPI: PCI interrupt for device 0000:02:04.0 disabled
>> ACPI: PCI interrupt for device 0000:00:1f.5 disabled
>> ACPI: PCI interrupt for device 0000:00:1d.7 disabled
>> ACPI: PCI interrupt for device 0000:00:1d.2 disabled
>> ACPI: PCI interrupt for device 0000:00:1d.1 disabled
>> ACPI: PCI interrupt for device 0000:00:1d.0 disabled
>> Class driver suspend failed for cpu0
>> Could not power down device firmware: error -22
>> Some devices failed to power down
>>
>> I've attached my entire dmesg as well.
> Try with 2.6.19-rcX.

s2ram is also working with 2.6.19-rc6, thank you. :)

-sandalle

-- 
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
