Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRI0PE4>; Thu, 27 Sep 2001 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273230AbRI0PEq>; Thu, 27 Sep 2001 11:04:46 -0400
Received: from [129.15.104.123] ([129.15.104.123]:39172 "EHLO
	dogbert.cubicle.home") by vger.kernel.org with ESMTP
	id <S273204AbRI0PEk>; Thu, 27 Sep 2001 11:04:40 -0400
Message-ID: <3BB33EAD.9030107@tux.ou.edu>
Date: Thu, 27 Sep 2001 09:58:53 -0500
From: Robert Cantu <list@tux.cs.ou.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9.1) Gecko/20010610
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Question: Etherenet Link Detection
In-Reply-To: <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu> <3BB26D72.69E02ED0@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> Peter Sandstrom wrote:
> 
>>I know for sure that the Intel 82559 Fast Ethernet embedded controller
>>has a register where it's possible to read out if the link led is active
>>or not. It seems quite likely that this would be available on other
>>controllers as well.
>>
>>Is there any functionality in the current kernel that enables a userland
>>program to read this? I mostly turn my machines on and and let them do
>>their thing until the hardware fails :)
>>
>>/Peter
>>
> 
> You can get this information out of any NIC that supports
> the mii-diag protocols.  The two I've used are the eepro100
> and tulip drivers...
> 
> You can read Becker's mii-diag source for the gory details!
> 
> Ben
> 
> 

Thaniks, all who replied.

A little clarification on my project:

I'm going to try to build a userland app that manages several different 
network profiles and watches the ethernet port and notifies the user of 
a disconnect. If the user wishes, it will be configured to unload the 
network profile upon disconnect (to avoid long timeouts) and upon 
reconnction, reload that profile. A few simple subnet detection 
algorithms would try to intelligently load the correct profile. This is 
mainly a useful solution for mobile users who have to have different 
set-ups for networking. It looks like the mii-diag from Becker is going 
to work great (thanks, all who pointed me there), and is the last 
component I needed to get started. I may put the project up on 
sourceforge as my coding skills are new and weak. Thanks for the info.

As a side note, any chance such monitoring tools/interfaces might go 
into a later 2.4 or 2.5 kernel and be available in the /proc fs? That 
would be a much more elegant solution, from a user's standpoint. Again, 
thanks, all!

Cheers,
Robert Cantu
robert@tux.ou.edu

