Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFTKVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFTKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:21:47 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:8384 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262656AbTFTKVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:21:41 -0400
Date: Fri, 20 Jun 2003 12:35:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@suse.de>
Cc: Fruhwirth Clemens <clemens-dated-1056968093.cf44@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620103538.GA28711@wohnheim.fh-wedel.de>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org> <20030620102455.GC26678@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030620102455.GC26678@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 12:24:55 +0200, Andi Kleen wrote:
> On Fri, Jun 20, 2003 at 12:14:52PM +0200, Fruhwirth Clemens wrote:
> > On Fri, Jun 20, 2003 at 11:30:03AM +0200, Andi Kleen wrote:
> > > Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> writes:
> > > 
> > > > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> > > > again. 
> > > 
> > > This will break existing crypto loop installations, making
> > > the existing encrypted image unreadable. After all this is Linux
> > > here, not HackOS where you can break user file system formats at will.
> > > The only way to implement this is with a new flag that is set by losetup
> > > and keep the old behaviour by default.
> > 
> > There is no cryptoloop installation which is affected by this. Read my mail
> > properly. Every cryptoloop setup out there uses loop-AES or kerneli's
> > patch-int. And both fixed this issue a _long_ time ago. (Have a look at
> 
> That's completely wrong. I know of several independent implementation
> and installations.

That leaves the question of what the default behaviour should be.  If
we have to switch to 512Byte in the long run anyway, there is little
point in postponing the pain.  Make it the default, and old behaviour
depends on the flag.

If we can avoid the pain completely, use that better fix instead, even
if it isn't ready before 2.7, and ignore the problem until then.

Can we?

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
