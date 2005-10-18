Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVJRGmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVJRGmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVJRGmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:42:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:12190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751441AbVJRGmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:42:50 -0400
Date: Mon, 17 Oct 2005 23:42:16 -0700
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051018064216.GA11484@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org> <20051017212721.GA8997@midnight.suse.cz> <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com> <20051017214820.GA5390@kroah.com> <d120d5000510171458y2b888f8fn13d3544778fd71b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000510171458y2b888f8fn13d3544778fd71b1@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:58:28PM -0500, Dmitry Torokhov wrote:
> On 10/17/05, Greg KH <greg@kroah.com> wrote:
> > On Mon, Oct 17, 2005 at 04:39:52PM -0500, Dmitry Torokhov wrote:
> > > On 10/17/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > > On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > > > > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > > > >
> > > > > > Le 17.10.2005 00:41, Andrew Morton a ?crit :
> > > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > > > > >
> > > > > > > - Lots of i2c, PCI and USB updates
> > > > > > >
> > > > > > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > > > > >
> > > > > > > - Significant x86_64 updates
> > > > > > >
> > > > > > > - MD updates
> > > > > > >
> > > > > > > - Lots of core memory management scalability rework
> > > > > >
> > > > > > Hi Andrew,
> > > > > >
> > > > > > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > > > > > .config is attached.
> > > > > >
> > > > > > Regards,
> > > > > > Brice
> > > >
> > > > Where did get support for IBM TrackPoints into that kernel? It's
> > > > certainly not in 2.6.14, and it's not in the -mm patch either ...
> > > >
> > >
> > > Yes it is. We merged it at the beginning of 2.6.14.. ;)
> > >
> > > > That's likely the cause here, since the TP patch probably relies on
> > > > non-dynamic allocation semantics.
> > > >
> > >
> > > It was converted but I am aftraid when Greg created sub-class devices
> > > something broke a bit. Do you see the ugly names input core prints?
> >
> > The "//" stuff you mean?  Did I do that?
> >
> 
> Not directly. I was trying to make names look "nice" but when you
> moved stuff around they stopped being nice ;) Although that name in
> front of double "/" - it should not be there... it was supposed to be
> "%s as %s/%s", somehow I screwed that up.
> 
> Hopefully I'll have some time tonight to investigate further.

A simple:
	cat /sys/class/input/input1/event1/name
causes this to happen too.

That's my fault, I'll work on fixing that.

thanks,

greg k-h
