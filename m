Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVLTJbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVLTJbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 04:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVLTJbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 04:31:17 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:48103 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750848AbVLTJbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 04:31:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X2AwM6iWasGF2jzwNjedvjcytwvkSB92EWqI+ln3PW3/F/dOpnLDysx9UOBvlp599ApHBVcNCk9dRzL8JIw1KLbS/raqa56OeUo6ItpuoEZYi9JUpjS16UQNNFdyrekPcGzyJq5iB9ljbj47DqXfpRi8XQeSWwAd8juecOQsi5Q=
Message-ID: <2cd57c900512200131l4ff29837o@mail.gmail.com>
Date: Tue, 20 Dec 2005 17:31:12 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: sander@humilis.net
Subject: Re: [RFC] Let non-root users eject their ipods?
Cc: Willy Tarreau <willy@w.ods.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de,
       vandrove@vc.cvut.cz, aia21@cam.ac.uk, akpm@osdl.org
In-Reply-To: <20051220085653.GA3137@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135047119.8407.24.camel@leatherman>
	 <20051220051821.GM15993@alpha.home.local>
	 <2cd57c900512192206g7292cb1m@mail.gmail.com>
	 <20051220085653.GA3137@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/20, Sander <sander@humilis.net>:
> Coywolf Qi Hunt wrote (ao):
> > 2005/12/20, Willy Tarreau <willy@w.ods.org>:
> > > On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
> > > >       I'm getting a little tired of my roommates not knowing how to safely
> > > > eject their usb-flash disks from my system and I'd personally like it if
> > > > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > > > suid the eject command, but that seems just as bad as changing the
> > > > permissions in the kernel (eject wouldn't be able to check if the user
> > > > has read/write permissions on the device, allowing them to eject
> > > > anything).
> > >
> > > You may find my question stupid, but what is wrong with umount ? That's
> > > how I proceed with usb-flash and I've never sent any eject command to
> > > it (I even didn't know that the ioctl would be accepted by an sd device).
> >
> > IMHO, umount doesn't guarantee sync, isn't it?

Actually I was think umount(2), since this is the kernel list, but off
topic here.

>
> I'm pretty sure it does :-)

That is because: usually your removable media is not the file system
root, hence umount(8) can return successfully only if no processes are
busy working on it.

If you boot from or chroot/pivot into a removable media, and you
remount it ro, and unplug it, then you may lose data.

-- coywolf

>
> Anyway, that is how I treat all usb/firewire disks, and I've never lost
> data. Just umount and unplug when the prompt returns.
>
> --
> Humilis IT Services and Solutions
> http://www.humilis.net
>
