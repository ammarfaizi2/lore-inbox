Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132832AbRC2U26>; Thu, 29 Mar 2001 15:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRC2U2j>; Thu, 29 Mar 2001 15:28:39 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:15555 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132832AbRC2U21> convert rfc822-to-8bit; Thu, 29 Mar 2001 15:28:27 -0500
Date: Thu, 29 Mar 2001 19:16:59 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: "Butter, Frank" <Frank.Butter@otto.de>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: WG: 2.4 on COMPQ Proliant
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B9E1@NTOVMAIL04>
Message-ID: <Pine.LNX.4.10.10103291902560.1515-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Mar 2001, Butter, Frank wrote:

> 2.2.16 claimes to find a ncr53c1510D-chipset, supported by
> the driver ncr53c8xx. Which kernel-param would be the correct one for this?

There is no specific kernel option apart configuring the NCR53C8XX and/or
the SYM53C8XX driver. (And not the 53c7,8xx driver as I have to repeat
since 5 years).

For the 53c1510D, you must ensure that the chip is configured for behaving
as a 53c8xx chip (and not as an intelligent controller).
To know about the 1510 configuration, you may check the PCI device id
claimed by the chip. Value 0xa is the expected value if the chip is
configured for 53c8xx mode.

Btw, I donnot know how to change the 1510 from intelligent mode to 53c8xx
mode and vice-versa. You may ask your vendor for that.

  Gérard.

> Frank
> 
> > -----Ursprüngliche Nachricht-----
> > Von: Butter, Frank 
> > Gesendet: Donnerstag, 29. März 2001 17:11
> > An: 'linux-kernel@vger.kernel.org'
> > Betreff: 2.4 on COMPQ Proliant
> > 
> > 
> > 
> > Has anyone experiences with 2.4.x on recent Compaq Proliant 
> > Servers (e.g. ML570)?
> > 
> > I've installed RedHat7 and it worked fine out of the box.
> > Except that the SMP-enabled kernel stated there was no 
> > SMP-board detected ;-/
> > For some reasons (Fibrechannel drivers and so on) I've compiled
> > 2.4.2 and installed it. Although I've compiled the support 
> > in, the NCR-SCSI-chip was not found and therefore no 
> > root-partition. It is a model supported by 53c8xx - detected 
> > by the original RedHat-kernel.  
> > 
> > For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> > with the same result. The SMP-board also was NOT detected by 2.4.2.
> > 
> > Any hint?
> > 
> > Frank
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


