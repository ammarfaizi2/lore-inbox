Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423379AbWBBIb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423379AbWBBIb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423380AbWBBIb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:31:56 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:2704 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423379AbWBBIbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:31:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 09:31:29 +0100
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com> <200602020855.12392.nigel@suspend2.net>
In-Reply-To: <200602020855.12392.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602020931.29796.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 01 February 2006 23:55, Nigel Cunningham wrote:
> On Thursday 02 February 2006 07:45, Pekka Enberg wrote:
> > On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > > > I think we can call these suspend_{get|set}_modules instead i.e.
> > > > without the extra '2'.
> >
> > On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > I wanted to avoid confusion with similar routine names Pavel might use.
> > > For example, he has a resume_setup and I have a resume2_setup.
> >
> > Is that necessary for the mainline, though? We have only one suspend
> > in the kernel, not "Pavel suspend" and "Nigel suspend", right?
> 
> Well, I'd love that to be true, but I don't believe Pavel's going to roll over 
> and say "Ok Nigel. You've got a better implementation. I'll submit patches to 
> remove mine." I might be wrong, and I hope I will be, but I fear they're 
> going to coexist for a while.

First, your code introduces many changes in many parts of the kernel,
so to merge it you'll have to ask many people for acceptance.

Second, swsusp is actively developed, not only by Pavel, and you know that,
so you could be nicer. ;-)

Still our approach is quite different to yours.  We are focused on keepeing
the code possibly simple and non-intrusive wrt the other parts of the kernel,
whereas you seem to concentrate on features (which is not wrong, IMO, it's
just a different point of view).  We're moving towards the implementation
of the features like the system image compression and encryption,
graphical progress meters etc. in the user space, which has some advantages,
and I think this approach is correct for a laptop/desktop system.

Its limitation , however, is that it requires a lot of memory for the system
memory snapshot which may be impractical for systems with limited RAM,
and that's where your solution may be required.

In conclusion, I see the room for both, as long as the do not conflict, so
could we please bury the hatched and start working _together_?

Greetings,
Rafael

