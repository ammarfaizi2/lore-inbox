Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbQKPUdN>; Thu, 16 Nov 2000 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbQKPUdD>; Thu, 16 Nov 2000 15:33:03 -0500
Received: from mirrors.planetinternet.be ([194.119.238.163]:24584 "EHLO
	mirrors.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131397AbQKPUc4>; Thu, 16 Nov 2000 15:32:56 -0500
Date: Thu, 16 Nov 2000 21:02:53 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: chroot [Was: Re: Linux 2.2.18pre21]
Message-ID: <20001116210253.A3862@ping.be>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20001116115249.A8115@wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 11:52:49AM -0800, jesse wrote:
> On Thu, Nov 16, 2000 at 05:16:18PM +0100, Andrea Arcangeli wrote:
> > On Thu, Nov 16, 2000 at 03:07:04PM +0100, Matthias Andree wrote:
> > > It shows a program that saves the cwd -- open(".",...) in an open file,
> > > then chroots [..]
> > 
> > This is known behaviour (I know Alan knows about it too), solution is to close
> > open directories filedescriptors before chrooting.
> > 
> > Everything that happens before chroot(2) is trusted, so it's secure to rely
> > on it to close directories first.
> > 
> > If this is not well documented and people doesn't know about it and so they
> > writes unsafe code that's another issue...
> 
> But the problem is because you can call chroot when you're already chrooted.

Only if you're root.  There are other ways to break out of a
chroot() if you're root too.


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
