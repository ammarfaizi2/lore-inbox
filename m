Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758007AbWKZWH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007AbWKZWH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758006AbWKZWH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:07:26 -0500
Received: from relay.rinet.ru ([195.54.192.35]:42947 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1758005AbWKZWHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:07:25 -0500
Message-ID: <456A0FF8.2010208@mail.ru>
Date: Mon, 27 Nov 2006 01:06:48 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
       linux-kernel@vger.kernel.org
Subject: Re: NTP time sync
References: <00b301c711a3$07cf3530$020120ac@Jocke>
In-Reply-To: <00b301c711a3$07cf3530$020120ac@Jocke>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Mon, 27 Nov 2006 01:07:11 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund wrote:
>>> Is that the way it is supposed to be? How do I create a 
>> static /dev/rtcN in my /dev
>>> directory if the major number isn't fixed?
>>> Maybe I am just missing something, feel free to correct me :)
>>  udev ;)
>>
>>  the concept of static numbers is quite old...
> 
> Yes it is old, but is the old way unsupported now? I have an embedded target
> which is using the old static /dev directory, do I need to make
> it udev aware to use newer features like the rtc subsystem?
Really you do not have to make it udev aware, it is enough to make it 
sysfs aware. You will be done by reading /sys/class/misc/rtc/dev on 
initialization and replacing /dev/rtcN with device with the address 
read. If you have configuration static enough, I guess you can even 
create it once and for life of current setup with current kernel.
