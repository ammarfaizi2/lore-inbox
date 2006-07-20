Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWGTPOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWGTPOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWGTPOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:14:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:53391 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932588AbWGTPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:13:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R67RVL4pytYpQXwWV/XXr40pKrvUijsKL0gN+c8T5dwMw21v136f9vV0PQpAdEgaIpWcyz4Go3MOD0Hgb/b3l4Zo4U1hBxU+tl9RdhGdO2ahjYFKPbVkNuYJheP6dG+DeNiO2a7w/5NpXBwMatGp6QY07/v1db3+rAFCdIc8ZiM=
Message-ID: <3b0ffc1f0607200813q39ba2303l7623baedd924a5a1@mail.gmail.com>
Date: Thu, 20 Jul 2006 11:13:57 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: FAQ updated (was Re: XFS breakage...)
Cc: "Kasper Sandberg" <lkml@metanurb.dk>,
       "Justin Piszcz" <jpiszcz@lucidpixels.com>,
       "Torsten Landschoff" <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
In-Reply-To: <20060720171310.B1970528@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060718222941.GA3801@stargate.galaxy>
	 <20060719085731.C1935136@wobbly.melbourne.sgi.com>
	 <1153304468.3706.4.camel@localhost>
	 <20060720171310.B1970528@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Nathan Scott <nathans@sgi.com> wrote:
> On Wed, Jul 19, 2006 at 12:21:08PM +0200, Kasper Sandberg wrote:
> > On Wed, 2006-07-19 at 08:57 +1000, Nathan Scott wrote:
> > > On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> > > >
> > > > Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> > > > Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
> > >
> > > I suspect you had some residual directory corruption from using the
> > > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > > fixed in the latest -stable point release).
>
> Correction there - no -stable exists with this yet, I guess that'll
> be 2.6.17.7 once its out though.
>
> > what action do you suggest i do now?
>
> I've captured the state of this issue here, with options and ways
> to correct the problem:
>         http://oss.sgi.com/projects/xfs/faq.html#dir2
>
> Hope this helps.

I actually tried the xfs_db method to fix my / filesystem (as you had
outlined in http://marc.theaimsgroup.com/?l=linux-kernel&m=115070320401919&w=2),
and while it's quite possible that I screwed it up, after a subsequent
xfs_repair run (which completed successfully and moved lots of stuff
to /lost+found, as I would expect), the XFS code had serious problems
with various parts of my filesystem (like "ls /lost+found", which
would cause lots of errors to be logged, although not a complete fs
shutdown). After another run through xfs_repair resulted in a
filesystem that would no longer even successfully boot.

Unfortunately it was a mostly-full 74GB big-/ partition on my primary
machine (a laptop), so I don't have a dump of it for you and my report
is probably pretty useless. :( But on the bright side, virtually all
of the filesystem was otherwise intact and I was able to get all my
data off before rebuilding my system.

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
