Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423351AbWKHUeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423351AbWKHUeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423272AbWKHUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:34:17 -0500
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:52623
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1423351AbWKHUeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:34:12 -0500
Message-ID: <45523F3F.8010806@seclark.us>
Date: Wed, 08 Nov 2006 15:34:07 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Francois Romieu <romieu@fr.zoreil.com>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, netdev@vger.kernel.org
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us>	<4551F3A6.8040807@gmail.com>	<4551F5B7.1050709@seclark.us>	<20061108182658.GA21154@electric-eye.fr.zoreil.com>	<45523289.2010002@seclark.us> <20061108122649.2f79ec1f@freekitty>
In-Reply-To: <20061108122649.2f79ec1f@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>On Wed, 08 Nov 2006 14:39:53 -0500
>Stephen Clark <Stephen.Clark@seclark.us> wrote:
>
>  
>
>>Francois Romieu wrote:
>>
>>    
>>
>>>Stephen Clark <Stephen.Clark@seclark.us> :
>>>[...]
>>> 
>>>
>>>      
>>>
>>>>No it is not loaded - i did a modprobe on it and it loaded but still no 
>>>>ethx device.
>>>>   
>>>>
>>>>        
>>>>
>>>Send complete 'dmesg' and 'lspci -vvx' (please Cc: netdev@vger.kernel.org)
>>>
>>> 
>>>
>>>      
>>>
>>lspci and dmesg attached below:
>>Thanks, anything else I can do please let me know.
>>    
>>
>
>  
>
>>03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
>>Network Connection (rev 02)
>>        Subsystem: Intel Corporation Unknown device 1000
>>
>>    
>>
>
>Use the ipw3945 driver and binary regulatory daemon from:
>	http://ipw3945.sourceforge.net/#downloads
>  
>
Thanks I have that working - I am now struggling with the disk being
slower than molasses ( high priority, 1.xx mb/sec  ) and the integrated 
realtek ethernet
( low prioirty - since I got the wifi working ).

> 
>  
>
>>05:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169SC 
>>Gigabit Ethernet (rev 10)
>>        Subsystem: ASUSTeK Computer Inc. Unknown device 1345
>>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
>>ParErr- Stepping- SERR- FastB2B-
>>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>><TAbort- <MAbort- >SERR- <PERR-
>>        Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: I/O ports at d800 [size=256]
>>        Region 1: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=256]
>>        Expansion ROM at 80000000 [disabled] [size=128K]
>>        Capabilities: [dc] Power Management version 2
>>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
>>PME(D0-,D1+,D2+,D3hot+,D3cold+)
>>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>00: ec 10 67 81 17 00 b0 02 10 00 00 02 08 40 00 00
>>10: 01 d8 00 00 00 fc 8f fe 00 00 00 00 00 00 00 00
>>20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 45 13
>>30: 00 00 8c fe dc 00 00 00 00 00 00 00 0b 01 20 40
>>
>>    
>>
>
>This PCI ID was added to 2.6.19.  You should run 2.6.19-rc5 or backport the changes.
>
>
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


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



