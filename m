Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285965AbSAEADk>; Fri, 4 Jan 2002 19:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285972AbSAEAD3>; Fri, 4 Jan 2002 19:03:29 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:62738 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S285965AbSAEADX>; Fri, 4 Jan 2002 19:03:23 -0500
Message-ID: <3C3642DB.5020005@gmx.net>
Date: Sat, 05 Jan 2002 01:03:39 +0100
From: Michael Klose <mkmail@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 kernel freeze / ISDN
In-Reply-To: <3C35DDFC.50700@gmx.net> <3C35E359.4000004@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> The problem is probably the eepro connected to the 10bt device.  10bt
> seems to lock things up much more often than a 100bt network connection.


What I think is happenening is when data is being generated and sent to 
the NIC faster than the NIC can handle. Since this is the case much 
easier with 10 MBit than 100MBit it locks up much more.

But not in my case.

The eepro100 which is directly connected to the DSL modem (10 MBut link) 
is running a maximum speed of 768kbit inwards (from Modem to Kernel) and 
128kbut outwards, which even for 10MBit is absolutely nothing. There is 
no other traffic on that link.

But the LAN side, connected to the switch (100 MBit) runs fine as long 
as the server is serving Mp3s or something or is just using the internet 
(low traffic). But as soon as you copy a few hundred megabytes in one go 
from another 100 MBit machine in the network to the linux server in one 
go  and which would normally only take a few seconds (mainly from my 
laptop via SMB as I am trying to free up the disk) the kernel goes 
Kaboom at once. Big kababoom, borrowing the expression from the 5th Element.
If I wanted the kernel to crash now, all I would have to do is copy for 
example a CD Image to the SMB share on the linux server. It happens 
every time.
Like I said, 2.4.15pre5 requires half a handful of gigabytes at once to 
make this happen. 2.4.17 looks up after half a handful of 100 megabytes 
(say half way through a cd image).


> Unfortunately, the only work-around I found for this problem so far
> is to change the hardware to a non intel NIC, or to use the e100 module
> 
>> from Intel...


I found tht out last night. Thanks. I hven't tried it yet, but I will 
tomorrow. I have just downloaded the source from intel. The source I 
downloaded from intel says it may work with "older" eepro100 models 
(which I have) but they don't guarantee it.

If I don't get it to work by monday, I have arranged a swap against some 
3Com cards.

I hope you don't mind me ccing this back to the lkml as that is where 
you picked up my mail to reply in the first place. By the way, I am not 
subscribed, but do read it regularly via nntp or via the archives for 
the week, so I can be reached over the list.





