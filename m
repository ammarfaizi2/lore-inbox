Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTIVNNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTIVNNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:13:21 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:16624 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263140AbTIVNNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:13:20 -0400
Subject: Re: Make modules_install doesn't create /lib/modules/$version
From: Martin Schlemmer <azarah@gentoo.org>
To: rob@landley.net
Cc: Mikael Pettersson <mikpe@csd.uu.se>, LKML <linux-kernel@vger.kernel.org>,
       rddunlap@osdl.org, rusty@rustcorp.com.au
In-Reply-To: <200309220655.43275.rob@landley.net>
References: <200309192139.h8JLdaXf012418@harpo.it.uu.se>
	 <200309220655.43275.rob@landley.net>
Content-Type: text/plain
Message-Id: <1064235763.15286.34.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Sep 2003 15:02:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 12:55, Rob Landley wrote:

> > In any event, make modules_install before make install works
> > and has always worked for me on RH systems.
> 
> You're right:
> 
> make modules_install install works.
> make install modules_install does not.
> 
> Good to know.
> 
> > >I've been bitten by this before, by the way.  I switched from an
> > > accidental SMP kernel to a UP kernel on my laptop, and the install
> > > complained about
> >
> > rm -f /lib/modules/$KERNELVERSION; make modules_install
> 
> That's what I did after I was bitten, yes.
> 
> > >unresolved SMP symbols in the modules.  (This is how I got in the habit of
> > >doing make modules_install before make install, which I thought might also
> > > be responsible for the directory creation problem, but wasn't.  Neither
> > > creates the directory: depmod does).
> >
> > depmod does not create any directories, 'make modules_install' does.
> 
> Although make install dies on a red hat 9 system trying to look at the modules 
> directory if modules_install isn't done first.  Maybe it's an RH 9 bug.  I 
> was actually kind of surprised that we almost do "./configure;make;make 
> install" now, yet make install doesn't install modules.  Is there a reason 
> make install does NOT install modules for a modular kernel?
> 

I also always use 'make modules_install install' to do things,
so it might not be RH9 related only.  I will have a look tonight.


Thanks,

-- 
Martin Schlemmer


