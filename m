Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFIRyQ>; Sun, 9 Jun 2002 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSFIRyP>; Sun, 9 Jun 2002 13:54:15 -0400
Received: from fysh.org ([212.47.68.126]:58577 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S314243AbSFIRyN>;
	Sun, 9 Jun 2002 13:54:13 -0400
Date: Sun, 9 Jun 2002 18:54:14 +0100
From: Athanasius <link@gurus.tf>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: request_module[net-pf-10]: fork failed, errno 11
Message-ID: <20020609175414.GB13726@miggy.org.uk>
Mail-Followup-To: Athanasius <link@gurus.tf>, Keith Owens <kaos@ocs.com.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020608094307.GA6522@miggy.org.uk> <21483.1023531725@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 08:22:05PM +1000, Keith Owens wrote:
> On Sat, 8 Jun 2002 10:43:07 +0100, 
> Athanasius <link@gurus.tf> wrote:
> >  I'm seeing a lot of:
> >
> >	kernel: request_module[net-pf-10]: fork failed, errno 11
[snip]
> 
> That error is occurring before modprobe has run, long before it gets to
> modules.conf.  You need to find out why fork() for modprobe on your
> system is failing with EAGAIN.  Have you reached the limit on the
> number of tasks?

   Not as far as I can tell.  It would be easier to tell if 'sa' (BSD
process accounting) carried useful information like timestamps per
process or even just their PIDs (to match to a *.* syslog'd file).

  What I can say is that in that *.* syslog file the only thing with
'fork' let alone 'fork failed' is the lines as above.  I can't find
where to query the max number of tasks (/proc/sys/kernel/threads-max is
the only likely looking candidate I can find and is 4095) in /proc, and
couldn't seem to find any indication of such with a quick glance at
kernel headers and source.

  The machine in question is somewhat busy, running a lot of shell
accounts, news, http and https, email including mailman lists and other
miscellaneous processes.  However I'd expect to see some other
indication of task starvation if it was occurring.  Right now there
around 220-225 processes running.

-Ath

-- 
- Athanasius = Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
