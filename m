Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWAFBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWAFBEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWAFBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:04:42 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:37271 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932365AbWAFBEl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:04:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aog3DODM2Cx4Afh/mlWKDtZNGqrowXQG3IoQgPpnqhB0ahCyLS4AOMQpu0rZwIk7JTV2HOsuiAyCZ0eBRLOh7tNqlNr41tEhgw/345hyE05w6WMF5HZ2EqXRcmYQj0s9IeKF8omBzvUDfgfWUj3T9VvHnwtn1tZuqB2sUX/L6Sw=
Message-ID: <9a8748490601051704m6c942b0as5e9a2bc58dac0f35@mail.gmail.com>
Date: Fri, 6 Jan 2006 02:04:40 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davej@codemonkey.org.uk, airlied@linux.ie
In-Reply-To: <20060105165946.1768f3d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
	 <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
	 <20060105165946.1768f3d5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > > > Everything seems to be fine in console mode, but once I start X and
> >  > > then login and KDE starts, the box locks up solid while loading KDE
> >  > > (dies every time at the exact same spot, the "Initializing
> >  > > peripherals" stage on the KDE splash screen).
> >  >
> >  > Various people have reported DRM/AGP oopses when starting X.  It's probably
> >  > that.
> >  >
> >  > Could you try reverting git-agpgart.patch?
> >  >
> >  Just did.
>
> Thanks.
>
> >  Reverted that one patch, then rebuild/reinstalled the kernel
> >  (with the same .config) and booted it - no change. It still locks up
> >  in the exact same spot.
> >  X starts & runs fine (sort of) since I can play around at the kdm
> >  login screen all I want, it's only once I actually login and KDE
> >  proper starts that it locks up.
>
> Oh bugger.  No serial console/netconsole or such?
>
Unfortunately no, I currently only have this one machine available.

> Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
> get an oops?
>
I'll try, I'll also try and see if I can get something into logs by
playing with sysrq, but that'll all have to wait until tomorrow
evening, right now I need some sleep - I'll report back.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
