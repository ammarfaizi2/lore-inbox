Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132609AbRDBA6t>; Sun, 1 Apr 2001 20:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDBA6k>; Sun, 1 Apr 2001 20:58:40 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:32273 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132590AbRDBA6a>; Sun, 1 Apr 2001 20:58:30 -0400
Message-Id: <200104020057.f320vZs73846@aslan.scsiguy.com>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi bus numbering 
In-Reply-To: Your message of "Sun, 01 Apr 2001 21:00:18 +0200."
             <Pine.LNX.4.30.0104012054180.779-100000@swamp.bayern.net> 
Date: Sun, 01 Apr 2001 18:57:35 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, 1 Apr 2001, Douglas Gilbert wrote:
>
>[...]
>
>> >>>>>>>>>  scsihosts  <<<<<<<<<<<<<
>>
>> As a boot time option try:
>>   scsihosts=aic7xxx:ncr53c8xxx
>> or if you are using lilo, in /etc/lilo.conf add:
>>   append="scsihosts=aic7xxx:ncr53c8xxx"
>
>that does indeed change the bus numbering. Unfortunately, even
>with this option, the first disk on the ncr controller becomes
>"/dev/sda" ...
>
>regards,
>               Peter Daum

This is probably because the aic7xxx driver is not linked into
the scsi "library" for statically compiled HBA drivers.  It is
linked directly into the kernel and I believe is after the scsi.a
entry on the link line.  I'll look into this on monday.

--
Justin
