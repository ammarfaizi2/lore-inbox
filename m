Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSGNXBV>; Sun, 14 Jul 2002 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGNXBU>; Sun, 14 Jul 2002 19:01:20 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:3213 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S317209AbSGNXBT> convert rfc822-to-8bit;
	Sun, 14 Jul 2002 19:01:19 -0400
Date: Mon, 15 Jul 2002 01:03:59 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: apm power_off on smp
In-Reply-To: <1026687339.2077.15.camel@bip>
Message-ID: <Pine.GSO.4.30.0207150101150.27346-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, all I want is poweroff.
I understand that apm is not smp safe, and pretty much all of it is
disabled in smp mode.

What i do not understand is why the poweroff functionality is disabled by
default.


On 15 Jul 2002, Xavier Bestel wrote:

> Le lun 15/07/2002 à 00:30, Kelledin a écrit :
> > > APM's poweroff function is explicitly turned off on smp systems by
> > > default. Could someone tell me please what is the reason for that?
> >
> > (as of kernel 2.4.18) pretty much *all* APM functions are disabled on SMP
> > kernels--the simple reason being that APM isn't SMP safe, and making it SMP
> > safe is not a trivial task.
> >
> > If all you want is a soft power-off, you're better off using ACPI (assuming
> > your system supports it).  Since this is probably a desktop (and not a
> > laptop), I doubt there's much else you want in the way of power management...
>
> ACPI is still very broken for some chipsets (VIA 686b), while apm works
> well for this task (powering off a machine doesn't need much SMP
> protection).
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
pozsy

