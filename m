Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946898AbWKAOWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946898AbWKAOWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946899AbWKAOWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:22:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:16633 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946898AbWKAOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:22:00 -0500
Message-ID: <4548AD4E.8050007@impulze.org>
Date: Wed, 01 Nov 2006 15:21:02 +0100
From: impulze <impulze@impulze.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>, Allen Martin <AMartin@nvidia.com>,
       Robert Hancock <hancockr@shaw.ca>, Len Brown <lenb@kernel.org>,
       Andy Currid <ACurrid@nvidia.com>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48D31D@hqemmail02.nvidia.com> <200610201504.51657.ak@suse.de>
In-Reply-To: <200610201504.51657.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:477985ecf28e42b783e12f32bfe78b70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Well that's the problem.  The issue only existed in the nForce2
>> reference BIOS (and maybe early in nForce3) but we still occasionally
>>     
>
> Definitely some NF3 too, i've seen it on 64bit boxes.
>
>   
>> see shipping customer BIOSes to this day that have this same bug for
>> nForce5 (like M2NPV referenced in this thread).
>>
>> Probably what ASUS is doing in the M2NPV BIOS is copying the ACPI tables
>> from an earlier nForce2 product.
>>     
>
> But the timer override is correct or still broken?
>
>   
>> Probably what needs to happen is to make the HPET check more robust and
>> only return 1 if HPET is present and enabled.
>>     
>
> I think the problem is that those Asus boards also don't have a HPET
> table. So even though NF5 has HPET the kernel doesn't know about it
> and the heuristic "if HPET then NF5 and timer override ok" breaks.
>
> I still suspect doing a 
> "if (PCI ID from NF2 or NF3) ignore timer override" 
> is probably the best solution right now. But I don't have a full
> list of PCI-IDs for NF2/NF3. Do you have one?
>
> Ok that might still break the NF4. I assume it never needs any
> timer overrides so it might be safe to include it in the PCI-IDs
> too.
>
> Or do you have a better proposal?
>
> -Andi
>   
Anyway i chatted around the globus and someone also mentioned that my 
IRQs for sound and several others are very high. I'm not sure if this is 
a board issue or a kernel issue. But since the sound chip on board (hda 
intel) is having problems too I guess it's a kernel related thing. I 
wonder if this will be fixed in newer versions.
