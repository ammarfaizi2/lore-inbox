Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTAJOg4>; Fri, 10 Jan 2003 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAJOgz>; Fri, 10 Jan 2003 09:36:55 -0500
Received: from [209.39.166.171] ([209.39.166.171]:33547 "EHLO mail.roland.net")
	by vger.kernel.org with ESMTP id <S265039AbTAJOgy>;
	Fri, 10 Jan 2003 09:36:54 -0500
Message-ID: <000f01c2b8b6$e870f230$2002a8c0@jimws>
From: "Jim Roland" <jroland@roland.net>
To: <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
References: <004d01c2b873$44156d80$2002a8c0@jimws> <200301100916.h0A9Gus15400@Port.imtp.ilyichevsk.odessa.ua>
Subject: Re: ksoftirqd_CPU0 causing severe latency
Date: Fri, 10 Jan 2003 08:45:23 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I profile and collect interrupt info?  I have not tried to do this
w/o iptables, because iptables is required for this box to do what it does.
I'm not a programmer, so looking at eepro100's code will not do me much
good.  :)


----- Original Message -----
From: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Jim Roland" <jroland@roland.net>; <linux-kernel@vger.kernel.org>
Sent: Friday, January 10, 2003 3:16 AM
Subject: Re: ksoftirqd_CPU0 causing severe latency


> On 10 January 2003 08:41, Jim Roland wrote:
> > I am running a RH7.2 router with kernel 2.4.18-19.7.x and upgraded
> > from 2.4.18-17 in hopes this would fix the problem, but it hasn't.
> >
> > The problem I am experiencing is that after a while, the system
> > begins to lag badly, and running "ps -ax" writes to a SSH console
> > like a terminal running at 14.4kbps.  This only seems to have
> > occurred after the box started procesing a network load.
> >
> > The box is a router, with a Supermicro (model=?) motherboard with
> > embedded Intel EEpro/100 NICs using the eepro100 module.  This box is
> > also serving as an iptables filter for the network as well.  It's
> > processing approximately 60Mbps sustained traffic outbound, and about
> > 10-15Mbps traffic inbound.
>
> That's not a small figure :)
>
> > The box also lags SEVERLY when I'm trying to use the state matching
> > in the kernel (as module), lagging badly when ip_conntrack is loaded.
> >
> > In contrast, I am running the same OS and kernel versions on another
> > box (same modules) and am not having the same problem (it is only
> > handling about 5Mbps sustained out, and 1Mbps sustained inbound).
> >
> > I need HELP!
>
> Profile your box. (We need to know where it spends most of CPU time).
> Send profile data to the list.
>
> Also collect interrupt rate info.
>
> You may also look into Intel EEpro/100 driver's interrupt handler code.
>
> Does is lag that bad without iptables?
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

