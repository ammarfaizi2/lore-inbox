Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265845AbRF2PKz>; Fri, 29 Jun 2001 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265891AbRF2PKe>; Fri, 29 Jun 2001 11:10:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42759 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265845AbRF2PKa>; Fri, 29 Jun 2001 11:10:30 -0400
Subject: Re: Qlogic Fiber Channel
To: christophe.barbe@lineo.fr (=?ISO-8859-1?Q?christophe_barb=E9?=)
Date: Fri, 29 Jun 2001 16:09:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010629151910.C27847@pc8.lineo.fr> from "=?ISO-8859-1?Q?christophe_barb=E9?=" at Jun 29, 2001 03:19:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fzu8-0000SK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> =46rom my point of view, this driver is sadly broken. The fun part is t=
> hat
> the qlogic driver is certainly based on this one too (look at the code,=
>  the
> drivers differs not so much).=20

And if the other one is stable someone should spend the time merging the
two.

> IMHO the qlogicfc driver should be removed from the kernel tree and per=
> haps
> replaced by the last qlogic one. We then lost the IP support but this i=
> s a
> broken support.

For 2.5 that may wellk make sense. Personally I'd prefer someone worked out
why the qlogicfc driver behaves as it does. It sounds like two small bugs
nothing more

1.	That the FC event code wasnt updated from 2.2 so now runs
	with IRQ's off when it didnt expect it

2.	That someone has a slight glitch in the queue handling.
> 
