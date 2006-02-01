Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWBARvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWBARvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWBARvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:51:24 -0500
Received: from smtpout.mac.com ([17.250.248.47]:10729 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030381AbWBARvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:51:23 -0500
In-Reply-To: <Pine.LNX.4.61.0602011722300.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com> <200601311333.36000.oliver@neukum.org> <200601311444.47199.vda@ilport.com.ua> <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr> <58cb370e0602010756r3973fde7v387c7529b2bd80cd@mail.gmail.com> <Pine.LNX.4.61.0602011722300.22529@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <06C3EA9E-1D1B-4BF9-9BDD-60B8D59DAE4B@mac.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Denis Vlasenko <vda@ilport.com.ua>, Oliver Neukum <oliver@neukum.org>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, acahalan@gmail.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 1 Feb 2006 12:51:13 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 01, 2006, at 11:28, Jan Engelhardt wrote:
>> Moreover providing ordering by IDE driver has been nightmare to  
>> maintain and can't be done correctly for 100% weird cases.
>
> So how much weird cases do we have?

Speaking from personal experience, _waay_ too many.  On my old G4  
which now serves as a fileserver, I have 5 IDE busses out of 3  
controllers (Onboard ATA-66 with 2 busses, onboard ATA-33 with one  
bus, add-in PCI ATA-100 with 2 busses)  There's a _config_ option to  
control probe order specific to the two Apple onboard interfaces, and  
it used to be (before udev) that option was a nightmare to ensure  
that my new kernel has the same probe order as the old one.  Once you  
throw PCI hotplug into the mix, reliable probing order is impossible,  
and you should just use udev to dynamically assign names.


>>> (surprisingly) the other way round, sda just happens to be the  
>>> first disk
>>> inserted (SCA, USB, etc.)
>>
>> Which is much saner approach from developers' POV.
>
> Developer... and about the user/admin? With a sparcbox (ran suse  
> linux 7.3 the last time it was powered on - 2.4 kernel, no udev -  
> don't complain :), replugging disks in put them at the end of the  
> 'sd*' naming chain, effectively killing the features of hotplug the  
> machine itself offered. (Oh, that OS starting with S.. managed it  
> with the help of the behated/-loved c?d?t?s? scheme, but that's OT.)

Yeah, 2.4 was bad at hotplug, everybody knows that already.  This is  
why the changes were made for 2.6 to add udev and hal and make it  
much saner.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


