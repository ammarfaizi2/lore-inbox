Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936721AbWLCOfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936721AbWLCOfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936722AbWLCOfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:35:45 -0500
Received: from mga07.intel.com ([143.182.124.22]:18090 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S936721AbWLCOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:35:44 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,489,1157353200"; 
   d="scan'208"; a="153063893:sNHT18163369"
Message-ID: <4572E0BC.1060203@linux.intel.com>
Date: Sun, 03 Dec 2006 17:35:40 +0300
From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
References: <200612031526.00861.arvidjaar@mail.ru> <20061203131124.GG4773@ucw.cz> <200612031652.38155.arvidjaar@mail.ru>
In-Reply-To: <200612031652.38155.arvidjaar@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Sunday 03 December 2006 16:11, Pavel Machek wrote:
>   
>> Hi!
>>
>>     
>>> I started to notice it some time ago; I can't say exactly if this was not
>>> present in earlier versions because recently I switched from STR (which
>>> gave me no end of troubles) to STD. So I may have not seen it before.
>>>
>>> Suspend to disk while on battery. Plug in AC, resume. ACPI continues to
>>> show AC adapter as not present:
>>>
>>> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
>>> state:                   off-line
>>>
>>> replugging AC correctly changes state to on-line.
>>>       
>> try echo platform > /sys/power/disk.
>>     
>
> Nope.
>
> {pts/0}% pmsuspend disk
> ... after resume
> {pts/0}% cat /sys/power/disk
> platform
> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> state:                   off-line
>   
please look if patches in 7122 work  for you.
