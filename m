Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTLMETN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 23:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTLMETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 23:19:13 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:26387 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263836AbTLMETK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 23:19:10 -0500
Message-ID: <3FDA9320.1010702@nishanet.com>
Date: Fri, 12 Dec 2003 23:18:40 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com> <20031211182108.GA353@tesore.local> <3FD98A1F.901@nishanet.com> <20031212165929.GA187@tesore.local> <20031212181827.GA3862@forming>
In-Reply-To: <20031212181827.GA3862@forming>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: two instances of good but undocumented bios voodoo

Josh McKinney wrote:

>On approximately Fri, Dec 12, 2003 at 09:59:29AM -0700, Jesse Allen wrote:
>  
>
>>On Fri, Dec 12, 2003 at 04:27:59AM -0500, Bob wrote:
>>    
>>
>>>Jesse Allen wrote:
>>>
>>>      
>>>
>>>>On Thu, Dec 11, 2003 at 06:52:41PM +0100, Ian Kumlien wrote:
>>>>
>>>>
>>>>        
>>>>
>>>> ............
>>>>
>>>>but I checked 
>>>>for a bios update first.  And sure enough like they read my mind, just 
>>>>posted online today, an update.  Here are the details of fixes:
>>>>
>>>>" Checksum:   8B00H                         Date Code: 12/05/03
>>>>1.Support 0.18 micron AMD Duron (Palomino) CPU.
>>>>2.Add C1 disconnect item."..........Jesse
>>>>        
>>>>
-Jesse got a bios update that gives him a cpu disconnect
option now in setup

>>>>        
>>>>
>>>A bios update for MSI K7N2 MCP2-T nforce2 board
>>>fixed the crashing BEFORE these patches were developed,
>>>but there was no documentation that would relate or explain.
>>>      
>>>
-Bob said that about his bios update fixing
the lockup problem entirely, but no doc,
needing no patch except to turn on ioapic
edge timer(another clue--without ioapic
edge timer working bios update fixed this
nforce2 situation!), no clue as to whether bios
update sets cpu disconnect one way or the other,
no opt to choose cpu disconnect in new or old
setup.

Jesse continues--

>>Last night, I updated the bios to the 12-5-03 released yesterday (see above).  I looked at the new option under Advanced Chipset Features, "C1 Disconnect".  It has three selections: Auto, Enabled, Disabled.  There seems to be no default.  The item help says:
>>"Force En/Disabled 
>> or Auto mode:
>> C17 IGP/SPP NB A03
>> C18D SPP NM A01 (C01)
>> enabled C1 disconnect
>> otherwise disabled it"
>>
>>Auto sounded nice, so I selected that first.  I compiled a new kernel without the disconnect off patch, or the ack delay.  These are the exact patches I used on 2.6.0-test11:
>>patch-2.6.0-test11-bk8.bz2
>>acpi-2.6.0t11.patch acpi bugfixes from Maciej.
>>nforce-ioapic-timer-2.6t11.patch from Ross Dickson.  Timer patch.
>>forcedeth.patch Patch stolen from -test10-mm1?  Unused.
>>forcedeth-update-2.patch Same.
>>
>>Sure enough, under this kernel, no lockups.  Athcool reported Disconnect was "on".
>>    
>>
Disconnect was ON!!!

> <snip>  ...one case the bios update fixed the problem

without needing cpu disconnect off, the other case we
don't know how or whether cpu disconnect is on or
off now but bios update fixed nforce2 without turning
ioapic edge timer on. I guess these two case prove that
neither cpu disconnect =on or ioapic timer =off are
causing the problem directly.

>The thing that strikes me funny is that you get no crashes with the
>updated BIOS and Disconnect on, but without the updated BIOS we have
>to turn disconnect off with athcool or the patch?  This makes me think
>that there is some voodoo going on in the BIOS update that they aren't
>saying, surprise surprise, or something is just slowing down the time
>it takes for it to crash.  I say this because I have gone 5+ days
>without any of the patches from these threads, acpi apic lapic
>enabled, and CPU disconnect on as stated by athcool.  This was with
>much stress testing, idle time, etc.  One day I just ran a grep that I
>have done probably 30 times and boom, hang.  
>
>Good luck, hope the BIOS is the trick, now off to see how I can get
>ASUS to put the C1 Disconnect in the next revision.
>
...and at least two motherboard makers have voodoo
to fix the problem.

