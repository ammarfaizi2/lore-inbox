Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbUCVWgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUCVWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:36:18 -0500
Received: from napo.bezeqint.net ([192.115.104.9]:7319 "EHLO napo.bezeqint.net")
	by vger.kernel.org with ESMTP id S263724AbUCVWgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:36:11 -0500
Date: Tue, 23 Mar 2004 00:34:56 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040322223456.GB2549@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com>
 <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com>
	 <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405C2AC0.70605@stesmi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:28:00PM +0100, Stefan Smietanowski wrote:
> >>>there is one. Nothing uses it
> >>>(sysconf() provides this info)
> >>
> >>Seems to me that it would be fairly trivial to modify those programs 
> >>(that should use this mechanism but don't) to use it?  So why should 
> >>they be allowed to dictate kernel behaviour?
> >
> >
> >quality of implementation; for example shell scripts that want to do
> >echo 500 > /proc/sys/foo/bar/something_in_HZ
> >...
> >or /etc/sysctl.conf or ...
> >
> 
> Then write a simple program already. How hard is it to write a program
> that does a sysconf() and returns (as ascii of course) just the
> value of HZ? Then do some trivial calculation off of that.
> 
> HZ=$(gethz)
> 
> If your 500 was 5 seconds, do
> 
> TIME=$[HZ*5]
> echo $TIME > /proc/sys/foo/bar/something_in_HZ
> 

Will this be USER_HZ or kernel HZ?
Someone earlier suggested it would be USER_HZ which would make it
pointless.

> I mean, come on.
> 
> Then you include it in the default distro of choice so that
> everybody can use it and there you are.
> 
> If someone doesn't have "gethz" then they can download it.
> 
> // Stefan
> 
