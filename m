Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131551AbQKATgB>; Wed, 1 Nov 2000 14:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131566AbQKATfx>; Wed, 1 Nov 2000 14:35:53 -0500
Received: from f14.law9.hotmail.com ([64.4.9.14]:34834 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131551AbQKATfj>;
	Wed, 1 Nov 2000 14:35:39 -0500
X-Originating-IP: [208.5.125.50]
From: "KJ Pickett" <pc_pimp@hotmail.com>
To: eepro100@scyld.com, linux-kernel@vger.kernel.org
Subject: 2.2.18p18 eepro100 issues (packets per irq, shared irqs)
Date: Wed, 01 Nov 2000 19:35:32 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F14h29cM3oryKFRJrzd00005763@hotmail.com>
X-OriginalArrivalTime: 01 Nov 2000 19:35:32.0356 (UTC) FILETIME=[E5FA6C40:01C0443A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all I would like to say that 2.2.18p18 does not have the 'card 
reports no resources' messages when I saturate the 100mbit network anymore.

But I was wondering about two things:
I have a 815EE board, which has an onboard eepro100 and a pci eepro100.  
They share an irq, no matter if I'm using intels e100.o driver or the stock 
linux one.  For performance reasons, can I make them each have a different 
irq?  Doing it from ifconfig gives me a notsupported error, with either 
driver.

Also: VMSTAT output, comparing stock linux driver with intel.  Heres the 
stock linux:

1  0  0      0  31836  67632  13240   0   0     0     0 24015 47215  20  15  
65
1  0  0      0  31836  67632  13240   0   0     0     1 24016 47016  21  16  
64

The card is recv'ng 24k packets per second, and seeing that many irqs.  The 
intel driver does 6 per irq, and vmstat from that driver (not posted, but I 
remember what it was) shows 6 times less irq/sec and cs/sec.  Even though, 
it appears the stock linux driver is supposed to do 20 things per irq?  I am 
no kernel hacker...can I get the stock linux driver to do multiple packets 
per irq with some config settings?

Thanks,

Karl Pickett
(Posting from hotmail since I cant use my companies email address)
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

Share information about yourself, create your own public profile at 
http://profiles.msn.com.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
