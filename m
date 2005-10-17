Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVJQV63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJQV63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVJQV63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:58:29 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:52671 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751181AbVJQV63 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:58:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agKUpgoLPsX1c9ZmfU8eiggxpMwDT9fRPqqNhbxLNAd+6dMWjPwNtLrewKNWIVFpPHoTdypayHFVLB13e99WkkBR2taZ8um844BLF4/2xjngpJK96frtd6ITLybEHLUYSz+vQ9RjWHGGfoAx4SDqqIZR6bcgpHd1R/tLraDZq6E=
Message-ID: <d120d5000510171458y2b888f8fn13d3544778fd71b1@mail.gmail.com>
Date: Mon, 17 Oct 2005 16:58:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051017214820.GA5390@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <43539762.2020706@ens-lyon.org>
	 <20051017132242.2b872b08.akpm@osdl.org>
	 <20051017212721.GA8997@midnight.suse.cz>
	 <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com>
	 <20051017214820.GA5390@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Greg KH <greg@kroah.com> wrote:
> On Mon, Oct 17, 2005 at 04:39:52PM -0500, Dmitry Torokhov wrote:
> > On 10/17/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > > > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > > >
> > > > > Le 17.10.2005 00:41, Andrew Morton a ?crit :
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > > > >
> > > > > > - Lots of i2c, PCI and USB updates
> > > > > >
> > > > > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > > > >
> > > > > > - Significant x86_64 updates
> > > > > >
> > > > > > - MD updates
> > > > > >
> > > > > > - Lots of core memory management scalability rework
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > > > > .config is attached.
> > > > >
> > > > > Regards,
> > > > > Brice
> > >
> > > Where did get support for IBM TrackPoints into that kernel? It's
> > > certainly not in 2.6.14, and it's not in the -mm patch either ...
> > >
> >
> > Yes it is. We merged it at the beginning of 2.6.14.. ;)
> >
> > > That's likely the cause here, since the TP patch probably relies on
> > > non-dynamic allocation semantics.
> > >
> >
> > It was converted but I am aftraid when Greg created sub-class devices
> > something broke a bit. Do you see the ugly names input core prints?
>
> The "//" stuff you mean?  Did I do that?
>

Not directly. I was trying to make names look "nice" but when you
moved stuff around they stopped being nice ;) Although that name in
front of double "/" - it should not be there... it was supposed to be
"%s as %s/%s", somehow I screwed that up.

Hopefully I'll have some time tonight to investigate further.

--
Dmitry
