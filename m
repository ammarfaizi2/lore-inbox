Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUCFVqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 16:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUCFVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 16:46:54 -0500
Received: from vsmtp12.tin.it ([212.216.176.206]:55437 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S261718AbUCFVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 16:46:50 -0500
Message-ID: <000701c403bc$245d0f30$2101a8c0@melchiorsi1sy1>
From: "Maggio" <voloterreno@tin.it>
Cc: <linux-kernel@vger.kernel.org>
References: <fa.aoloalv.146ee19@ifi.uio.no> <4049EC1E.6010203@myrealbox.com> <000801c4039f$9f7e6280$2101a8c0@melchiorsi1sy1> <001701c403b4$42ec5e40$2101a8c0@melchiorsi1sy1>
Subject: Re: IRQ USB , freezes with ABIT KV7
Date: Sat, 6 Mar 2004 21:46:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I quote myself again , but I think to have understood why my system
hangup at installation .

The default IRQ that my motherboard sets for USB 2.0 controller and the
Sound Card is "12" if no PS/2 mouse is plugged-in (generally IRQ12 is
reserved to PS/2 mouse) , but the PS/2 Mouse port is always present , also
if no mouse is plugged-in , and the linux PS/2 mouse driver occupies the IRQ
12 when loads , so , when it's the time of the USB 2.0 controller driver the
booting hangs up.

Is not possible adding a feature in  the kernel , that if the PS/2 driver
doesn't find any mouse plugged in the port just leve free the IRQ12 instead
of catching it up? (if this feature is not already implemented , but it is
doesn't work for me)

Marcello
>
> ----- Original Message -----
> From: "Maggio" <voloterreno@tin.it>
> To: "walt" <wa1ter@myrealbox.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Saturday, March 06, 2004 6:22 PM
> Subject: Re: IRQ USB , freezes with ABIT KV7
>
>
> >
> > ----- Original Message -----
> > From: "walt" <wa1ter@myrealbox.com>
> > To: "Maggio" <voloterreno@tin.it>
> > Cc: <linux-kernel@vger.kernel.org>
> > Sent: Saturday, March 06, 2004 4:19 PM
> > Subject: Re: IRQ USB , freezes with ABIT KV7
> >
> >
> > > Maggio wrote:
> > > >
> > > > Hi all ,
> > > >
> > > > I've recently switched from an MSI KT4 Ultra motherboard to an Abit
> KV7
> > > > board ,and the system worked well until today that I'm attempting to
> > > > reinstall the system .
> > > >
> > > > It seems that the USB make some conflicts in IRQ , infact , if I
> enable
> > > > the option "Allocate IRQ to USB" in the BIOS , I'm unable to start
any
> > > > Installation CD of any distribution , the booting simply hangup .
> > >
> > > Is there a BIOS setting for 'USB Legacy Support'?
> >
> > I've checked in the BIOS and doesn't seem to exist (I have Award BIOS )
,
> > maybe it has another name? But anyway doesn't seem to exist nothing
> similar
> > .
> >
> > Please help  (I've tried GENtoo, Slack and CRUX)
> >
> > Marcello
> >
>
>
> seems that changing in the BIOS the options:
>
> USB mouse Support Via :
>
> and
>
> USB Keyboard Support Via :
>
> from [OS] to [BIOS] removed the problem . But why linux gives this problem
> and FBSD no? What this option implies ? I've noticed that the IRQ of the
USB
> 2.0 controller changes from 12 to 5 (12 was shared with the Sound Card) ,
> and the other 4 UHCI devices continue to share IRQ 10 and 11 between them
.
>
> Please , make me light on this ....
>
> Thanks
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

