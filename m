Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281496AbRKUAHa>; Tue, 20 Nov 2001 19:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281502AbRKUAHV>; Tue, 20 Nov 2001 19:07:21 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52727
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281496AbRKUAHK>; Tue, 20 Nov 2001 19:07:10 -0500
Date: Tue, 20 Nov 2001 16:06:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Lu?s Henriques <lhenriques@criticalsoftware.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: copy to suer space
Message-ID: <20011120160657.A4124@mikef-linux.matchmail.com>
Mail-Followup-To: Lu?s Henriques <lhenriques@criticalsoftware.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111201714.fAKHEc276467@criticalsoftware.com> <20011120114124.T1308@lynx.no> <200111201849.fAKInr205178@criticalsoftware.com> <20011120123915.W1308@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120123915.W1308@lynx.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 12:39:15PM -0700, Andreas Dilger wrote:
> On Nov 20, 2001  18:44 +0000, Lu?s Henriques wrote:
> > > Maybe if you describe the actual problem that you are trying to solve, and
> > > not the actual way you are trying to solve it, there may be a better
> > > method. Usually, if something you are trying to do is very hard to do,
> > > there is a different (much better) way of doing it.
> > 
> > I'm developping a kernel module that needs to delay a process, that is, he 
> > receives a PID and, when a specific event occurs, that process shall be 
> > delayed. This delay shall be done in a way that the process keeps burning CPU 
> > time (it can not be, e.g., put in a waiting-list...).
> 
> Putting it into a waiting-list is by far the best solution.  This is a normal
> Unix operation, like SIGSTOP, SIGCONT, and could even be done from user space.
> 
> What is the requirement that it keeps burning CPU for?  Generally, this is
> what you do NOT want to do.
> 

This to me looks like the main desire is to fool the user.  It looks like it
doing something, but it really isn't...
