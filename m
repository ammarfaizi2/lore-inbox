Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264353AbRFOLRP>; Fri, 15 Jun 2001 07:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264347AbRFOLRF>; Fri, 15 Jun 2001 07:17:05 -0400
Received: from [164.164.82.20] ([164.164.82.20]:42734 "EHLO subexgroup.com")
	by vger.kernel.org with ESMTP id <S264341AbRFOLQw>;
	Fri, 15 Jun 2001 07:16:52 -0400
From: "Anil Kumar" <anilk@subexgroup.com>
To: "bert hubert" <ahu@ds9a.nl>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Kip Macy" <kmacy@netapp.com>, <ognen@gene.pbi.nrc.ca>,
        <linux-kernel@vger.kernel.org>
Subject: RE: threading question
Date: Fri, 15 Jun 2001 16:59:00 +0530
Message-ID: <NEBBIIKAMMOCGCPMPBJOEEICCFAA.anilk@subexgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010614210138.A15912@home.ds9a.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
X-Return-Path: anilk@subexgroup.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since while using only a small subset of primitives provided by the pthreads
the burden for the other primitive maintanence is much more so i too feel
when we use only a small part its better to implement in our own requiredd
way for performance issues.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of bert hubert
Sent: Friday, June 15, 2001 12:32 AM
To: Alan Cox
Cc: Kip Macy; ognen@gene.pbi.nrc.ca; linux-kernel@vger.kernel.org
Subject: Re: threading question


On Thu, Jun 14, 2001 at 07:28:32PM +0100, Alan Cox wrote:

> There are really only two reasons for threaded programming.
>
> - Poor programmer skills/language expression of event handling

The converse is that pthreads are:

 - Very easy to use from C at a reasonable runtime overhead

It is very convenient for a userspace coder to be able to just start a
function in a different thread. Now it might be so that a kernel is not
there to provide ease of use for userspace coders but it is a factor.

I see lots of people only using:
	pthread_create()/pthread_join()
	mutex_lock/unlock
	sem_post/sem_wait
	no signals

My gut feeling is that you could implement this subset in a way that is both
fast and right - although it would not be 'pthreads compliant'. Can anybody
confirm this feeling?

Regards,

bert

--
http://www.PowerDNS.com      Versatile DNS Services
Trilab                       The Technology People
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


