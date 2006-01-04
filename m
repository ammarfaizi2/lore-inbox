Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbWADVR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbWADVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWADVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:17:58 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:9661 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965210AbWADVR5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:17:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C1zUlqa4/+WcKfXvajkgFTSdO+Imwq2PQvR2Wx7dZFXW7jvMYERTKYsM/LbpVC8riFGQY6+Zua3WeHH/k2hvhneie//+u6gfBMmJspKa5w9WxG37gRaKlxU1V+wnNprfEy6gPiOyfAFYfgIvZdWGmwNwKiQkkT/SUPIHTVnW2gU=
Message-ID: <9a8748490601041317q3711511ak22b95f985023e5b0@mail.gmail.com>
Date: Wed, 4 Jan 2006 22:17:56 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <1136399230.12468.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
	 <Pine.LNX.4.58.0601040950530.19134@shark.he.net>
	 <200601041756.52484.nick@linicks.net>
	 <1136399230.12468.70.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 2006-01-04 at 17:56 +0000, Nick Warne wrote:
> > On Wednesday 04 January 2006 17:51, Randy.Dunlap wrote:
> >
> > >
> > > but the incremental patches do appear to be in
> > >   http://www.kernel.org/pub/linux/kernel/v2.6/incr/
> > >
> > > who generates these?  are they automated?
> >
> > OMG - am I the only person in the world to be H4><0R3D from kernel.org...
>
> I still find ketchup the easiest solution:
>
> Here's a cut and paste of what I did.  The commands that I did was as

14 steps?

Surely a simple 5 step procedure is easier :

$ cd ~/linux-2.6.14.5                   # change into the kernel source dir
$ patch -p1 -R < ../patch-2.6.14.5      # revert the 2.6.14.5 patch
$ patch -p1 < ../patch-2.6.15         # apply the new 2.6.15 patch
$ cd ..
$ mv linux-2.6.14.5 linux-2.6.15      # rename the kernel source dir

That's assuming you have already gunzip'ed the patch, but even if you
have not it's still just as easy :

$ cd ~/linux-2.6.14.5                   # change into the kernel source dir
$ zcat ../patch-2.6.14.5.gz | patch -p1 -R     # revert the 2.6.14.5 patch
$ zcat ../patch-2.6.15.gz | patch -p1        # apply the new 2.6.15 patch
$ cd ..
$ mv linux-2.6.14.5 linux-2.6.15      # rename the kernel source dir


No need to jump through 14 hoops.

And it's even nicely documented.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
