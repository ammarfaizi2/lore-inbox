Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVKZOTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVKZOTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVKZOTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:19:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750865AbVKZOTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:19:40 -0500
Date: Sat, 26 Nov 2005 15:19:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051126141926.GB17663@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <200511251620.12996.rob@landley.net> <4F23F6A0-EC33-43E0-B0D2-BCBFF25E5777@mac.com> <200511260625.31289.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511260625.31289.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On So 26-11-05 06:25:30, Rob Landley wrote:
> On Friday 25 November 2005 20:34, Kyle Moffett wrote:
> > I got interested so I started writing a Perl-based replacement that
> > actually reads the source config into program memory and writes
> > copies out of that RAM each time.
> 
> I did several variants before settling on the one I submitted as "least sucky 
> for right now".  (Starting from zero and adding lines did not work at _all_, 
> and trying to produce consecutively smaller diffs isn't a winner either.  
> Anything fancy based on diff runs into the fact that dependencies can enable 
> stuff _earlier_ in the file, and it's almost impossible to parse.  Besides, 
> diff is noticeably faster when there are few changes, so this was the best 
> performer of the lot too...)
> 
> And I try to avoid perl dependencies in the linux build process.  When you do 
> cross-compiles that make a minimal toolchain (ala the Linux From Scratch 
> "/tools" directory) and then chroot into it to create the new system, having 
> to add perl to the mess is a disproprotionate hassle.

I'd say "don't worry about that, yet".

> Also, zappable lines tend to clump, so if it gets 2 zappable lines in a row it 
> could speculatively try zapping 2 at a time to see if it makes faster 
> progress.  (The down side is the extra allnoconfig runs for backing up and 
> iterating through on failures to see _which_ ones made a difference.  That's 
> not low-hanging fruit, may not be edible at all...)

Can't you just filter out all the comments beforehand?
								Pavel
-- 
Thanks, Sharp!
