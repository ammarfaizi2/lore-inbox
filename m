Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFJKMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFJKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:11:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:9232 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261411AbTFJKKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:10:02 -0400
Date: Tue, 10 Jun 2003 12:23:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610122326.13fe8889.skraw@ithnet.com>
In-Reply-To: <122650000.1055172730@caspian.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<122650000.1055172730@caspian.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jun 2003 15:32:11 +0000
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> > For Justin:
> > Thank you for your continous openness and support in the whole issue in
> > form of exactly _zero_ comments (,besides "how do you know aic is to
> > blame?").
> 
> Stephan,
> 
> Other than your most recent complaint that the driver doesn't function
> correctly in an SMP kernel when you specify the nosmp option, you have
> yet to provide any information that points to a problem in the aic7xxx
> driver.

Dear Justin,

I am really not complaining about you not helping specifically _me_, I am
complaining about your quite visible general opinion that this whole thing is
really not serious, or maybe it is only that you are not making your efforts
transparent to others, I don't know.

>  Without such information, I'm at a loss to help you.  One thing
> that you forgot to mention in your "report" is that data corruption can
> happen in many more places than just in the aic7xxx driver.

<sarcasm>Did I mention the big magnet right beside the tape?</sarcasm>

>  The data
> could be corrupted by a VM bug,

VM is quite the same, tar'ing to /dev/tape or /var/bak/mybackfile.tar.

> a buffer layer bug, or a filesystem
> bug.

/dev/tape with a filesystem? Have you read what we are talking about?

>  When testing our drivers against RHAS2.1 we found that the stock
> kernel had data corruption issues very similar to what your are talking
> about when run on very fast, hyperthreading, SMP machines.  The data
> corruption occurred with any SCSI controller we tried, regardless of vendor.

My question is: is it solved?

> If you continue to feel that the aic7xxx driver is at fault, I encourage you
> to try to reproduce this failure with someone elses card.  I think you'll
> find that the problem persists even with this change.

This is not the first discussion about an instability in aic. We had the same
thing months ago for another setup (where btw you said the same thing). Back
then I switched to symbios and everything went ok from then on. Thing is: I am
not a big learner, I just re-tried with aic now, and it happened again. I will
do the same thing now like back then: switching to symbios. Be sure I am going
to tell my experiences. Be aware that I have already received reports from
others with the same problem solving it the same way - switching away from aic.

> I will be more than happy to look into why the aic7xxx driver may not
> operate correctly in an SMP kernel with the nosmp option.  Considering
> that your complaint about this failure came into my email box just
> yesterday, perhaps you can give me just a few days to look into this
> before you decide to call me unresponsive.  Since I'm attending a
> conference this whole week, I won't even be able to look at this
> until I return on Monday of next week.

Justin, this is nothing quite serious, I just mentioned it for a feedback to
something _simple_.

> I'm sorry that you are experiencing data corruption.  I take those
> issues very seriously, but all of your panics and other reports point
> to issues elsewhere in the kernel that should be resolved before you
> conclude that the data corruption you are experiencing is somehow
> the aic7xxx driver's fault.  I'll be more than happy to fess up to
> and correct any defect that is found in the driver, but I cannot fix
> bugs that I cannot reproduce and that have no usable debugging information
> associated with them.

What exactly is "elsewhere" if your data is bogus when tar'ing onto /dev/tape
via aic and it is completely ok when tar'ing into a file via reiserfs/3ware ?
There is not really much left between tar and the aic-driver and the tape.
Where is your favourite in this game?

Regards,
Stephan

