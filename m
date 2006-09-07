Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWIGTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWIGTQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWIGTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:16:01 -0400
Received: from hermes.domdv.de ([193.102.202.1]:45576 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1751440AbWIGTP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:15:59 -0400
Message-ID: <45006FEE.7020407@domdv.de>
Date: Thu, 07 Sep 2006 21:15:58 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.17.8] noapic and /proc/acpi/event
References: <45006A6F.8030801@domdv.de> <200609071505.49820.len.brown@intel.com>
In-Reply-To: <200609071505.49820.len.brown@intel.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Thursday 07 September 2006 14:52, Andreas Steinmetz wrote:
> 
>>I do have a problem with a new laptop (Acer Ferrari 4006):
>>
>>It does suspend either to disk or to ram only when I do boot with
>>"noapic". So far, so good.
> 
> 
> Well no, that isn't so good either.  You shouldn't need "noapic"
> for anything, either normal operation or suspend/resume.
> 
> Do ACPI events work properly w/o noapic if you don't suspend/resume?
> 

Yes, they do, that's how I tested.

> You should be able to kill acpid, and cat /proc/acpi/event
> and open/close your lid and watch events appear --
> same for power button.
> You should also be able to see the acpi line in /proc/interrupts
> increment for each of these events.
> 
> 
>>If, however, I do boot with "noapic" no events are delivered to
>>/proc/acpi/event so lid switch and power button can't be used to suspend
>>anymore.
> 
> 
> Does noapic work properly before the suspend?
> (test the same way as w/o noapic above)
> 

No events, no ACPI interrupts.

> 
>>The strange thing is, that at least in /proc/acpi/button/lid/LID/state I
>>can view the lid switch state.
> 
> 
> The problem with your system is that it isn't getting ACPI interrupts.
> The lid state in /proc is immune to that problem because when
> you read that file Linux asks the hardware for its state on demand.
> 

I see.

> cheers,
> -Len
>  


-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
