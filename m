Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287593AbRLaSTd>; Mon, 31 Dec 2001 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287584AbRLaSTO>; Mon, 31 Dec 2001 13:19:14 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:2011 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S287592AbRLaSTG>;
	Mon, 31 Dec 2001 13:19:06 -0500
Message-ID: <3C30AC0D.9010700@candelatech.com>
Date: Mon, 31 Dec 2001 11:18:53 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Ryan C. Bonham" <Ryan@srfarms.com>
CC: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Tyan Tomcat i815T(S2080) LAN problems
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A1251C7@FILESERVER.SRF.srfarms.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ryan C. Bonham wrote:

> Hi,
> 
> Well my first problem, once I got my brain working, was to realize that eth1 was DOA.. so as soon as I get a replacement board, I will try again.. Using the e100 driver, how did you force setting the MAC address?? 
> 
> Ryan


Make sure you enable the second port in the BIOS, btw.

I forget the exact syntax (I do it in c++ code, not with ifconfig or ip), but
both ifconfig and ip programs can set the mac address.  Try
/sbin/ip link help

That should point you in the right direction...  Note that MAC == Hardware-Address

Ben


> 
> 
>>-----Original Message-----
>>From: Ben Greear [mailto:greearb@candelatech.com]
>>Sent: Sunday, December 30, 2001 10:31 PM
>>To: Ryan C. Bonham
>>Cc: Linux Kernel List (E-mail)
>>Subject: Re: Tyan Tomcat i815T(S2080) LAN problems
>>
>>
>>I sort of got it working by using the e100 driver from Intel, and then
>>forcefully setting the MAC address to something other than 0xFF...FF
>>
>>Neither Becker, I, nor someone at Intel could figure out why
>>the MAC (EEPROM) was all FFs.  The best guess was that the BIOS
>>was screwed up somehow (that's what the Intel guy said...)
>>
>>I'd be interested if you get it working...I have two of these marginal
>>boards gathering dust!!
>>
>>Ben
>>
>>Ryan C. Bonham wrote:
>>
>>
>>>Hi,
>>>
>>>I installed kernel 2.4.17 and this problem still exists. I 
>>>
>>have attached the important stuff from demesg and from eepro100-diag. 
>>
>>>
>>>>Has anyone gotten the Dual built-in LAN cards to work on the 
>>>>Tyan S2080 Motherboard?  I am running a Redhat kernel 
>>>>2.4.9-13.. I haven't tried the latest kernel yet.. I saw some 
>>>>talk about this board in the archives but I found no 
>>>>solutions. It says it has a Intel 82559 LAN controller and a 
>>>>ICH2 LAN Controller. I am only seeing one NIC when I boot up. 
>>>>And dmesg is showing
>>>>eth0: Invalid EEPROM checksum 0xFF00, check setting before 
>>>>activating this device!
>>>>
>>>>
>>>>
>>>Thanks,
>>>
>>>
>>>eepro100.c:v1.09j-t 9/29/99 Donald Becker 
>>>
>>http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
>>
>>>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey 
>>>
>>V. Savochkin <saw@saw.sw.com.sg> and others
>>
>>>PCI: Found IRQ 11 for device 01:08.0
>>>eth0: Invalid EEPROM checksum 0xff00, check settings before 
>>>
>>activating this device!
>>
>>>eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.
>>>  Board assembly ffffff-255, Physical connectors present: 
>>>
>>RJ45 BNC AUI MII
>>
>>>  Primary interface chip unknown-15 PHY #31.
>>>    Secondary interface chip i82555.
>>>  General self-test: passed.
>>>  Serial sub-system self-test: passed.
>>>  Internal registers self-test: passed.
>>>  ROM checksum self-test: passed (0x04f4518b).
>>>
>>>----------------------------------  eerpro100-diag -aaeef
>>>
>>>eepro100-diag.c:v2.06 12/10/2001 Donald Becker (becker@scyld.com)
>>> http://www.scyld.com/diag/index.html
>>>Index #1: Found a Intel i82562 Pro/100 V adapter at 0xc800.
>>>i82557 chip registers at 0xc800:
>>>  0c000050 07036000 00000000 00080002 3fe1ffff 00000600
>>>  No interrupt sources are pending.
>>>   The transmit unit state is 'Suspended'.
>>>   The receive unit state is 'Ready'.
>>>  This status is normal for an activated but idle interface.
>>> The Command register has an unprocessed command 0c00(?!).
>>>EEPROM contents, size 256x16:
>>>    00: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x08: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x10: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x18: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x20: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x28: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x30: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x38: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x40: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x48: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x50: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x58: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x60: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x68: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x70: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x78: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x80: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x88: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x90: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0x98: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xa0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xa8: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xb0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xb8: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xc0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xc8: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xd0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xd8: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xe0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xe8: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xf0: ffff ffff ffff ffff ffff ffff ffff ffff
>>>  0xf8: ffff ffff ffff ffff ffff ffff ffff ffff
>>> *****  The EEPROM checksum is INCORRECT!  *****
>>>  The checksum is 0xFF00, it should be 0xBABA!
>>>Intel EtherExpress Pro 10/100 EEPROM contents:
>>>  Station address FF:FF:FF:FF:FF:FF.
>>>  Board assembly ffffff-255, Physical connectors present: 
>>>
>>RJ45 BNC AUI MII
>>
>>>  Primary interface chip i82555 PHY #-1.
>>>    Secondary interface chip i82555, PHY -1.
>>>   Sleep mode is enabled.  This is not recommended.
>>>   Under high load the card may not respond to
>>>   PCI requests, and thus cause a master abort.
>>>   To clear sleep mode use the '-G 0 -w -w -f' options..
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe 
>>>
>>linux-kernel" in
>>
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>>
>>
>>-- 
>>Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
>>President of Candela Technologies Inc      http://www.candelatech.com
>>ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>>
>>
>>
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


