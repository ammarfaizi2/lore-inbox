Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277320AbRJJREe>; Wed, 10 Oct 2001 13:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277321AbRJJREY>; Wed, 10 Oct 2001 13:04:24 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:6667 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277320AbRJJREL>; Wed, 10 Oct 2001 13:04:11 -0400
Date: Wed, 10 Oct 2001 19:04:42 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: proc file system
Message-ID: <20011010190442.A26980@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200110052202.f95M2Ig16051@mail.swissonline.ch> <20011006173025.F12624@arthur.ubicom.tudelft.nl> <20011009154134.C28423@artax.karlin.mff.cuni.cz> <o7a6stc9qhk57g9p6s3is4m03897k6rari@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <o7a6stc9qhk57g9p6s3is4m03897k6rari@4ax.com>; from xioborg@yahoo.com on Tue, Oct 09, 2001 at 11:49:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, to get tail -f to work, minimally you'll have to support
> maintaining a fileposition, so tell() and seek() have something useful
> to work on.  It's been a while since I looked at the source for tail,
> pretty much for similar reasons (wanted to follow a /proc file).  Most
> /proc files are considered (relatively) fixed-length files, who's
> contents get updated.  tail -f expects to follow a file that is
> growing in size.

... thus it won't work on char dev at all;-) (but simple cat will do
lot better). Well, it does not matter what proc files are supposed to
be, they can behave any way you want. They can even behave like devices.
(And it even shouldn't be more work)

AFAIK the only differences remaining are that devices can initialize module
autoloading and that you can put device node anywhere.

> I don't have sources in front of me, so hopefully someone else will
> step-up and provide more detail than I have.
> 
> Steve Brueggeman
> 
> 
> On Tue, 9 Oct 2001 15:41:34 +0200, you wrote:
> 
> >> On Sat, Oct 06, 2001 at 12:02:18AM +0200, llx@swissonline.ch wrote:
> >> > i've written a prog interface for my logger utility to make it easy
> >> > to transport my logging information from kernel to userspace using
> >> > shell commands. now i want to use tail -f /prog/<mylogfile>. what
> >> > do i have to do for that to work. when using tail my loginfo gets
> >> > read form my ringbuffer, but nothing gets printed in the terminal.
> >> 
> >> I think you actually want a character device instead of a /proc file.
> >
> >Could you please explain why? I can't see the advantage (read and write
> >are fileops; you can have them exactly the same for proc file and device).
> >
--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
