Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUH0QLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUH0QLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUH0QK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:10:56 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:22697 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266364AbUH0QKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:10:46 -0400
Message-ID: <311601c904082709107a8c8475@mail.gmail.com>
Date: Fri, 27 Aug 2004 10:10:46 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: HDD LED doesn't light.
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <00b801c48a55$46a2e3b0$6401a8c0@northbrook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <fa.j6vg864.plk4g8@ifi.uio.no> <fa.e807bv7.klg10f@ifi.uio.no> <00b801c48a55$46a2e3b0$6401a8c0@northbrook>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an FYI... historically, the LED has been driven in PATA with a
signal known as /DASP, this is an active-low signal called "Drive
Active / Slave Present" and a PATA drive asserts this signal when
processing a command.

If I understand it right, in SATA, instead of a wire-based protocol,
we have a serialized packet-based protocol, so there was no driving of
an LED in the initial specification.  Revisions to the specification
have since commandeered one of the pins on the power connector for use
as a /DASP signal to drive an LED.  However, to do that you obviously
can't be using a MOLEX->SATA power adapter, you need a motherboard
that natively supports SATA.  The 3112 you mention attempts to be a
native SATA solution, it doesn't act merely as a PATA->SATA converter.
 Therefore, they may not have done the DASP- signal internally.

Another option would be one of the new 4+ port SATA RAID adapters that
has LEDs on the adapter board itself.

On Tue, 24 Aug 2004 21:40:33 -0600, Robert Hancock <hancockr@shaw.ca> wrote:
> I seem to remember hearing somewhere that some or all of the Silicon Image
> SATA chips have to control the HDD activity light output by twiddling some
> GPIO outputs in the driver, it's not inherently done in the hardware as with
> most controllers..
> 
> 
> 
> 
> ----- Original Message -----
> From: "Fernando O. Korndörfer" <fok@quatro.com.br>
> Newsgroups: fa.linux.kernel
> To: "Ben Skeggs" <d4rk74m4@intas.net.au>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, August 24, 2004 7:10 AM
> Subject: Re: HDD LED doesn't light.
> 
> > This seems to be a hardware problem, as I have similar hardware (Asus
> > A7N8x-e deluxe) and the HDD Led also stays off.
> > BTW, I'm using MS-Windows(R).
> >
> > Tell me something, you'r using SATA, right?
> >
> >
> > Ben Skeggs wrote:
> >
> >>Hello,
> >>
> >>No matter how much harddisk activity is occuring on my system, the
> >>harddisk LED stays off.  At first I thought I'd misconnected the lead, but
> >>under Windows the light is functional.
> >>
> >>This occurs on both my SATA harddisk and my PATA harddisk.
> >>
> >>SATA controller: Silicon Image sil3112
> >>PATA controller: NForce2
> >>Motherboard    : Abit NF7-S 2.0
> >>CPU            : AthlonXP 3000+
> >>
> >>The earliest kernel I've used with this hardware is 2.6.6, and the problem
> >>occurs right up to 2.6.8.1.
> >>
> >>I'm completely clueless as I was under the impression that the hardware
> >>controlled the LED.
> >>
> >>Could I please be CC'd any replies as I'm not subscribed to the list.
> >>
> >>Regards,
> >>Ben Skeggs
> >>-
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
