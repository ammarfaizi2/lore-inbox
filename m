Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSC1Qaj>; Thu, 28 Mar 2002 11:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSC1Qa2>; Thu, 28 Mar 2002 11:30:28 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:7430 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S293400AbSC1QaM>; Thu, 28 Mar 2002 11:30:12 -0500
Message-ID: <005201c1d675$ba168400$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Andre Hedrick" <andre@linux-ide.org>,
        "Benjamin LaHaise" <bcrl@redhat.com>,
        "Erik Andersen" <andersen@codepoet.org>, "Jos Hulzink" <josh@stack.nl>,
        "jw schultz" <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16qWI0-0007Hb-00@the-village.bc.nu>
Subject: Re: IDE and hot-swap disk caddies
Date: Thu, 28 Mar 2002 08:25:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was suggesting that there are common cases where
the electrical parts at the drive (single drive) end are
taken care of.

what comes before is an hdparm -b 2 (tristate),
then power off drive,  then yank it out. (if the
PCI chipset supports it, and the driver supplies a
control method)

The parts that are still rough are when you put it back
in, it doesn't have the benefit of the BIOS transfer
speed/type initialization, or the ide driver's bus scan.

Bottom line for me, I think there's enough merit to this
(although not 100% - you can only dress up frankenstein
so much) , and I'm working on cleanups, so please don't
remove the code from the next version, and anyone else
working on it, please continue, that's all.

Jeremy

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Jeremy Jackson" <jerj@coplanar.net>
Sent: Thursday, March 28, 2002 1:33 AM
Subject: Re: IDE and hot-swap disk caddies


> > -some very cheap IDE swap bays have a mechanical interlock
> > with the power switch.  Your turn the key, and the drive shuts
> > off, before you can pull it out.  power sequencing solved? don't
> 
> No - you also have to isolate the IDE bus
> 
> > -PCMCIA has electrical hot swap support...?
> 
> Yes - but PCMCIA is effectively hot swap ISA bus, the controller is on
> the pcmcia card - different ball game
> 
