Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSLCX5p>; Tue, 3 Dec 2002 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSLCX5o>; Tue, 3 Dec 2002 18:57:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40717 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266721AbSLCX5m>;
	Tue, 3 Dec 2002 18:57:42 -0500
Message-ID: <3DED4698.60209@pobox.com>
Date: Tue, 03 Dec 2002 19:04:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 gets duplex wrong on NIC
References: <Pine.LNX.4.44.0212031818310.1176-200000@oddball.prodigy.com>
In-Reply-To: <Pine.LNX.4.44.0212031818310.1176-200000@oddball.prodigy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> In spite of modules.conf the system boots with the NIC in half duplex. I 
> verified this with the mii-tool, I can set it full with mii-tool and it 
> works right (copied a CD image 650MB), and the blade in the switch has 
> been set either full or auto without gain. Yes, I tried the e100 driver as 
> well.
> 
> Info I think shows this attached to prevent munging, let me know if more 
> is needed.


Lots of feedback/questions/response:

When you're on a network, more is always needed :)

Please give _plenty_ of details about what is on the other side of the 
cable: hub? switch? vendor of hub/switch?  crossover to another NIC? 
what is the port configuration and what are the capabilities of the 
other end?  is it set to autonegotiate (on the other end)?

Why do you force full duplex?  It is often the wrong thing to do.

For eepro100, you should use module option 'options' to specify 
10baseT-FD... full_duplex appears to be somewhat redundant in the 
context of your problem.

For e100, you should use 'e100_speed_duplex' module option to specify media.

Finally, I would be very interested to know the results of using ethtool 
to set, and get, your media settings.  It's in every distro these days, 
plus you can d/l it from http://sf.net/projects/gkernel/

	Jeff



