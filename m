Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279608AbRJXVx5>; Wed, 24 Oct 2001 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279612AbRJXVxr>; Wed, 24 Oct 2001 17:53:47 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:14047 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S279608AbRJXVxi>; Wed, 24 Oct 2001 17:53:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <3BD6E413.5AF9D7EF@firsdown.demon.co.uk>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <3MGB7.4641$142.807307317@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003960447 000 192.168.192.240 (Wed, 24 Oct 2001 17:54:07 EDT)
NNTP-Posting-Date: Wed, 24 Oct 2001 17:54:07 EDT
Date: Wed, 24 Oct 2001 21:54:07 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD6E413.5AF9D7EF@firsdown.demon.co.uk>,
Dave Garry <daveg@firsdown.demon.co.uk> wrote:
| 
| Tim Waugh wrote:
| > 
| > On Wed, Oct 24, 2001 at 04:02:00PM +0100, Dave Garry wrote:
| > 
| > > Thanks for the tip, but it's not helping. I've tried
| > > "irq=auto" and "irq=7" but it still wont play.
| > >
| > > I just noticed that CONFIG_PARPORT_PC_FIFO is set to NO
| > > and I'm rebuilding with it set to YES to see if that
| > > helps...
| > 
| > Yes, you need that enabled or it won't even have the code for using
| > the FIFO compiled in.
| 
| Enabling CONFIG_PARPORT_PC_FIFO has not helped, I now
| get the following:
| 
| # modprobe parport_pc verbose_probing=1 irq=auto

Curious. I Get rejected when I use irq=auto with 2.4.13-pre6.

#================ config
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y
#================

I did set 1284 mode, and assume you have as well. I don't have super-io
set, since I have an old chipset, perhaps that's an issue as well.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
