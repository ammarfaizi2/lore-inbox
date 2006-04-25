Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWDYKcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWDYKcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDYKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:32:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23228 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750831AbWDYKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:32:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 12:31:56 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <200604251026.53613.rjw@sisk.pl> <20060425100408.GF4789@elf.ucw.cz>
In-Reply-To: <20060425100408.GF4789@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251231.57577.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 25 April 2006 12:04, Pavel Machek wrote:
> > > Okay, so it can be done, and patch does not look too bad. It still
> > > scares me. Is 800MB image more responsive than 500MB after resume?
> > 
> > Yes, it is, slightly, but I think 800 meg images are impractical for
> > performance reasons (like IMO everything above 500 meg with the current
> > hardware).  However this means we can save 80% of RAM with the patch
> > and that should be 400 meg instead of 250 on a 500 meg machine, or
> > 200 meg instead of 125 on a 250 meg machine.
> 
> Could we get few people trying it on such small machines to see if it
> is really that noticeable?

OK, I'll try to run some tests on a machine with smaller RAM (and slower CPU).

> > > Is benefit worth it?
> > 
> > Well, that depends.  I think for boxes with 1 GB of RAM or more it's just
> > unnecessary (as of today, but this may change if faster disks are available).
> > On boxes with 512 MB of RAM or less it may change a lot as far as the
> > responsiveness after resume is concerned.
> > 
> > Anyway do you think it may go into -mm (unless Andrew shoots it down,
> > that is ;-))?
> 
> I'd really like to hear that it helps someone before going to
> -mm. It looks clean enough but still it is 300 lines... 

Oh, it's not that bad.  Adds ~240 lines and removes 75. :-)

Greetings,
Rafael


> 
> 									Pavel

-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
