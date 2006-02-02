Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423436AbWBBKQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423436AbWBBKQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBBKQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:16:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932420AbWBBKQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:16:42 -0500
Date: Thu, 2 Feb 2006 11:16:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202101626.GD1981@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020855.12392.nigel@suspend2.net> <200602020931.29796.rjw@sisk.pl> <200602021922.11100.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602021922.11100.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Still our approach is quite different to yours.  We are focused on keepeing
> > the code possibly simple and non-intrusive wrt the other parts of the
> > kernel, whereas you seem to concentrate on features (which is not wrong,
> > IMO, it's just a different point of view).  We're moving towards the
> > implementation of the features like the system image compression and
> > encryption,
> > graphical progress meters etc. in the user space, which has some
> > advantages, and I think this approach is correct for a laptop/desktop
> > system.
> >
> > Its limitation , however, is that it requires a lot of memory for the
> > system memory snapshot which may be impractical for systems with limited
> > RAM, and that's where your solution may be required.
> 
> I'm more concerned about the security implications. I'll freely admit that I 
> haven't spent any real time looking at your code, but I'm concerned that the 
> additional functionality made available could be used by viruses and the 
> like. I'm sure you'd have to be root to do anything, but how could the 
> interfaces be misused?

In vanilla kernel userland suspend has no security implications: root
can just do what he wants in /dev/mem, anyway.

In fedora kernel, userland suspend can be [miss]used to snapshot an
image, modify it, and write it back. Fortunately, this is going to
take *long* time so people will notice. [Interface changed on DaveJ's
request, now we have separate device, we no longer mess with
/dev/mem]. And similar problem exists in suspend2 -- malicious
graphical progress bar could probably modify memory image on disk.

> > In conclusion, I see the room for both, as long as the do not conflict, so
> > could we please bury the hatched and start working _together_?
> 
> I didn't realise I was holding one :). I'm not sure that I agree that there's 
> a need for both, but I have no desire whatsoever to act an any sort of nasty 
> way. All I want is to help provide Linux users with stable, reliable, 
> flexible and fast suspend-to-disk functionality.

Please take a look at current -mm series. It has everything neccessary
for your goals.
								Pavel

-- 
Thanks, Sharp!
