Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269524AbUJLIsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269524AbUJLIsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUJLIsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:48:39 -0400
Received: from pdbn-d9bb9795.pool.mediaWays.net ([217.187.151.149]:19987 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S269524AbUJLIsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:48:36 -0400
Date: Tue, 12 Oct 2004 10:48:29 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: jonathan@jonmasters.org
Cc: Olaf Fr??czyk <olaf@cbk.poznan.pl>, linux-kernel@vger.kernel.org
Subject: Re: How to umount a busy filesystem?
Message-ID: <20041012084829.GB19493@citd.de>
References: <1097441558.2235.9.camel@venus> <20041010211208.GA6986@citd.de> <1097445655.2235.18.camel@venus> <35fb2e59041011172478b0c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e59041011172478b0c09@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2004 01:24, Jon Masters wrote:
> On Mon, 11 Oct 2004 00:00:55 +0200, Olaf Fr??czyk <olaf@cbk.poznan.pl> wrote:
> > On Sun, 2004-10-10 at 23:12, Matthias Schniedermeyer wrote:
> > > On 10.10.2004 22:52, Olaf Fr?czyk wrote:
> > > > Hi,
> > > >
> > > > Why I cannot umount filesystem if it is being accessed?
> > > > I tried MNT_FORCE option but it doesn't work.
> > > >
> > > > Killing all processes that access a filesystem is not an option. They
> > > > should just get an error when accessing filesystem that is umounted.
> > > >
> > > > Any idea how to do it?
> > >
> > > umount -l
> > >
> > > removes the mount in "lazy"-mode, this way the mount-point "vanishes"
> 
> > Thank you.
> > But this:
> > 1. Does not let the user to remove the media (eg. cdrom).
> > 2. Does not flush buffers etc. so the media cannot be safely removed
> 
> What you want is the kind of proxy Luke Leighton was talking about in
> a recent post to lkml concerning his effort to port FUSE example code
> in to kernelspace. In his model you can replace the underlying
> filesystem because the user processes are only seeing what you present
> through the proxy - so although proxy inodes/superblock/etc. remain
> constant, the underlying filesystem might get swapped around or moved
> someplace else and the proxy has to work out whether to return errors
> or simply block until the backing filesystem is available for use
> again once more.

Hmmm. "Supermount-ng" seems to also be for this type of problem.
(Never tried it myself)

http://supermount-ng.sourceforge.net/




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

