Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbTGLNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbTGLNq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:46:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:17617 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S265834AbTGLNq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:46:27 -0400
Date: Sat, 12 Jul 2003 16:00:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712140057.GC284@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057963547.3207.22.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi Linus.
>

Well, you probably did want Linus to answer, but I see some new stuff
here.

> As you may know, there has been a lot of work done on the 2.4 version of
> software suspend. This includes:
> 
> - async i/o
> - back out on errors rather than panicing (where possible)

If those panic()s happen for the users, then this is bugfix.

> - enhancements to refrigerator so it successfully freezes processes even
> under high load

This is bugfix.

> - save a full image rather than freeing just about all the memory first
> - highmem support
> - image compression support
> - swapfile support in progress

This seems extremely hard to do right. If you can do it right and not
rewrite half of kernel, that's okay, but I don't think you can do that.

> - nice display
> - user can abort at any time during suspend (oh, I forgot, I wanted
> to...) by just pressing Escape

That seems like missfeature. We don't want joe random user that is at
the console to prevent suspend by just pressing Escape. Maybe magic
key to do that would be acceptable...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
