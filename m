Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbVLJCRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVLJCRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLJCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:17:43 -0500
Received: from zorg.st.net.au ([203.16.233.9]:2514 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932297AbVLJCRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:17:41 -0500
Message-ID: <439A3B15.5010608@torque.net>
Date: Sat, 10 Dec 2005 12:19:01 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Erik Slagter <erik@slagter.name>, Jens Axboe <axboe@suse.de>,
       Randy Dunlap <randy_d_dunlap@linux.intel.com>, hch@infradead.org,
       mjg59@srcf.ucam.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>	 <20051208091542.GA9538@infradead.org>	 <20051208132657.GA21529@srcf.ucam.org>	 <20051208133308.GA13267@infradead.org>	 <20051208133945.GA21633@srcf.ucam.org>	 <20051208134438.GA13507@infradead.org>	 <1134062330.1732.9.camel@localhost.localdomain>	 <43989B00.5040503@pobox.com>	 <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com>	 <1134121522.27633.7.camel@localhost.localdomain>	 <20051209103937.GE26185@suse.de> <1134125145.27633.32.camel@localhost.localdomain> <43996A26.8060700@pobox.com>
In-Reply-To: <43996A26.8060700@pobox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Erik Slagter wrote:
> 
>> On Fri, 2005-12-09 at 11:39 +0100, Jens Axboe wrote:
>>
>>
>>>> IMHO available infrastructure (and hardware abstraction!) should be
>>>> used
>>>> instead of being stubborn and pretend we know everything about any
>>>> hardware.
>>>
>>>
>>> It's not about being stubborn, it's about maintaining and working on a
>>> clean design. The developers have to do that, not the users. So forgive
>>> people for being a little cautious about shuffling all sorts of ACPI
>>> into the scsi core and/or drivers. We always need to think long term
>>> here.
>>>
>>> Users don't care about the maintainability and cleanliness of the code,
>>> they really just want it to work. Which is perfectly understandable.
>>
>>
>>
>> I perfectly understand that, what I do object against, is rejecting a
>> concept (like this) totally because the developers(?) do not like the
>> mechanism that's used (although ACPI is used everywhere else in the
>> kernel). At least there might be some discussion where this sort of code
>> belongs to make the design clean and easily maintainable, instead of
>> instantly completely rejecting the concept, because OP simply doesn't
>> like acpi.
> 
> 
> Framing the discussion in terms of "like" and "dislike" proves you
> understand nothing about the issues -- and lacking that understanding,
> you feel its best to insult people.

Jeff,
Point of order.

My email record of this thread indicates that it was
Christoph Hellwig:
http://marc.theaimsgroup.com/?l=linux-scsi&m=113404894931377&w=2
who initially lowered the tone. Just to prove that was not
an aberration he followed that up with this email:
http://marc.theaimsgroup.com/?l=linux-scsi&m=113404957727924&w=2
and there are several others. Given Christoph's posts I
find those of Matthew Garrett and Erik Slagter pretty well
considered and I fail to see what warranted the "you feel its
best to insult people" line above.

I used to think that SCSI was the most maligned part of the
linux kernel, but that no longer seems to be the case.
Can ACPI be really that bad ...

Doug Gilbert

> libata suspend/resume needs to work on platforms without ACPI, such as
> ppc64.  libata reset needs to work even when BIOS is not present at all.
>  And by definition, anything that is done in ACPI can be done in the
> driver.
> 
> The only thing libata cannot know is BIOS defaults.  Anything else
> libata doesn't know is a driver bug.  We already know there are a ton of
> settings that should be saved/restored, which is not done now.  Until
> that code is added to libata, talk of ACPI is premature.  Further, even
> the premature patch was obviously unacceptable, because you don't patch
> ACPI code directly into libata and SCSI.  That's the wrong approach.
> 
>     Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

