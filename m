Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946150AbWBDAoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946150AbWBDAoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbWBDAoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:44:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946150AbWBDAoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:44:38 -0500
Date: Sat, 4 Feb 2006 01:44:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dave Jones <davej@redhat.com>, Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204004416.GD3291@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031824.45467.rjw@sisk.pl> <20060203183006.GB57965@dspnet.fr.eu.org> <200602032208.58640.rjw@sisk.pl> <20060204002635.GB4845@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204002635.GB4845@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That's exactly what I'm terribly afraid of.  You have no way to
> > > enforce them, so they won't be respected.  And filesystems will die
> > > randomly and unpredictably.
> > 
> > Yes, this may happen if the userland helpers are buggy, but again any
> > root-equivalent process that is buggy can do the damage just as well.
> > 
> > Your point seem to be "we should implement this in the kernel to protect
> > the users from irresponsible authors of userland applications
> > and distributors".  I just don't agree with that.  [Going along this line of
> > reasoning we should implement fsck in the kernel too. ;-)]
> 
> fsck isn't sexy and is implemented by the authors of the filesystems
> or in close collaboration with them.  Even there, there is a lot of
> talk about fscking live systems but nobody has dared it yet.  That has
> some similarities with your situation.
> 
> There are two parts in your suspend userland helper.  The
> functionality code, which you, and Pavel, and other highly competent
> people will write.  I have no qualms with that one.  And then there
> is

Thanks :-).

> the chrome code, the sexy code, that everybody and his dog is going to
> want to muck with because that's where the looks are.  I'll give it 6
> months at best from when you have a working system before you get a
> submission for some themed, 3d-accelerated buzzword-compliant
> nightmare of a progress bar.  With demented pressure to have it in
> the

Well, this should be more like bootsplash support; simple, preload
bitmaps before you start suspend sequence, no 3d-accelerated
hell. I'll actually make sure I have reasonably-looking progress bar
ready, so people don't have reason to invent some nightmare.

> official distribution because it looks like Babylon 5 on steroids.
> Especially if you have a plugin structure, which otherwise makes a lot
> of sense technically.  Will you be able to trust this code to do no
> disk access and no other state changes that could be problematic (like
> changing vt back to X)?

If they try to switch back to X, it will just deadlock on them. If
they try to communicate using IPC, boom, deadlock. They still may do
something stupid; I'll do my best to educate them not to do
that. Writing to filesystem would be especially bad, for example. But
that should be reasonably easy to understand...
								Pavel
-- 
Thanks, Sharp!
