Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTIDTbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbTIDTbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:31:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11427 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264854AbTIDTbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:31:06 -0400
Date: Thu, 4 Sep 2003 21:31:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Message-ID: <20030904193105.GF27650@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain> <1062703732.12025.7.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062703732.12025.7.camel@laptop-linux>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > No, you have to understand that I don't want to call software_suspend() at 
> > all. You've made the choice not to accept the swsusp changes, so we're 
> > forking the code. We will have competing implementations of 
> > suspend-to-disk in the kernel. 
> > 
> > You may keep the interfaces that you had to reach software_suspend(), but
> > you may not modify the semantics of my code to call it. At some point, you 
> > may choose to add hooks to swsusp that abide by the calling semantics of 
> > the PM core, so that you may use the same infrastructure.
> > 
> > Please send a patch that only removes the calls to swsusp_* from 
> > pm_{suspend,resume}. That would be a minimal patch. 
> 
> Where does this put me? I'm finishing off 1.1 for 2.4 and have a port to
> 2.6 in process. I want to get it merged, but how do I go about that now?
> 
> For the record, it's worth merging, I believe. It has a fully year of
> extensive testing, support for saving a full (as opposed to minimal)
> image of RAM, support for highmem, swap files, full asynchronous I/O,
> aborting cleanly from errors, user tuning and a nice interface. I don't
> want to see it thrown away, but neither do I want to have a third
> option!

It puts you in a better position, AFAICS. When code is rewritten
anyway, "don't fix it if it aint broken" is not so important any
more -- good for you.

I still hope to avoid two software suspends in 2.6.X.

								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
