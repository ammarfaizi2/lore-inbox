Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTJ2TSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJ2TSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:18:25 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:24075 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261326AbTJ2TSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:18:22 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F79E@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'ross.alexander@uk.neceur.com'" <ross.alexander@uk.neceur.com>,
       Brad House <brad@mcve.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
Date: Wed, 29 Oct 2003 11:17:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ross, can you post the contents of /proc/interrupts, /proc/ide/amd74xx
and /proc/ide/ide*/config, and also the output of "hdparm -I /dev/hd*" for
each of your ATA / ATAPI devices?

If the PIO and UDMA modes are setup correctly I can't think of anything
inside the IDE driver that should be causing random lockups.  I'd be much
more suspicious of ACPI / APIC / interrupt setup.

-Allen

> -----Original Message-----
> From: ross.alexander@uk.neceur.com 
> [mailto:ross.alexander@uk.neceur.com] 
> Sent: Wednesday, October 29, 2003 6:35 AM
> To: Brad House
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
> 
> 
> Brad,
> 
> My problem is one of the infamous nforce2 hardlockups.  You 
> don't get any
> kernel panic or anything that useful.  The system just locks 
> up completely
> and has to be manually reset.
> 
> The problem is known to associate with IDE activity and is 
> thought (as far
> as I know) to originate somewhere in the IDE driver.
> 
> Cheers,
> 
> Ross
> 
> --------------------------------------------------------------
> -------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 
> 
> 
> 
> Brad House <brad@mcve.com>
> 10/29/2003 02:13 PM
>  
>         To:     ross.alexander@uk.neceur.com
>         cc:     Brad House <brad_mssw@gentoo.org>, 
> linux-kernel@vger.kernel.org
>         Subject:        Re: nforce2 stability on 2.6.0-test5 and 
> 2.6.0-test9
> 
> 
> Hmm, interesting. The patches I submitted were strictly
> for IDE/ATA133 improvements, apparently your problems don't
> lie there.  I'd assume this was a kernel panic you had, any
> output available that would tell you where it paniced ?
> 
> -Brad
> 
> ross.alexander@uk.neceur.com wrote:
> > Brad,
> > 
> > I'm running an ASUS A7N8X Deluxe mobo (nforce2 chipset) and still
> > getting hardlockups.  I applied your patch but my system 
> still locked
> > up after about a day.  However 2.6.0-test5 seems to be 
> stable.  I have
> > had my system up for over three weeks with APIC and ACPI turned on.
> > 
> > Just to let you know,
> > 
> > Ross
> > 
> > 
> --------------------------------------------------------------
> -------------------
> > Ross Alexander                           "We demand clearly defined
> > MIS - NEC Europe Limited            boundaries of uncertainty and
> > Work ph: +44 20 8752 3394         doubt."
> > 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
