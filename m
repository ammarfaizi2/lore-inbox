Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVBGWIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVBGWIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBGWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:08:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60407 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261210AbVBGWIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:08:07 -0500
Message-ID: <4207E6C0.1070006@mvista.com>
Date: Mon, 07 Feb 2005 14:08:00 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
References: <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206081137.GA994@elf.ucw.cz> <1107679990.3532.37.camel@krustophenia.net> <20050206102503.GA1089@elf.ucw.cz>
In-Reply-To: <20050206102503.GA1089@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>I do have CONFIG_X86_PM_TIMER enabled, but it seems by board does not
>>>have such piece of hardware:
>>>
>>>pavel@amd:/usr/src/linux-mm$ dmesg | grep -i "time\|tick\|apic"
>>>PCI: Setting latency timer of device 0000:00:11.5 to 64
>>>pavel@amd:/usr/src/linux-mm$ 
>>
>>If you are sure that machine supports ACPI, maybe this is your problem
>>(from the POSIX high res timer patch):
>>
>>          If you enable the ACPI pm timer and it cannot be found, it is
>>          possible that your BIOS is not producing the ACPI table or
>>          that your machine does not support ACPI.  In the former case,
>>          see "Default ACPI pm timer address".  If the timer is not
>>          found the boot will fail when trying to calibrate the 'delay'
>>          loop.
> 
> 
> Well, but how do I get the address? I'll try looking at BIOS
> options...
> 								Pavel
In my machine, if I turned off the PM code (in the BIOS) (or possibly turning on 
the ACPI, again in the BIOS) it did produce the address.  Booting then would put 
that address in the dmesg file.  You can then change the BIOS back to what it 
was and use the address found in the dmesg file.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

