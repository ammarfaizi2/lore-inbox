Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRFHEJo>; Fri, 8 Jun 2001 00:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbRFHEJe>; Fri, 8 Jun 2001 00:09:34 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:63706 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S261309AbRFHEJ0>; Fri, 8 Jun 2001 00:09:26 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FD67D.8DFDAE58@pcsystems.de>
	<3B1FDB64.1AB850CF@fc.hp.com> <3B1FDD9F.49E55D9B@pcsystems.de>
	<20010608004141.A1534@werewolf.able.es>
Organization: none
Date: 08 Jun 2001 00:08:15 -0400
In-Reply-To: <20010608004141.A1534@werewolf.able.es>
Message-ID: <m2ae3j62c0.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> On 06.07 Nico Schottelius wrote:
> > >
> > > Based upon the lspci output you posted earlier, aic7880 has a single
> > > SCSI bus.
> > 
> > Oh. That could really be a problem.. I though having two different
> > connectors on the board would make two different buses..
> > I must have been wrong.
> > 
> > > So you must mean two internal connectors. Both of your devices
> > > (HD and Tape) do show up on the same bus during scan. Since you have
> > > connected devices to both connectors on the card, you must terminate
> > > both devices.
> > 
> > Okay, so far I understood.
> > 
> 
> And, AFAIK, the controller stands in the bus between the disk and the tape,
> so you should terminate both

yes.

> AND disable the controller internal terminator

no.  you should terminate high-on low-off.  how can the 50 pin end
terminate the extra wires of the 68 conductor wide side?

> or leave it in AUTO mode.

this might well work.  if not, set host adapter/controller to
terminate high-on low-off.

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
