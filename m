Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTD2Sl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTD2Sl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:41:59 -0400
Received: from adsl-68-74-104-142.dsl.klmzmi.ameritech.net ([68.74.104.142]:53511
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id S262128AbTD2Sl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:41:57 -0400
From: Tabris <tabris@sbcglobal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Tue, 29 Apr 2003 14:48:07 -0400
User-Agent: KMail/1.5
Cc: Thomas Backlund <tmb@iki.fi>
References: <200304282112.47061.tabris@sbcglobal.net>
In-Reply-To: <200304282112.47061.tabris@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291448.07909.tabris@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 28 April 2003 09:58 pm, Andre Hedrick wrote:
>> NO ATAPI DMA!
>>
>> I will not write the driver core to attempt to support the various
>> combinations.  The ATAPI DMA engine space is used support 48bit.
>> Use the onboard controller for ATAPI.
>> Andre Hedrick
>> LAD Storage Consulting Group
> 
> Can I object that it came built onto the board? okok... i'll take that
> as a no for now...
> 
>> Tho i'm still not quite sure how it makes a diff to be honest, unless
>> you mean that the Promise and HPT will never be supported for DMA?
>> 
>> and the only other thing i should say is that altho i'm not exactly a
>> n00b, the average user WILL expect it to work.
>> 
>> can i expect this to be fixed by 2.6? (yeah, i know... 2.4-ac-ide 
>>code is similar to 2.5-ide code)
>> --
>> tabris

>The point is that you should put your ATAPI device (in this case the 
>cd-rom)
>on the VIA controllers, and place the hdd's on the promise controller,
>since dma is supported for hdd's...

>This is also their intended primary functions by the manufacturers...,
>for example the HPT370 controller with bios version >1.1.x.xxx does
>not have ATAPI support (atleast officially, I haven't tried it)
>
>
>Thomas

So, are you telling me that DMA for both my hard drives, and my CD-R/Ws 
will work, if i put my HDs on the PDC20265 controller, and my CD-R/W on 
the VIA?

or will i lose DMA on the hard drives in this way, losing performance?

the second solution, tho one _I_ could probably live with, is still a 
problem, especially for those of us who want to sell GNU/Linux to our 
customers as a 'better' solution.

btw, please cc: me in your replies, as I no longer am able to subscribe 
to the linux-kernel list. this reply i had to hack by hand from 
marc.theaimsgroup

--
tabris
-
Why don't you fix your little problem... and light this candle?
		-- Alan Shepherd, the first man into space, Gemini program

