Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTJWOxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTJWOxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:53:17 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:29905 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263582AbTJWOxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:53:13 -0400
Date: Thu, 23 Oct 2003 10:43:15 -0400
From: Ben Collins <bcollins@debian.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Message-ID: <20031023144315.GA667@phunnypharm.org>
References: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 06:31:22PM +0100, James Simmons wrote:
> 
> Hi folks. 
> 
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
> added back in functionality for switching the video mode for fbcon via 
> fbset again. Give it a try and let me know the results.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

The changes to mach64_cursor.c really bork things up somehow. The cursor
has changed from a nice underline to a solid white block. Not only that,
but the block is bigger than the font it is over (if I am on top of
adjacent letters, it covers the entire letter I am on, plus a couple of
pixels of the letter to the right).

In additition, the cursor now disappears while typing, and navigating
around (on the command line left and right, or even in an editor when
moving the cursor up and down). This disappearing while typing or
navigating is _really_ annoying. If I go left or right a lot, I have to
keep stopping to see where the cursor actually is.

FYI, this is on an UltraSPARC Blade 100, Mach64. Atleast things didn't
break completely :) Definitely need this fixed though.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
