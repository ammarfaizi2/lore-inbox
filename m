Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVI0FL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVI0FL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVI0FL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:11:57 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:38785
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S964811AbVI0FL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:11:57 -0400
Message-ID: <4338D48F.3090807@linuxwireless.org>
Date: Mon, 26 Sep 2005 23:11:43 -0600
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: Keenan Pepper <keenanpepper@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ipw2200 only works as a module?
References: <20050926171220.GA9341@dreamland.darkstar.lan>
In-Reply-To: <20050926171220.GA9341@dreamland.darkstar.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca wrote:

>Keenan Pepper <keenanpepper@gmail.com> ha scritto:
>  
>
>>With CONFIG_IPW2200=y I get:
>>
>>ipw2200: ipw-2.2-boot.fw load failed: Reason -2
>>ipw2200: Unable to load firmware: 0xFFFFFFFE
>>
>>but with CONFIG_IPW2200=m it works fine. If it doesn't work when built into the 
>>kernel, why even give people the option?
>>
>>BTW, a better error message than "Reason -2" would be nice. =)
>>    
>>
>
>-2 is -ENOENT (no such file or directory). ipw2000 requests its firmware
>using a hotplug event, but when the driver is compiled into the kernel
>it gets loaded _before_ the root fs is mounted and of course the hotplug
>system and the firmware are not available.
>
>I suggest to stick with modular driver, otherwise you must create an
>initrd with hotplug + firmware.
>  
>

I think I have seen this but in FC3 or FC4. We have had issues with them 
loading things too soon and then making the driver to fail loading.

Try it with * built in and then once booted to load it. If it works, 
then is a distro thing.  It works for me here in Debian  with Y or as a 
module.

.Alejandro

>More on firmware loading here: http://lwn.net/Articles/32997/
>
>Luca
>  
>

