Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTL3U7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTL3U7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:59:07 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:4238 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262425AbTL3U7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:59:04 -0500
Message-ID: <3FF1E713.9050001@rackable.com>
Date: Tue, 30 Dec 2003 12:58:59 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com> <20031229134150.GB30794@louise.pinerecords.com> <20031229185908.GB31215@mail-infomine.ucr.edu> <3FF07AD8.2040601@rackable.com> <20031229190327.B5729@animx.eu.org> <20031230065439.GA1517@louise.pinerecords.com> <20031230094157.A7191@animx.eu.org>
In-Reply-To: <20031230094157.A7191@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2003 20:58:59.0704 (UTC) FILETIME=[BF4A9780:01C3CF17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
>>>>nice about bad sectors as most hardware raid controllers.  On the other 
>>>>hand the md driver kicks the ass of nearly every raid controller I've tried.
>>>
>>>Faster than the mylex extreme raid 2000?  or one of the higher end adaptecs?
>>
>>Even faster than HP/Compaq cciss hwraid setups, yes.
> 
> 
> I've personally not had any experience with any hardware raid other than the
> mylex DAC960 family.
>

   I know a number of people that run their mylex cards in jbod mode and 
use software raid;-)


> One thing that keeps me from using the linux raid sw is the fact it can't be
> partitioned.  

   You're thinking of it the wrong way.  You just create a bunch of 
partitions and make them into raid devices.  You shouldn't be using the 
entire disk or you will break autodetection.

> I thought about lvm/evms, but I'm unwilling to make an initrd to
> set it up (mounting root).  Unfortunately boot loaders don't seem to support
> anything other than raid1. (Mostly lilo, but I'm not sure grub would do this
> either)
> 

   Lilo deals well with raid 1 devices.  I typical create a small raid 1 
mirror as /boot.  Just be sure to install your bootloader on to all 
drives.  Newer versions of lilo will do the right thing if told to use 
/dev/mdwhatever.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

