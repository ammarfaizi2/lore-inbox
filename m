Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbTICOif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTICOif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:38:35 -0400
Received: from smtp.terra.es ([213.4.129.129]:38079 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S262147AbTICOiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:38:09 -0400
Message-ID: <3F55FC69.7050404@terra.es>
Date: Wed, 03 Sep 2003 16:36:25 +0200
From: tonildg <tonildg@terra.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030830 Debian/1.4-3.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Willemoes Hansen <mwh@sysrq.dk>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
References: <1062498150.356.9.camel@spiril.sysrq.dk>	 <20030902113610.D29984@flint.arm.linux.org.uk>	 <1062500366.642.11.camel@hugoboss.sysrq.dk>  <3F555B68.2010408@terra.es> <1062591834.8758.18.camel@hugoboss.sysrq.dk>
In-Reply-To: <1062591834.8758.18.camel@hugoboss.sysrq.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, read below...

> On Wed, 2003-09-03 at 05:09, tonildg wrote:
> 
>> >The error message:
>> >cardmgr[19]: starting, version is 3.2.4
>> >cs: memory probe 0x0c0000-0x0ffff: excluding >0xc0000-0xcbfff
>>
>>  I had the same problem you have (but in other range of memory and with 
>>another wireless card) and it started too with 2.4.19. 
>>
>> I solved it testing with memory ranges in the config.opts file that 
>>comes with your pcmcia_cs version.
>>
>>   You have to play with them until one fits and boots. "I had to use 
>>windows to see the memory adresses my cardbus used." 
> 
> 
< Umh can I check it out on Linux as well? And how? I can boot correctly
> with 2.4.19.

  I had to look to the windows cardbus device properties to get it work, 
but i think that by playing with some values you can get it working too 
without needing that crappy OS.

   My  Excuse: The reason i looked into windows whas that i was setting 
up  a laptop whith the host_ap module support and i needed it working 
for giving a wireless talk and  had no time to play. :-)

> 
>>Usually, when 
>>comenting the "include memory 0xc0000-0xfffff" solves it.
> 
> 
> Yes when I comment that include out I can boot but the card is not
> properly intitialized, here is the errors I get:
> 
> airo: register interrupt 0 failed, rc -16
> airo_cs: RequestConfiguration: Operation succeeded
> 
> cardmgr[20]: get dev info on socket 0 failed: Resource temporarily
> unavailable.
> 
    I can only give you this link where the problem is referenced and 
have some instructions to guess wich memory addresses to reserve for the 
cardbus.
  http://pcmcia-cs.sourceforge.net/ftp/doc/PCMCIA-HOWTO-3.html#ss3.5

>>However this problem is not caused by the Airo driver. And, (i think) it 
>>is not a  kernel problem. Maybe a pcmcia_cs one.
> 
> 
> Okay so the kernel changed something and is now using that memory area?
> 
    No. I think kernel does not change anything. Maybe is that the 
kernel fits a region of memory originally reserved for the cardbus as is 
defined in config.opts. Maybe because those new kernel are a few Kb 
bigger than before one's.

    Remembering this thing makes me think that this "issue" is more a 
pcmcia_cs thing than a kernel/driver one.

Hope it helps you or any other developer/list__member here.

PD: Excuse my poor english.

