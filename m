Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUJaRsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUJaRsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUJaRsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:48:39 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:17117 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261336AbUJaRsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:48:35 -0500
Date: Sun, 31 Oct 2004 09:47:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Adrian Bunk <bunk@stusta.de>,
       Xavier Bestel <xavier.bestel@free.fr>,
       James Bruce <bruce@andrew.cmu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Andrea Arcangeli <andrea@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041031174720.GA21343@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Adrian Bunk <bunk@stusta.de>, Xavier Bestel <xavier.bestel@free.fr>,
	James Bruce <bruce@andrew.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andrea Arcangeli <andrea@novell.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com> <20041028195947.GD3207@stusta.de> <20041028213534.GA29335@work.bitmover.com> <20041030065111.GF4374@stusta.de> <20041030234619.GB24640@work.bitmover.com> <1099177552.25194.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099177552.25194.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:05:53AM +0100, Alan Cox wrote:
> On Sul, 2004-10-31 at 00:46, Larry McVoy wrote:
> > a lot of people think that then lets fix that.  By the way, with all
> > due respect, Andrea & Roman are not "reasonable" people in this context.
> > Let's find some reasonable people who are not BK users and make sure they
> > are comfortable with what is going on.  Alan Cox, Al Viro, who else?
> > I don't really care if it is non-BK users, BK users, or a combination,
> > I just care that there is some sanity in the discussion.
> > 
> > Is there any need for this or is this a non-issue?
> 
> Seems a total non issue to me. If you did utterly evil things then your
> statements archived in email so far would be more than sufficient.

Cool.  But I'd like to clarify something someone else said, for the record.

> > I think you could make a compelling argument that the linux
> > kernel history
> > metadata is *not* covered under the GPL, and hence can be
> > restricted by licensing.

> That's an interesting argument. I think you could argue that a BK
> repository is an aggregation of metadata and the kernel source, and
> therefore only the kernel source needs to be distributed. IANAL, this
> question has now gotten into territory in which I don't feel comfortable
> offering an opinion.

There are really three distinct chunks of information in BK:
    - the source code under management
    - the metadata created by users, i.e., checkin comments.  We also
      consider user names, dates, and timestamps to be created by users
      even though BK itself does that for you.
    - the metadata created by BK 

The license and ownership of kernel source code managed by BK has nothing
to do with BK nor the BK license.

There is a question as to whether the metadata created by the users
is GPLed.  It's not because it falls under the separate works part
of the GPL.  If that metadata were GPLed then your user name in an
inode is GPLed if you were putting a GPLed file into a filesystem.
That's a boundary you aren't going to be able to cross no matter how
hard you try (note: you can start arguing about this and I'll ignore 
you, we've been over this).

Just to make our position clear, consider this a formal declaration that
we make no claims of ownership of user created metadata, as defined above,
and impose no restrictions on its use.  I suspect that this declaration
isn't needed, you ought to have rights to your own name and checkin
comments, but let's make sure that there is no confusion about that.

There is the question of metadata created by BK.  That's also not GPLed
for the same reasons.  This metadata is more like the block pointers in
a file system.  While you may use BK, if you have a license, to dig out
your data and the user created metadata, you aren't entitled to expose the
internal BK metadata.  That falls under the reverse engineering clause,
non-compete clause, etc.  I realize you don't like this if you are trying
to create a competing product but that's the way things are.

Please respect that just as we are respecting your rights to your data.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
