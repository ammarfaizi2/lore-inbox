Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTIAGNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTIAGNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:13:31 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:25348 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262654AbTIAGN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:13:28 -0400
Message-ID: <3F52E0B3.2090001@boxho.com>
Date: Mon, 01 Sep 2003 02:01:23 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: many IDE PCI cards "spurious 8259a" irq15(SMBus nforce2)
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>	 <3F4F5C9A.5BAA1542@vtc.edu.hk> <200308311443.55543.hpj@urpla.net> <3F5287BC.48A1BCE6@vtc.edu.hk>
In-Reply-To: <3F5287BC.48A1BCE6@vtc.edu.hk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Success story" got me in deeper, another round of disappointment. 
"spurious 8259a interrrupt on irq15"
is the only message, irq15 is nforce2 SMBus.

This got me to try using four hd's on two Promise cards, no drives on 
mbo's amd74xx in the nforce2 set,
no cd's. I get lots of hangs. Lots of crashes but this bit of info--many 
other combos yield no clue just a
lockup but maybe the irq is SMBus nforce2 and is that io-apic code? 
"spurious 8259a on irq 15" on
all sorts of ops on files and drives, fsck, kernel compile, that message 
sometimes just before hang.

I've done 87 reboots 534 fscks 27 kernel compiles failed but I can get a 
kernel compiled with
io-apic turned off in config, I'll try it!

Or throw out ide and buy all scsis, but scsi might hang due to io-apic, 
too, if that's what it is.

cmd680 sii680 card doesn't work either. no error logged there, just hangs.

2 hd's on mobo and two on promise, no

2 hd's on mobo and two on siig sii680, no

none on mobo and four on two Promise cards, no

turn off irq unmask, no

lower udma settings, no

MSI nk7-delta mbo nforce2 amd xp 3000+ tried disabled usb, audio, 
ethernet, serial, parallel, apic

-Bob

Nick Urbanik wrote:

>Dear Folks,
>
>Hans-Peter Jansen wrote:
>
>  
>
>>Hi Nick,
>>
>>On Friday 29 August 2003 16:00, Nick Urbanik wrote:
>>    
>>
>>>Performance is a relatively minor issue compared with stability and
>>>low cost.
>>>
>>>Is there _anyone_ who is using a number of ATA133 IDE disks (>=6),
>>>each on its own IDE channel, on a number of PCI IDE cards, and
>>>doing so successfully and reliably?  I begin to suspect not!  If
>>>so, please tell us what motherboard, IDE cards you are using.  I
>>>used to imagine that a terabyte of RAID storage on one P4 machine
>>>with ordinary cheap IDE cards with software RAID would be feasible.
>>> I believe it is not (although I cannot afford to play musical
>>>motherboards).
>>>      
>>>
>>It is. I'm running several pretty stable systems with IDE SW RAID 5
>>on top of Promise TX2/100 (~30 Eur) controllers.
>>    
>>
>
>Is that the PDC20270 chipset?  What motherboard are you using (i.e., I guess
>you are using two IDE channels on the motherboard, so what chipset are you
>using there)?  What kernel?  Are you using ide-scsi at the same time?  A DVD
>player?  If so, how have you connected them?  What is the biggest number of
>hard disks you are using?  What size?
>
>I would like to try this out myself.  Thank you---this is the first success
>story I have heard!
>
>--
>Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
>Dept. of Information & Communications Technology
>Hong Kong Institute of Vocational Education (Tsing Yi)
>Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
>PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
>GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

