Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVFVJbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVFVJbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVFVJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:27:59 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:40692 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262924AbVFVJYC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:24:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mykAJ5VcWsA6j+Py/KJNYcYmHMbPsadQjFPbJdYrQYEhGLgoAnI/smccSOmzAf8UNrvR7fzuHBXGG/2qrfXGW6RnIsjDBueTYj5VH130/fNQWyzz2Gg/KTLBHXbhTs/HoeAX5mCU1PCJuroH7YvIJbvRvSM3srHK2hEATU1D6V8=
Message-ID: <2cd57c9005062202237cd4ece9@mail.gmail.com>
Date: Wed, 22 Jun 2005 17:23:58 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1119429466l.8047l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621222419.GA23896@kroah.com>
	 <20050621.155919.85409752.davem@davemloft.net>
	 <20050622041330.GB27716@suse.de>
	 <20050621.214527.71091057.davem@davemloft.net>
	 <2cd57c900506212323ca68045@mail.gmail.com>
	 <1119429466l.8047l.1l@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, J.A. Magallon <jamagallon@able.es> wrote:
> 
> On 06.22, Coywolf Qi Hunt wrote:
> > On 6/22/05, David S. Miller <davem@davemloft.net> wrote:
> > > From: Greg KH <gregkh@suse.de>
> > > Date: Tue, 21 Jun 2005 21:13:30 -0700
> > >
> > > > On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> > > > > From: Greg KH <gregkh@suse.de>
> > > > > Date: Tue, 21 Jun 2005 15:24:19 -0700
> > > > >
> > > > > However, this does mean I do need to reinstall a couple
> > > > > debian boxes here to something newer before I can continue
> > > > > doing kernel work in 2.6.x on them.
> > > >
> > > > Those boxes rely on devfs?
> > >
> > > Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
> > > kernel config the machine won't boot. :-)
> > >
> > > > Can't you just grab the "static dev" debian package and continue on?
> > > > I'm sure there is one in there somewhere (don't really know for sure,
> > > > not running debian anywhere here, sorry.)
> > > >
> > > > Or how about a tarball of a /dev tree?  Would that help you out?
> >
> > There's /sbin/MAKEDEV on debian.
> >
> > >
> > > I don't know if Debian has such a package.
> > >
> > > Don't worry, I'll take care of this by simply reinstalling
> > > and thus moving to udev.
> >
> > Moving to udev is right. Still you need a "static dev" in case your
> > udev not working.
> >
> > Use /sbin/MAKEDEV from makedev package.
> >
> 
> A nice addition to udev package would be an standard minimal /dev tree
> to allow booting till init and running udev as the first thing...
> A tar.gz you could just unpack on a new box or on an initrd.
> 
> ;)


I guess we've already got one in initramfs.
The "static" /dev is still necessary. I once killed my udevd, and the
static /dev revealed.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
