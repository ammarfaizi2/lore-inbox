Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWGHPtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWGHPtB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWGHPtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:49:01 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:64208 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S964861AbWGHPtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:49:00 -0400
Message-ID: <44AFD3E9.8050209@bootc.net>
Date: Sat, 08 Jul 2006 16:48:57 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, soekris-tech@lists.soekris.com
Subject: Re: [Soekris] [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net> <44AFCADA.6050805@gmail.com>
In-Reply-To: <44AFCADA.6050805@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
> Chris Boot wrote:
>> Hi all,
>>
>> After many years using Linux and hanging about on LKML without having 
>> done much actual kernel hacking, I've decided to have a go! The module 
>> below adds LED Class device support for the Soekris net48xx Error LED. 
>> Tested only on a net4801, but should work on a net4826 as well. I'd 
>> love to find a way of detecting a Soekris net48xx device but there is 
>> no DMI or any Soekris-specific PCI devices.
>>
>> The patch is attached because Thunderbird kills tabs.
>>
> FWIW, the vintage scx200_gpio driver manipulates the LED just fine.
> 
> # cat /etc/modprobe.d/gpio
> # assign last 2 dynamic devnums to gpio (255..240)
> options scx200_gpio major=240
> options pc8736x_gpio major=241
> 
> soekris:~# ll /dev/led
> crw-r--r-- 1 root root 240, 20 Jun 24  2005 /dev/led
> 
> echo 1 > /dev/led
> 
> 
> Is this insufficient ?

It works indeed very well, and this driver actually uses the scx200_gpio module 
to do its work. But no it isn't enough, since this code ties into the existing 
LED framework and can do nice built-in functionality like blinking according to 
a timer, IDE disk activity, and a heatbeat-style load indicator. For free.

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
