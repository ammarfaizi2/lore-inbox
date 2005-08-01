Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVHAUCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVHAUCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVHAUCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:02:21 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:33226 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261206AbVHAUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:02:06 -0400
Message-ID: <42EE7FBF.1090505@m1k.net>
Date: Mon, 01 Aug 2005 16:02:07 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hermann pitton <hermann.pitton@onlinehome.de>
CC: video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       cijoml@nebuchadnezzar.smejdil.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: 2 errors in 2.6.12
References: <200506190958.00267.cijoml@volny.cz>	 <20050728214851.44877164.akpm@osdl.org>	 <200507311351.52631.cijoml@volny.cz>	 <20050731103156.69536415.akpm@osdl.org> <42ED1016.1000804@m1k.net>	 <20050801111414.G59306@nebuchadnezzar.smejdil.cz>	 <1122894516.5340.9.camel@pc08.localdom.local>	 <20050801201017.G77710@nebuchadnezzar.smejdil.cz> <1122926100.5340.38.camel@pc08.localdom.local>
In-Reply-To: <1122926100.5340.38.camel@pc08.localdom.local>
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

Thank you, Hermann.

AKPM (cc re-added) requested that this thread retain cc's to him... so 
he should see that it has been resolved.......

hermann pitton wrote:

>Hello,
>
>this one is solved.
>
>Guess we will see similar issues more often for a while.
>
>Cheers,
>Hermann
>
>
>Am Montag, den 01.08.2005, 20:11 +0200 schrieb CIJOML:
>  
>
>>On Mon, 1 Aug 2005, hermann pitton wrote:
>>
>>    
>>
>>>Am Montag, den 01.08.2005, 11:16 +0200 schrieb CIJOML:
>>>      
>>>
>>>>Hi,
>>>>
>>>>my card is impossible to be autodetected. Valid sections for it's
>>>>identification are missing.
>>>>
>>>>I asked for this some time ago. I need to use insmod option.
>>>>
>>>>Michal
>>>>        
>>>>
>>>Hi Michal,
>>>
>>>the "tuner type=N" insmod option is gone away.
>>>
>>>There has been a warning that it is deprecated for about 1  1/2 years
>>>in dmesg. Please remove it from /etc/modprobe.conf or where else it is
>>>called and replace it with "options bttv card=N tuner=N", guess you
>>>      
>>>
>>AAAAH!!!! This helped!!! Thanks a lot
>>after options bttv           card=42 radio=1 tuner=1
>>card works! :)
>>
>>Linux video capture interface: v1.00
>>bttv: driver version 0.9.15 loaded
>>bttv: using 8 buffers with 2080k (520 pages) each for capture
>>bttv: Bt8xx card found (0).
>>ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low)
>>-> IRQ 9
>>bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio:
>>0xb69fe000
>>bttv0: using: ProVideo PV951 [card=42,insmod option]
>>bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
>>bttv0: using tuner=1
>>bttv0: i2c: checking for TDA9875 @ 0xb0... not found
>>bttv0: i2c: checking for TDA7432 @ 0x8a... not found
>>tvaudio: TV audio decoder + audio/video mux driver
>>tvaudio: known chips:
>>tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
>>(PV951),ta8874z
>>tvaudio: found pic16c54 (PV951) @ 0x96
>>bttv0: i2c: checking for TDA9887 @ 0x86... not found
>> : chip found @ 0xc0 (bt878 #0 [sw])
>> : All bytes are equal. It is not a TEA5767
>>tuner 0-0060: type set to 1 (Philips PAL_I (FI1246 and compatibles))
>>bttv0: registered device video0
>>bttv0: registered device vbi0
>>bttv0: registered device radio0
>>bttv0: PLL: 28636363 => 35468950 .. ok
>>
>>Thanks a lot!
>>
>>Michal
>>
>>
>>    
>>
>>>might use tuner=5, and what else you might need and then "depmod -a".
>>>Does this help?
>>>
>>>Greetings,
>>>Hermann
>>>
>>>
>>>      
>>>
>>>>On Sun, 31 Jul 2005, Michael Krufky wrote:
>>>>
>>>>        
>>>>
>>>>>Andrew Morton wrote:
>>>>>
>>>>>          
>>>>>
>>>>>>Michal Semler <cijoml@volny.cz> wrote:
>>>>>>
>>>>>>
>>>>>>            
>>>>>>
>>>>>>>This is what I gets into dmesg:
>>>>>>>
>>>>>>>Linux video capture interface: v1.00
>>>>>>>bttv: driver version 0.9.15 loaded
>>>>>>>bttv: using 8 buffers with 2080k (520 pages) each for capture
>>>>>>>bttv: Bt8xx card found (0).
>>>>>>>ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 9 (level, low) ->
>>>>>>>IRQ 9
>>>>>>>bttv0: Bt878 (rev 17) at 0000:01:0b.0, irq: 9, latency: 32, mmio: 0xb69fe000
>>>>>>>bttv0: using: ProVideo PV951 [card=42,insmod option]
>>>>>>>bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
>>>>>>>bttv0: using tuner=1
>>>>>>>bttv0: i2c: checking for TDA9875 @ 0xb0... not found
>>>>>>>bttv0: i2c: checking for TDA7432 @ 0x8a... not found
>>>>>>>tvaudio: TV audio decoder + audio/video mux driver
>>>>>>>tvaudio: known chips:
>>>>>>>tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
>>>>>>>(PV951),ta8874z
>>>>>>>tvaudio: found pic16c54 (PV951) @ 0x96
>>>>>>>bttv0: i2c: checking for TDA9887 @ 0x86... not found
>>>>>>>tuner: Unknown parameter `type'
>>>>>>>              
>>>>>>>
>>>              ^^^^^^^^^^^^^^^^^^^^^^^^
>>>      
>>>
>[...]
>
>  
>


-- 
Michael Krufky

