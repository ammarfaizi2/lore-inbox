Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWHXFOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWHXFOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 01:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWHXFOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 01:14:24 -0400
Received: from mserv4.uoregon.edu ([128.223.142.54]:22176 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S1030291AbWHXFOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 01:14:24 -0400
Message-ID: <44ED358D.30602@uoregon.edu>
Date: Wed, 23 Aug 2006 22:13:49 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: Tejun Heo <htejun@gmail.com>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Hardware vs. Software Raid Speed
References: <44EBFB3E.8070905@perkel.com> <44EC02FD.7050207@tomt.net> <44EC94A9.4010903@gmail.com> <44EC9699.3040001@perkel.com>
In-Reply-To: <44EC9699.3040001@perkel.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Perkel wrote:
> 
> 
> Tejun Heo wrote:
>> Andre Tomt wrote:
>>> Marc Perkel wrote:
>>>> Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0
>>>> striping on the motherboard. Just wondering if hardware raid (SATA2) 
>>
>> SATA2 has nothing to do with hardware RAID.
>>
>>>> is going to be faster that software raid and why?
>>>
>>> Beeing a consumer type board (AM2), the "raid on the motherboard" is
>>> in 99.999% of the cases just software raid implemented in their
>>> Windows drivers, a bootup setup screen plus some BIOS magic to get
>>> the OS booting.
>>
>> And, yeah, they're all software RAID.  Also, there isn't much to be
>> gained from making RAID0/1 hardware.  The software overhead isn't that
>> big.  For RAID5, having XOR done in hardware helps.
>>
> 
> Thanks - I suspected that Raid 0 didn't gain anything in hardware unless
> they provided additional buffering or something but I just thought I'd
> ask in case there was something I was overlooking.

A hardware raid controller can buy you a battery backed write cache, so
there are potentially some performance/safety benefits potentially.

We have a mix of software raid and 3ware based hardware raid subsystems.
For the applications we support, in general I can say that performance
was not the discriminating reason to choose one over the other.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
------------------------------------------------------------------------
Joel Jaeggli             Unix Consulting              joelja@uoregon.edu
GPG Key Fingerprint:   5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
