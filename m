Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSA0CFY>; Sat, 26 Jan 2002 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSA0CFS>; Sat, 26 Jan 2002 21:05:18 -0500
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:14753 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287478AbSA0CFA>; Sat, 26 Jan 2002 21:05:00 -0500
Message-ID: <034501c1a510$44422590$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <pogosyan@phys.ualberta.ca>, <whitney@math.berkeley.edu>
Cc: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>,
        "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020124155853Z287177-13996+11274@vger.kernel.org> <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk> <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3C505702.7B665083@phys.ualberta.ca>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a  chipset)
Date: Thu, 24 Jan 2002 12:49:42 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I used a separate temperature sensor to come up with proper values
for lm_sensors to read the CPU temperature on my A7V (ver 1.01). After
testing lowest and highest temperatures, this what I came up with:

  compute    temp2     28.2+((@-18)*2), ((@-28.2)/2)+18

I know it looks weird, but it makes the "sensors" value for CPU temperate
match (within .5 degrees C) across the entire range I can test (which is
from full load on a 1GHz Thunderbird down to idle and using the old "lvcool"
patch).

----- Original Message -----
From: <pogosyan@phys.ualberta.ca>
To: <whitney@math.berkeley.edu>
Cc: "Rasmus Bøg Hansen" <moffe@amagerkollegiet.dk>; "LKML"
<linux-kernel@vger.kernel.org>
Sent: Thursday, January 24, 2002 11:48 AM
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
chipset)


> > Note that on this motherboard (and perhaps all ASUS Via chipset
> > motherboards, including the A7V133), one needs the following line in
> > /etc/sensors.conf to get reasonable lm_sensors CPU temperatures:
> >   compute temp2 @*2, @/2
> > This is as described at http://www2.lm-sensors.nu/~lm78/support.html
> > in Ticket 775.
> >
>
> I have ASUS A7V266-E (AS99127F chip) and lm_sensors 2.6.2
> shows 43 C for CPU without any additional lines in /etc/sensors.conf
>
> Which sounds reasonable.   However this temperature is rarely ever change
!
> I typically have 43.1,   sometimes 42.8   and that's it.   Even after 2-3
min
>
> compiles.    So something is wrong
>
>                 Dmitri
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

