Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRG3Op4>; Mon, 30 Jul 2001 10:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268825AbRG3Opq>; Mon, 30 Jul 2001 10:45:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13072 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268800AbRG3Opk>; Mon, 30 Jul 2001 10:45:40 -0400
Date: Mon, 30 Jul 2001 10:15:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Steven Cole <elenstev@mesatop.com>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-pre1 and dbench -20% throughput
In-Reply-To: <0107280404020Y.00285@starship>
Message-ID: <Pine.LNX.4.21.0107301012510.7118-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Sat, 28 Jul 2001, Daniel Phillips wrote:

> On Saturday 28 July 2001 02:35, Steven Cole wrote:
> > I also saw a significant drop in dbench 32 results.
> > Here are a few more data points, this time comparing 2.4.8-pre1 with
> > 2.4.7.
> >
> > 2.4.7   9.3422 MB/sec vs 2.4.8-pre1   6.88884 MB/sec average of 3
> > runs
> >
> > The system under test has 384 MB of memory, and did not go
> > into swap during the test.  I performed a set of three runs
> > immediately after a boot, and with no pauses in between individual
> > runs.  I used time ./dbench 32 and caputured the output in a file
> > using script `uname -r`.  The tests were done with X and KDE running,
> > but no other activity.
> 
> The variation is accounted for almost entirely by the change in system 
> time.  Does this mean more IO's or more scanning?  I don't know, more 
> research needed.
> 
> We need Marcelo's vm statistics patch, I wonder what the status of that 
> is.

Well, I've switched to Andrew Morton's generic stats scheme. 

I've also started writing a new userlevel tool (based on cpustat.c from
Zach Brown) to "replace" the old vmstat.c.

Right now I'm busy fixing clients problems and kernel RPM bugs, but I hope
to have the new vm stats patch using Andrew's scheme plus the userlevel
tool until the end of the week. 

