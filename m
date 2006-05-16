Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWEPOcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWEPOcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWEPOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:32:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36589 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751149AbWEPOcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:32:17 -0400
Message-ID: <4469E26A.50108@garzik.org>
Date: Tue, 16 May 2006 10:32:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>,
       Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <4469C024.3030506@gmail.com>
In-Reply-To: <4469C024.3030506@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Fortier,Vincent [Montreal] wrote:
>>>> Now I'm having an ASUS A8V Deluxe.... and sadly a lot of problems:
>>>>
>>>> - My SATA Controller make my Linux crash when connecting a Plextor 
>>>> 716SA CD-DVD-R (http://bugzilla.kernel.org/show_bug.cgi?id=5533)
>>
>>> Patch:
>>>
>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-
>> git2-libata1.patch.bz2
>>> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
>> 2.6.17-rcX[-gitY] kernels)
>>
>> I gave a try at the latest ata patches announced yesterday by Jeff and
>> it completelly solved my SATA ATAPI bug.. I even been able to burn my
>> first DVD using my Plextor 716SA on my Linux!!!  Really nice and much
>> anticipated work!  Thnx a lot!
>>
>> I have already marked bug 5533 as resolved and I'll wait until inclusion
>> into 2.6.18 to close it.  I've also marked bug 6317 has closed since
>> that did not occur since around rc2 or rc3 of 2.6.17.
>>
> 
> Jeff, do you know what fixed this one?  I've been following the bug and 
> thought it was one of those via-ATAPI-have-no-idea bugs.  How come the 
> update fix this one?  Have I missed something?

No idea :)

Though this update should solve several classes of longstanding bugs.

* irq-pio is much friendlier to the controller, and should eliminate 
several screaming interrupt problems, particularly on sata_sil.

* The better EH should allow recovery from problems we couldn't recover 
from before.

* The removal of assert()s (or, removal of conditions that caused 
asserts) that triggered in earlier kernels will also eliminate the 
associated forced oopsen.

But in the via+ATAPI case, the only thing I can think of is that VIA 
AHCI support is included in the update.  Other than that... <shrug>

	Jeff


