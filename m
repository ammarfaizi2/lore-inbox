Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278074AbRJKC7L>; Wed, 10 Oct 2001 22:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJKC7C>; Wed, 10 Oct 2001 22:59:02 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43759
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278074AbRJKC6u>; Wed, 10 Oct 2001 22:58:50 -0400
Date: Wed, 10 Oct 2001 19:59:15 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011010195915.A485@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk> <20011011042228.A10133@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011042228.A10133@emma1.emma.line.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 04:22:28AM +0200, Matthias Andree wrote:
> On Thu, 11 Oct 2001, Alan Cox wrote:
> 
> > *	Small fixes to various long standing bugs, various architecture and
> > *	driver cleanups. The 2.4.10-ac tree now seems pretty solid.
> > *
> > 
> > 2.4.10-ac11
> > o	Further VM tuning				(Rik van Riel)
> 
> Short version: Kicks ass!
> 
> Long version: the sluggishness that 2.4.9, 2.4.10 and the previous -ac
> versions suffered from (not sure if 2.4.7 was also sluggish) seems to be
> gone, the machine is much quieter now and does not look like paralysed
> for seconds every now and then. Stress tests need to be done, but a make
> -j on various DJB tools which would start up only slowly now quickly
> zoom through.
>

Hmm, I'm still seeing jerky swap out performance with make -j 30 on 256MB
workstation.  Swap in is good and smooth though.  I would see kswapd taking
about 10% (with 30 gcc processes on a 2x366 celeron) just before it would
swap out about 5000 blocks in one second (actually, the entire system
stalled for about 5-10 seconds, and vmstat wouldn't even report in that
time period).

Rik,

Would you be interested in a vmstat output from kernel compile that is
guaranteed to generate swap out?

I thought of sending both output of make and vmstat to syslog (to get
timestamps and an idea of exactly what is happening during the vmstat
output...).

If so, I can write up a little script that can send the output of vmstat, a
diff of /proc/meminfo, and make output from kernel compile.

Or would that be too much data to look at?

> 
> However, one thing strikes me on boot: ext3fs claims it's 0.9.6, while
> the ext3 web site tells us about 0.9.10. What's going on with 2.4.x-ac
> ext3fs? Should I be concerned?

No, the ext3 guys are working on a merge patch for -ac right now.  Though
you won't see it on the ext3 for 2.4 web site...  Check the ext2-devel
archive for the last week or so...

Mike
