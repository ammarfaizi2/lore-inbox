Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293004AbSBVVhr>; Fri, 22 Feb 2002 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293006AbSBVVhh>; Fri, 22 Feb 2002 16:37:37 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:26123 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293004AbSBVVhY>; Fri, 22 Feb 2002 16:37:24 -0500
Date: Fri, 22 Feb 2002 22:34:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: G?rard Roudier <groudier@free.fr>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222223444.A7238@suse.cz>
In-Reply-To: <20020222154011.B5783@suse.cz> <20020221211606.F1418-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221211606.F1418-100000@gerard>; from groudier@free.fr on Thu, Feb 21, 2002 at 09:31:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 09:31:20PM +0100, G?rard Roudier wrote:

> > On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:
> >
> > > > I think it'd be even better if the chipset drivers did the probing
> > > > themselves, and once they find the IDE device, they can register it with
> > > > the IDE core. Same as all the other subsystem do this.
> > >
> > > Please send me your scsi subsystem then ;)
> >
> > I must agree that SCSI controllers aren't doing their probing in a
> > uniform and clean way even on PCI, but at least they do the probing
> > themselves and don't have the mid-layer SCSI code do it for them like
> > IDE.
> 
> The problem that bites us since years is not the PCI probing, but the
> order in which SCSI devices are attached. Microsoft O/Ses have been smart
> enough for ordering hard disks in the way user sets it from system setup,
> but Unices just messed up the thing.

For some adapters, this is possible, for other it is not (at all). You
happen to be a maintainer of one for which it is possible, and thus your
point of view is quite different from mine - mine comes from USB and
other parts of the device world, where no order can even be defined.

And because of that, I do not think that having the host adapters decide
what device gets what number is a good idea. They should provide the
information if they have it, but the final decision should definitely be
done in userspace, by the hotplug agent.

Ie. it should be configurable.

-- 
Vojtech Pavlik
SuSE Labs
