Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWHJNAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWHJNAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWHJNAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:00:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:21776 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161243AbWHJNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:00:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=biFOgt/XFY6TyXGBNPCLrxdGGw02AZbwY+hM+NbkKAJ+iin3CNSrSfiKSvDFwLFP8PtsBbcRe9AjPsbAC7RsVHj3noWxoZqH7izj4FvUnBlGDd6yFn9+U/5jmKsUj8hrmuCP2sOuPyQGEyMWQXagrPoR0R0MzKDZlR/c2LqFD6w=
Message-ID: <62b0912f0608100600g54cd0797l2d96f59490542901@mail.gmail.com>
Date: Thu, 10 Aug 2006 15:00:03 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Helge Hafting" <helge.hafting@aitel.hist.no>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44DB2436.6080501@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <44DB2436.6080501@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Have you considered debian then?  That package system certainly
> have been able to keep many a system running for years and years.
> You never reinstall, just upgrade.

Sounds cool, I'll try that.
Thanks.

> Well, if you expect to keep a computer running for three years
> without human intervention - good luck to you!  Not only will there be
> new vulnerabilities and attacks via the internet in that time,

It's NATted, so it's basically unreachable unless you know how to get to it.

> there is also a substantial risk of hardware breakdown.

Hasn't happened yet.

> Disks in particular seems not to live much more than three years,
> and if you have several, the chance is bigger that one goes.

Fair enough, but I've got mdmonitor to send me an email when that happens.

> It is certainly possible to run debian and spend 5min per week
> on running "apt-get dist-upgrade" which installs anything that
> was upgraded since the last time.

Cool, a cron job should take care of that.

> And if you have many identical servers, then you know that when
> one upgrade went without problems the others will too.

Oh....  Sounds a bit like it's not really as good as you once said it was.

> > And voila, that difficult task of assessing in which order to do
> > things is out of the hands of distros like Red Hat, and into the
> > hands of those people who actually make the binaries.
>
> Not so easy.  You do not want to shut down md devices because
> samba is using them.

Definitely not, I want to shut down Samba because it's using a
filesystem, which is using a MD device.

> Someone else may run samba on a single harddisk and also have
> some md-devices that they take down and bring up a lot.

Fair enough.
I guess a dependency system would have to be more complicated, then,
taking into account which particular resources a process depends on,
not just which subsystem.

> So having samba generally depend on md doesn't work.

Right.

> Your setup need it, others may have different needs.
> That's why the initscripts are _scripts_, simple textfiles that
> administrators can manipulate without having to know C programming.

I'm not sure I buy your argumentation.  But I do acknowledge that
being able to modify init scripts, without having C knowledge is
definitely a plus, seeing as they're obviously often far from perfect.

> Learn to manipulate the initscripts then.

Yeah, I chould sit down and look at how Red Hat did their whole init thing.

OTOH, I don't really have time to dissect 'em and find what problem
they have.  I think I'll just switch distro and see if I have better
luck with something else.

> Changing the shutdown order really is as
> simple as renaming samba's script file

I have a feeling that this is not the problem.

After all, this should be something that every distro has gotten
right, it's not really an issue you have to think long about.

I think the problem occurs in the "sending processes the TERM/KILL
signal" phase.
Perhaps because one phase is initiated too early, before various
services such as Samba has shut down.

Anyway, let's all forget about the init scripts forthwith, they're not
really relevant for LKML I think.

Concentrate on the ext3 issue :-).
