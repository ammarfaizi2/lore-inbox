Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVJQVjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVJQVjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJQVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:39:53 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:14916 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932342AbVJQVjx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:39:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DG0iV+d64obJici6NruEAd93tthsmqD1p3K8CnSt9Mnt6UoP9A/459P4kL5mUPfXaOspiDd3f4qx+jWvi2E+HKTtJ7/nAQPjIPfZlOSttOBZ8X5vgtcPBamE3tMGdCUFlWXmCRd+JF0ld9JowQeSDCrh4+OTlb/iVukeMJVwsGA=
Message-ID: <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com>
Date: Mon, 17 Oct 2005 16:39:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20051017212721.GA8997@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <43539762.2020706@ens-lyon.org>
	 <20051017132242.2b872b08.akpm@osdl.org>
	 <20051017212721.GA8997@midnight.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > >
> > > Le 17.10.2005 00:41, Andrew Morton a écrit :
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > >
> > > > - Lots of i2c, PCI and USB updates
> > > >
> > > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > >
> > > > - Significant x86_64 updates
> > > >
> > > > - MD updates
> > > >
> > > > - Lots of core memory management scalability rework
> > >
> > > Hi Andrew,
> > >
> > > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > > .config is attached.
> > >
> > > Regards,
> > > Brice
>
> Where did get support for IBM TrackPoints into that kernel? It's
> certainly not in 2.6.14, and it's not in the -mm patch either ...
>

Yes it is. We merged it at the beginning of 2.6.14.. ;)

> That's likely the cause here, since the TP patch probably relies on
> non-dynamic allocation semantics.
>

It was converted but I am aftraid when Greg created sub-class devices
something broke a bit. Do you see the ugly names input core prints?

--
Dmitry
