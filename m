Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWBFUEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWBFUEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBFUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:04:43 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:2902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbWBFUEl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:04:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rdCsn8rohDs20CM4I8IK6WJH0BzCXVk2kbfhWVi/nIgZfIzoCKIyqnB96cRBxY9AUuICdKIIzEKm85zD+pJLwdx0Eo6SYJcfO9rdgCAdzFhF2JkIcw/XDDTbL1ZC3D/sUkkU2R3IUaZjUaRwydtIEzBdbg15QbKV6IazHjsyh0w=
Message-ID: <9a8748490602061204n29fdfcc5o75970460b351b51e@mail.gmail.com>
Date: Mon, 6 Feb 2006 21:04:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Subject: Re: Linux drivers management
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
In-Reply-To: <200602062217.19697.yarick@it-territory.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1139250712.20009.20.camel@rousalka.dyndns.org>
	 <200602061002.27477.joshua.kugler@uaf.edu>
	 <200602062217.19697.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Yaroslav Rastrigin <yarick@it-territory.ru> wrote:
> Hi,
> >
> > I heartily agree with this!!
> >
> > I use two products that use out-of-tree drivers.  VMWare and NVidia cards.
> > Fortunately, the build processes for both are rather painless, but there have
> > been times when it has *not* been, and it was extremely frustrating.  I
> > remember when VMWare was not doing a good job of supporting 2.6 kernels and I
> > spent the better part of two days trying to track down a solution.  I finally
> > did, but it was a third party, non-VMWare, patch to the VMWare code that
> > fixed it so it would compile and run.  That's not what I consider convenience
> > for the non-technical user.  A non-technical user would not have been able to
> > do what I did, especially when they just want their software to work.
> And then think, why do you need to _build_ drivers in the first place.
> Wouldn't it be better to have one vmware.ko which insmod's with all 2.6 versions , from 2.6.0 to 2.6.16-rc2 ,
> and throw "upgrade pain" away completely ?
> >
> > I want to install my machine and have everything work.  Don't make me chase
> > all over the net trying to find a driver for my hardware.  If it's a network
> All over the net ? Again, you're proving stable API/ABI supporters nicely.
> If kernel has stable ABI, basic/default driver is included on installation CD, and all you need to do
> is to launch ./install-linux.sh from CD in your shell or click OK and enter your root password in GUI box.

Why should I have to bother with that?
It's a lot more convenient that my new kernel just "magically"
includes the driver for my hardware, and the latest version of that
driver even. No inserting cd, run install script, navigate through
installer etc crap.


> Newer/better driver - just go to device manufacturer's website, download installation package and install this driver.

1. You are assuming all users have internet connections and can do
that - not true.
2. Again, why should I have to go through the trouble of first finding
the manufacturers website, then find out where they keep the drivers,
then download and figure out how to install the driver?
3. What if the manufacturer goes out of business and the website disappears?
4. What happens when the manufacturer stops updating the driver? Even
with an almost 100% frozen driver API changes *will* happen over time
and the driver will eventually stop working - or, if the driver API is
kept *100%* frozen then the core kernel will steadily aquire a huge
amount of backwards compatibility cruft which will eventually become a
maintainance nightmare.


> Without rebuilding.

Users of distro kernels already have the in-kernel drivers prebuild for them.
Users of custom kernels have to build the core kernel anyway, buildign
a driver or two at the same time is no big deal.

> > (i.e. ethernet device) the driver had *better* be in the tree.  Trying to
> > download the driver to another computer, transferring, etc, is enough to make
> > me find another brand of network card.
> And what to do if you've bought new hardware, installed it and _voila_ - NO IN-TREE DRIVER exists ?

Then you bought the wrong hardware.


> Do you want every Linux user  going for shopping to nearest WalMart carry full linux hardware compatibility list printed out ?
> Or intree driver list ?

Users who prefer not to have hardware trouble would be wise to check
compatibility before purchasing. This goes not only for Linux, but for
any OS - and don't say "all hardware has manufacturer supplied drivers
for Windows" 'cos that's not true, and there are several incompatible
windows versions, just try loading WinXP drivers on Windows98 or a
WinNT driver on Windows Server 2003 or any other fun combination.


> > Latest kernel == latest driver.  No need for me to try to keep all my drivers
> > up to date.
> Wrong. Latest kernel is latest kernel. Latest driver is latest driver. They are different entities, and don't mix'em.
> >
When the driver is maintained in-tree, latest kernel == latest driver.


> > I sometimes delay kernel updates because I don't want to mess with updating my
> > NVidia and VMWare drivers.  This is *not* good for security.
> So who to blame ?

NVidia and VMWare obviously for not submitting Open Source drivers for
inclusion in mainline.


> Maybe, just look at those who don't want stable driver API ?
> > So I did.  Please put your driver in the tree.  It will be better for all
> > concerned.
> Please, don't force your preferences over others'

Nobody is forcing anybody to do anything. We are just not bending over
backwards for people who refuse to work with us in-tree. If someone
wants to maintain drivers out-of-tree they are perfectly free to do
so, they just don't get the bennefit of having their drivers
auto-updated when API's change and they don't get the bennefit of many
develoers improving their drivers, they have to do *all* the work
themselves - but that's their choice, noone forced it on them.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
