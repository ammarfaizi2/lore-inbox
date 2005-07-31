Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVGaRx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVGaRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVGaRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:53:26 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:53196 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261782AbVGaRxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:53:24 -0400
Message-ID: <42ED1016.1000804@m1k.net>
Date: Sun, 31 Jul 2005 13:53:26 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 errors in 2.6.12
References: <200506190958.00267.cijoml@volny.cz>	<20050728214851.44877164.akpm@osdl.org>	<200507311351.52631.cijoml@volny.cz> <20050731103156.69536415.akpm@osdl.org>
In-Reply-To: <20050731103156.69536415.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michal Semler <cijoml@volny.cz> wrote:
>  
>
>> This is what I gets into dmesg:
>>
>> Linux video capture interface: v1.00
>> bttv: driver version 0.9.15 loaded
>> bttv: using 8 buffers with 2080k (520 pages) each for capture
>> bttv: Bt8xx card found (0).
>> ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low) -> 
>> IRQ 9
>> bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio: 0xb69fe000
>> bttv0: using: ProVideo PV951 [card=42,insmod option]
>> bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
>> bttv0: using tuner=1
>> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
>> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
>> tvaudio: TV audio decoder + audio/video mux driver
>> tvaudio: known chips: 
>> tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
>> (PV951),ta8874z
>> tvaudio: found pic16c54 (PV951) @ 0x96
>> bttv0: i2c: checking for TDA9887 @ 0x86... not found
>> tuner: Unknown parameter `type'
>> bttv0: registered device video0
>> bttv0: registered device vbi0
>> bttv0: registered device radio0
>> bttv0: PLL: 28636363 => 35468950 .. ok
>> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
>> PCI: setting IRQ 10 as level-triggered
>> ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> 
>> IRQ 10
>>    
>>
>
>(cc the v4l list)
>
>The above is with 2.6.13-rc4.  2.6.11 was OK.
>  
>
Michael-

Please remove the insmod options:

bttv0: using: ProVideo PV951 [card=42,insmod option]

...and show us dmesg output with autodetection.

Also, please try CVS and tell us if you still have the problem... Instructions at:

http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

-- 
Michael Krufky

