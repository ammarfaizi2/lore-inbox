Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWAFAk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAFAk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWAFAk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:40:56 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:6444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932339AbWAFAky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:40:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucZ3r7FCiVhu+6iDDoL3pn4aZiO/l4e4jFf6FxjBnesotXn/8OQFgBvZXlb8k4PX22Blsi4ntnKI79fegR0axy8arYBog5Zon3PmHC9ktEofOvNO9zHl6oo/bjkdrjYgmSWmfGH2oSlOopCgDSM/ioTyXFrcH278zW5rPYDkf7o=
Message-ID: <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
Date: Fri, 6 Jan 2006 01:40:53 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20060105162714.6ad6d374.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	 <20060105162714.6ad6d374.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > On 1/5/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
> > >
> > >
> > <!-- snip -->
> >
> > Hi Andrew,
> >
> > 2.6.15-mm1 seems to be working less than perfect on my box.
> >
>
> ahem...
>
Ohh well, that's why we have -mm :)


> > Everything seems to be fine in console mode, but once I start X and
> > then login and KDE starts, the box locks up solid while loading KDE
> > (dies every time at the exact same spot, the "Initializing
> > peripherals" stage on the KDE splash screen).
>
> Various people have reported DRM/AGP oopses when starting X.  It's probably
> that.
>
> Could you try reverting git-agpgart.patch?
>
Just did. Reverted that one patch, then rebuild/reinstalled the kernel
(with the same .config) and booted it - no change. It still locks up
in the exact same spot.
X starts & runs fine (sort of) since I can play around at the kdm
login screen all I want, it's only once I actually login and KDE
proper starts that it locks up.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
