Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWBBNeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWBBNeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWBBNeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:34:06 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17298 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751054AbWBBNeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:34:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 14:34:32 +0100
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020931.29796.rjw@sisk.pl> <200602021922.11100.nigel@suspend2.net>
In-Reply-To: <200602021922.11100.nigel@suspend2.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602021434.33660.rjw@sisk.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Thursday 02 February 2006 10:22, Nigel Cunningham wrote:
> On Thursday 02 February 2006 18:31, Rafael J. Wysocki wrote:
> > > Well, I'd love that to be true, but I don't believe Pavel's going to roll
> > > over and say "Ok Nigel. You've got a better implementation. I'll submit
> > > patches to remove mine." I might be wrong, and I hope I will be, but I
> > > fear they're going to coexist for a while.
> >
> > First, your code introduces many changes in many parts of the kernel,
> > so to merge it you'll have to ask many people for acceptance.
> 
> I really must work harder to get rid of that perception. It used to be the 
> case, but isn't nowadays. Just about all of suspend2's changes are new files 
> in kernel/power and include/<arch>/suspend2.h. The remainder are misc fixes, 
> and enhancements like Christoph's todo list.

Well, in your previous series of patches there are examples to the contrary,
like the changes to kthread_create() or workqueues.  They would require an ack
from the maintainers of that code, at least.

Also, you probably need some changes in the arch code.  If that is so, the
maintainers of relevant architectures should be asked.

That already is "many".

> > Second, swsusp is actively developed, not only by Pavel, and you know that,
> > so you could be nicer. ;-)
> 
> It was hardly touched for a long time, but that has certainly been changing in 
> the last few months. I wasn't meaning to be uncharitable. Sorry for giving 
> that impression.

Accepted. :-)

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

In not many ways, really.  Of course you can do a DoS with them, but need
to be root to do this anyway.

> > In conclusion, I see the room for both, as long as the do not conflict, so
> > could we please bury the hatched and start working _together_?
> 
> I didn't realise I was holding one :). I'm not sure that I agree that there's 
> a need for both, but I have no desire whatsoever to act an any sort of nasty 
> way. All I want is to help provide Linux users with stable, reliable, 
> flexible and fast suspend-to-disk functionality.

That's fine. :-)

Obviously both solutions are used, so they both seem to be needed.

Greetings,
Rafael

