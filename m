Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVIUN6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVIUN6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVIUN6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:58:12 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:28558 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1750952AbVIUN6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:58:12 -0400
Message-ID: <4331671F.7000006@concannon.net>
Date: Wed, 21 Sep 2005 09:58:55 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bogomips on AMD X2 (was Re:)
References: <OF73453AE5.CDE706CC-ON80257083.004ACF55-80257083.004B7A0F@telex.com>
In-Reply-To: <OF73453AE5.CDE706CC-ON80257083.004ACF55-80257083.004B7A0F@telex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert.Boermans@uk.telex.com wrote:

>On Wednesday 21 September 2005 16:20, Robert.Boermans@uk.telex.com wrote:
>  
>
>>Hello, 
>>
>>I noticed that the bogomips results for the two cores on my machine are 
>>consistently not the same, the second one is always reported slightly 
>>faster, it's a small difference and I saw the same in a posted dmesg 
>>    
>>
>from 
>  
>
>>somebody else on the list. Which made me wonder: 
>>    
>>
>
>I guess it's a cache warming effect. Please show the numbers.
>--
>vda
>
>Probably not, got this one from a web site, and on this one the first core 
>seems to be faster (can't check my own machine it's off and at home and 
>I'm at work.) The difference I get is similar, but always with the second 
>one faster. It's the same when using cat on /proc/cpuinfo. Oh and I saw it 
>on 2.6.11 and 2.6.12 as supplied with fedora core 4 myself.
>
>Calibrating delay using timer specific routine.. 4014.73 BogoMIPS 
>(lpj=8029470)
>Mount-cache hash table entries: 512
>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>CPU: L2 Cache: 512K (64 bytes/line)
>CPU 0(2) -> Core 0
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>mtrr: v2.0 (20020519)
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
>Booting processor 1/1 eip 2000
>Initializing CPU#1
>Calibrating delay using timer specific routine.. 4005.37 BogoMIPS 
>(lpj=8010751)
>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>CPU: L2 Cache: 512K (64 bytes/line)
>CPU 1(2) -> Core 1
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#1.
>CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
>Total of 2 processors activated (8020.11 BogoMIPS).
>
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
opposite result here - 2nd one is faster (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
cpu MHz         : 2211.337
bogomips        : 4374.52
...
processor       : 1
vendor_id       : AuthenticAMD
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
cpu MHz         : 2211.337
...
bogomips        : 4407.29

