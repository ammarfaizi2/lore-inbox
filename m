Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDJOA4>; Tue, 10 Apr 2001 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDJOAg>; Tue, 10 Apr 2001 10:00:36 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:31250 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131809AbRDJOA1>; Tue, 10 Apr 2001 10:00:27 -0400
Message-Id: <200104101400.f3AE0Js30408@aslan.scsiguy.com>
To: lists@sapience.com
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and newer kernels 
In-Reply-To: Your message of "Tue, 10 Apr 2001 08:33:40 EDT."
             <20010410083340.A16601@sapience.com> 
Date: Tue, 10 Apr 2001 08:00:19 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Justin:
>
>Ya think very buggy? I checked seagate web page and 
>unfortunately was unable to find any firmware updates
>for the barracuda drives.

I'm pretty sure you need to be up to at leaset 0005 of 
the firmware to stabilize this drive.

>Curious tho that this has worked flawlessly for well over a 
>year with all prior version of linux and win2000 as well.  
>Also a few other folks seem to have similar problems with 
>newer kernels. 

It all depends on the access pattern.  The drive will only
fail if you fill its write cache.  At that point, it will
fall off the bus, never to return.

>Do the newer drivers put a bigger demand on the drives that 
>might start to uncover the problems previously not seen? 

Depends on your settings.  If you are using the default, we
run a much larger number of concurrent transactions when
compared to the old driver.

>I did find newer firmware for the adaptec 2940u2w card 
>tho so perhaps I should upgrade that?

If you aren't having problems with your BIOS today, there is
no reason to flash the BIOS on teh 2940U2W.

>I will try turning off write cache - kernel config option right?

SCSI-Select option.

--
Justin
