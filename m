Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315787AbSEDHmA>; Sat, 4 May 2002 03:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSEDHl7>; Sat, 4 May 2002 03:41:59 -0400
Received: from pool-151-201-37-99.pitt.east.verizon.net ([151.201.37.99]:26508
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S315787AbSEDHl6>; Sat, 4 May 2002 03:41:58 -0400
Date: Sat, 4 May 2002 03:41:58 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
Subject: Re: dnotify oddity in 2.4.19pre6aa1
Message-ID: <20020504034158.O30294@marta>
Mail-Followup-To: Kurt Wall <kwall>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204231658.g3NGwE203196@athlon.cichlid.com> <20020503173109.1afdbec1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scribbling feverishly on May 03, Stephen Rothwell managed to emit:
> Hi Andrew,
> 
> Sorry I have been a bit slow on this.
> 
> On Tue, 23 Apr 2002 09:58:14 -0700 Andrew Burgess <aab@cichlid.com> wrote:
> >
> > I am seeing something very strange with the dnotify feature in kernel
> > 2.4.19pre6aa1. I'm developing a file copy daemon that makes backups of
> > files as soon as they change so I run dnotify on every directory in my
> > system (essentially). I based my program on the example in dnotify.txt
> > in the Documentation directory.
> 
> So far, so good :-)
> 
> > I notice that after a while two things happen:
> > 
> > 1) In my copyd process I start getting signals for directories that are
> > not changing. Even stranger, I get signals for fd that I've never
> > opened.
> 
> OK, this is weird, but I am looking into it.
> 
> > 2) Other processes, like sendmail, start exiting with the same signal
> > (RTMIN+5). (I use +5 because I started seeing the problem with +0 and I
> > took a wild guess that RTMIN+0 was being used for something else).

glibc reserves RTMIN+[012] for its own use, so you have to use
RTMIN+[n>2].

[...]

Kurt
-- 
Command, n.:
	Statement presented by a human and accepted by a computer in
such a manner as to make the human feel as if he is in control.
