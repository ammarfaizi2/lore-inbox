Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSFEIMY>; Wed, 5 Jun 2002 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSFEIMX>; Wed, 5 Jun 2002 04:12:23 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:46253 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S313314AbSFEIMV>; Wed, 5 Jun 2002 04:12:21 -0400
Message-ID: <3CFDC7B1.450B625B@eed.ericsson.se>
Date: Wed, 05 Jun 2002 10:11:29 +0200
From: "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
Organization: Ericsson EuroLab
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
CC: Andrew Morton <akpm@zip.com.au>, john slee <indigoid@higherplane.net>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <3CFB21C5.27BBFB66@aitel.hist.no> <Pine.LNX.4.44.0206031050170.10836-100000@netfinity.realnet.co.sz> <20020603125752.GE12322@higherplane.net> <3CFBCDBD.DF675D57@zip.com.au> <3CFBFD41.2020505@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > That driver is solid for SMP.  It's possible that the BP6
> > is losing its IRQ routing assignments, or the APIC is
> > getting stuck.  We had extensive problems with that last
...
> > It seems to affect network cards most because they typically
> > generate the most interrupts.
> > Try booting the machine with the `noapic' option.
Even on an UP and no-MP-capable K6? IMHO this won't help (at least
myself).
 
> and myself) talked about my 3C905C-TX not willing to share an
> interrupt with my SBLive!...
> I've spotted the same problem, this time sharing an interrupt
> between my 3C905C-TX and an Intel i82559 10/100 ethernet
> controller (kernel is 2.4.19pre7).
I forgot to mention that there is only the 3c905 and a gfxcard (AGP) in
the box, no interrupts shared - I THOUGHT!
Then a quick lspci -v revealed both sharing IRQ 11. Will try to reassign
IRQs.

Thank you! :-)
Hope this is solved.
-- 
Ronny T. Lampert		email: Ronny.Lampert@eed.ericsson.se
System Administrator		voice: +49 911 255 1214
Ericsson Eurolab Deutschland	fax:   +49 911 255 1960
Nuernberg, Germany
