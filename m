Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUBPGPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUBPGPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:15:18 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:26857 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265350AbUBPGPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:15:11 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Bill Anderson <banderson@hp.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: system (not HW) clock advancing really fast
Date: Mon, 16 Feb 2004 14:24:49 +0800
User-Agent: KMail/1.5.4
References: <1076910368.25980.12.camel@perseus>
In-Reply-To: <1076910368.25980.12.camel@perseus>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161424.49242.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this somtetimes when using ntpd doing step time update
resulting in silly values in /etc/adjtime . 

# mv /etc/adjtime /tmp 
# hwclock --systohc

and see if it goes away.

Regards
Michael

On Monday 16 February 2004 13:46, Bill Anderson wrote:
> Kernel version: 
> 	2.4.24-xfs
> 	We've apaprently had this problem for a while
> 
> Ok, I've got an HP LPr machine, dual 700MHz intel machine that has it's
> system clock gaining seconds very quickly. This, I am told, has been
> happening for several kernels.
> 
> At first, others on the team insisted it was the hardware clock at
> fault, as rebooting the system gives the appearance of fixing it.
> However, the system is currently having this issue, and the HW clock is
> actually keeping accurate time, as I expected.
> 
> The time gain is no consistent. It can gain 3 seconds in one, or 12 in
> 11, but it always runs fast. This time speedup is to much for ntp to
> keep up with. If I sync from hwclock or ntpdate every second, I'm
> correcting about 1-3 seconds each time. This is a mail server, so I am
> sure you can appreciate the need for accurate timestamps. ;)
> 
> I've seen many messages in the archives about *losing* time, but only a
> few about gaining it. Personally, I am opposed to the "just reboot it"
> mentality; one reason I run Linux.
> 
> Given that we are talking about system clock, not HW, and that this
> happens with or w/o ntpd/ntpdate, I am suspecting something in the
> kernel. Also, this thread leads me there too:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105465355622844&w=2
> 
> 
> Am I off base here? I can probably keep the hwclock sync method running
> for a day or so before I'm forced to reboot it, so if there is anything
> you need to know or want me to try while it is in this state, let me
> know.
> 
> This address is not subscribed, so please cc me on responses.
> 
> Thanks,
> 
> Bill
> 
> 
> 
> 
> -- 
> Bill Anderson <banderson@hp.com>
> Red Hat Certified Engineer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

