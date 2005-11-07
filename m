Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVKGN7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVKGN7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKGN7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:59:54 -0500
Received: from [202.125.80.34] ([202.125.80.34]:60478 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S964820AbVKGN7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:59:53 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Comments on 2.6.10 schedule_timeout please
Date: Mon, 7 Nov 2005 19:27:38 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B13B2CE@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which version of 2.6.11 is most stable
Thread-Index: AcXjkZhOrF7iOkE1S/Sc9lZvQ6nMswACUzwgAAFt9JA=
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>,
       "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel Developers,

I have noticed the schedule_timeout behaving somewhat different as penned from the Linux 2.6 Oreelly books.
I have developed a SD card Driver for 2.6.10 kernel & it works fine.
I needed a hardware reg to update that take a time of 300ms. I have issued a call like..

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout (300*HZ/1000);

I guess schedule_timeout should calls the scheduler after ensuring that the current process is awakened at timeout
expiration.
But, when I finally use it I get a sufficient delay which looks like a looped delay not allowing the keyboard to print messages on the screen.

I verified it ...

1) with debug messages immediately before & after the schedule_timeout call.
2) Commenting the schedule_timeout call.

Can someone comment on the schedule_timeout please?

Regards,
Mukund Jampala

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mukund JB.
Sent: Monday, November 07, 2005 6:39 PM
To: Adrian Bunk
Cc: linux-kernel@vger.kernel.org
Subject: RE: Which version of 2.6.11 is most stable



Dear Adrian,

Thanks for the information.
Also Can you please give inputs regarding.....

I have an existing Linux 2.6.11 BSP for an AMD GX processor.
What would it take me to port the complete BSP to 2.6.12 kernel?
Can I prefer to work on 2.6.11 kernel which makes me get the system up in no time without any changes made?
I guess 2.6.11 kernel will work with just a recompilation over 2.6.11.12 kernel.

An inquisitive question about Linux kernels versioning ...
How do 2.6.(x).1 and 2.6.(x).12 kernels vary?

Regards,
Mukund Jampala


-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de]
Sent: Monday, November 07, 2005 5:22 PM
To: Mukund JB.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which version of 2.6.11 is most stable


On Mon, Nov 07, 2005 at 03:38:13PM +0530, Mukund JB. wrote:
> 
> Dear All,
> 
> I am in the phase of development of a Linux BSP for 2.6.11 kernel.
> Which version of 2.6.11 kernel can be called best stable? In general where do i get this king of info?
> I serched in the www.lwn.net but i failed to get the required info.

The latest, IOW 2.6.11.12 .

But note that the 2.6.11 branch is no longer maintained since kernel 
2.6.12 was released 5 months ago, and therefore lacks e.g. current 
security fixes.

> Regards,
> Mukund Jampala

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
