Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbRF2Pgu>; Fri, 29 Jun 2001 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266104AbRF2Pgk>; Fri, 29 Jun 2001 11:36:40 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:29446 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S266101AbRF2Pge>; Fri, 29 Jun 2001 11:36:34 -0400
Date: Fri, 29 Jun 2001 17:36:31 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Qlogic Fiber Channel
Message-ID: <20010629173631.A15608@pc8.lineo.fr>
In-Reply-To: <20010629151910.C27847@pc8.lineo.fr> <E15Fzu8-0000SK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15Fzu8-0000SK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on ven, jun 29, 2001 at 17:09:56 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le ven, 29 jun 2001 17:09:56, Alan Cox a écrit :
> > From my point of view, this driver is sadly broken. The fun part is
that
> > the qlogic driver is certainly based on this one too (look at the code,
> > the drivers differs not so much).
> 
> And if the other one is stable someone should spend the time merging the
> two.

That what I would like to try but It seems impossible without an
IP-enhanced firmware. I could try with the old firmware but I believe that
the new code from QLogic use some features that are only in recent
firmware.

> 
> > IMHO the qlogicfc driver should be removed from the kernel tree and
> > perhaps replaced by the last qlogic one. We then lost the IP support
> > but this is a broken support.
> 
> For 2.5 that may wellk make sense. Personally I'd prefer someone worked
> out
> why the qlogicfc driver behaves as it does. It sounds like two small bugs
> nothing more
> 
> 1.	That the FC event code wasnt updated from 2.2 so now runs
> 	with IRQ's off when it didnt expect it
> 
> 2.	That someone has a slight glitch in the queue handling.

This driver is already buggy under kernel 2.2. This driver is a well known
source of problems in the GFS mailing lists.

I believe that the better thing to do is to use the qlogic driver. If we
manage to get a recent IP-enhanced firmware we could rewrite the missing IP
code. Half of the job is already done in the source of this driver.

I didn't manage to reach the good person from qlogic. Perhaps someone would
have better results.

Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
