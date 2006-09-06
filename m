Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWIFUoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWIFUoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIFUoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:44:19 -0400
Received: from 66-117-159-244.lmi.net ([66.117.159.244]:5762 "EHLO slick.org")
	by vger.kernel.org with ESMTP id S1751214AbWIFUoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:44:18 -0400
Message-ID: <44FF3325.50805@imvu.com>
Date: Wed, 06 Sep 2006 13:44:21 -0700
From: "Brett G. Durrett" <brett@imvu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patro, Sumant" <Sumant.Patro@lsil.com>
CC: Dave Lloyd <dlloyd@exegy.com>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       lkml <linux-kernel@vger.kernel.org>, Berkley Shands <bshands@exegy.com>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
Subject: Re: megaraid_sas waiting for command and then offline
References: <0631C836DBF79F42B5A60C8C8D4E82296A722A@NAMAIL2.ad.lsil.com>
In-Reply-To: <0631C836DBF79F42B5A60C8C8D4E82296A722A@NAMAIL2.ad.lsil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sumant,

Not sure if I am missing something - I appear to be running the latest 
FW available:

                Versions
                ================
Product Name    : PERC 5/i Integrated
Serial No       : 12345
FW Package Build: 5.0.1-0030
FW Version      : 1.00.01-0088
BIOS Version    : MT23
Ctrl-R Version  :1.02-007



Patro, Sumant wrote:

>Hello Brett,
>
>	A DMA related bug was fixed in FW ver *.0095 that was causing
>the FW to stop responding. 
>	
>	Please upgrade the FW version to >= *.0095 and let me know if
>you still see the issue.
> 
>Regards,
>
>Sumant
>
>
>-----Original Message-----
>From: Brett G. Durrett [mailto:brett@imvu.com] 
>Sent: Wednesday, September 06, 2006 9:04 AM
>To: Dave Lloyd
>Cc: Patro, Sumant; Bagalkote, Sreenivas; lkml; Berkley Shands
>Subject: Re: megaraid_sas waiting for command and then offline
>
>
>The machines are Dell 2900s, so the mobo is custom.  From a Dell SE, 
>"Dell uses a custom mobo that is Dell branded with the Intel chipset 
>Greencreek.".
>
>B-
>
>
>
>
>Dave Lloyd wrote:
>
>  
>
>>Brett G. Durrett wrote:
>>    
>>
>>>I have the same or a similar issue running 2.6.17 SMP x86_64 - the
>>>megaraid_sas driver hangs waiting for commands and then the
>>>      
>>>
>filesystem
>  
>
>>>unmounts, leaving the machine in an unusable state until there is a 
>>>      
>>>
>>hard
>>    
>>
>>>reboot (the machine is responsive but any access, shell or 
>>>      
>>>
>>otherwise, is
>>    
>>
>>>impossible without the filesystem).  While I do not have much
>>>      
>>>
>debugging
>  
>
>>>information available, this happens to me about once every 6-7 days
>>>      
>>>
>in
>  
>
>>>my pool of seven machines, so I can probably get debugging info.
>>>      
>>>
>Since
>  
>
>>>the disk is offline and I can't get remote console, I don't have any
>>>details except something similar to Dave Lloyd's post, below.
>>>
>>>The only thing that the machines with these failures seem to have in
>>>common is the fact that they are almost exclusively writes - they
>>>      
>>>
>are
>  
>
>>>slave database machines with large memory and pretty much just
>>>replicate.  The read/write machines seem to have less failures.
>>>
>>>I am happy to help provide debugging information in any reasonable
>>>      
>>>
>way.
>  
>
>>>In the mean time, if there are any known suggestions or workarounds
>>>      
>>>
>for
>  
>
>>>the problem, I would be grateful for the guidance.
>>>
>>>Here are what details on the controller.  If you want additional
>>>      
>>>
>info,
>  
>
>>>let me know exactly what you need and I will do what I can to get it
>>>      
>>>
>to
>  
>
>>>you.:
>>>
>>>Product Name    : PERC 5/i Integrated
>>>Serial No       : 12345
>>>FW Package Build: 5.0.1-0030
>>>FW Version      : 1.00.01-0088
>>>BIOS Version    : MT23
>>>Ctrl-R Version  :1.02-007
>>>
>>>B-
>>>      
>>>
>>Which motherboard are you using?  We believe that this may be a
>>motherboard specific issue.  It appears to happen on a SuperMicro
>>motherboard but not a Tyan motherboard.
>>
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
