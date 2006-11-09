Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424103AbWKIQJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424103AbWKIQJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424100AbWKIQJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:09:08 -0500
Received: from outmx017.isp.belgacom.be ([195.238.4.116]:38865 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1424095AbWKIQJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:09:05 -0500
Message-ID: <4553528E.9060504@trollprod.org>
Date: Thu, 09 Nov 2006 17:08:46 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061106)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64  irq 22: nobody cared
References: <4551D12D.4010304@trollprod.org>	<20061109064956.GG4729@stusta.de> <s5hirhovr9j.wl%tiwai@suse.de>
In-Reply-To: <s5hirhovr9j.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi,

You are right, setting disable_msi=1 as an option for snd-hda-intel 
module solve my problem.

Thanks

Olivier

Takashi Iwai wrote:
> At Thu, 9 Nov 2006 07:49:56 +0100,
> Adrian Bunk wrote:
>> On Wed, Nov 08, 2006 at 01:44:29PM +0100, Olivier Nicolas wrote:
>>
>>> Hi,
>> Hi Olivier,
>>
>>> 2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
>>> without success.
>>>
>>> Full details (.config, dmesg, /proc/interrupts) are in 
>>> http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz
>> thanks for your report!
>>
>> I might be wrong, but looking at the dmesg:
>> - irq 22 is the hda_intel IRQ
>> - the "irq 22: nobody cared" is immediately before the
>>   "hda_intel: No response from codec, disabling MSI..."
>> - in the routeirq case, the hda_intel IRQ as well as the
>>   IRQ in the error message change to 21
>>
>> So it might be related to the hda_intel MSI check.
> 
> To disable MSI from the beginning, set disable_msi=1 module option for
> snd-hda-intel.
> 
> 
> Takashi



