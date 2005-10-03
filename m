Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVJCE4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVJCE4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJCE4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:56:06 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:2011 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750830AbVJCE4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:56:05 -0400
Subject: Re: Strange disk corruption with Linux >= 2.6.13
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051001213655.GE6397@ime.usp.br>
References: <20050927111038.GA22172@ime.usp.br>
	 <1127863912.4802.52.camel@localhost>  <20051001213655.GE6397@ime.usp.br>
Content-Type: text/plain; charset=iso-8859-1
Organization: Cyclades
Message-Id: <1128315323.7234.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 03 Oct 2005 14:55:23 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2005-10-02 at 07:36, Rogério Brito wrote:
> On Sep 28 2005, Nigel Cunningham wrote:
> > Hi Rogerio.
> 
> Hi, Nigel.
> 
> > On Tue, 2005-09-27 at 21:10, Rogério Brito wrote:
> > > Hi there. I'm seeing a really strange problem on my system lately and I
> > > am not really sure that it has anything to do with the kernels.
> > 
> > I've seen the thread mostly following the hardware line. I'd like to
> > enquire down the kernel path because I've seen occasional, impossible
> > to reproduce problems too.
> 
> Nice. I also don't want to rule out anything before I really understand
> what's going on.
> 
> > Can I ask first a few questions:
> 
> Of course.
> 
> > 1) Are you using vanilla kernels, or do you have other patches applied?
> 
> Yes, all the kernels that I use are just plain vanilla kernels taken
> straight from kernel.org. No other patches applied.

Ok. That's helpful.

> > 2) Are you using ext3 only?
> 
> Yes, I am.
> 
> > 3) Is the corruption only ever in memory, or seen on disk too?
> 
> I have noticed the problem mostly on disk. One strange situation was
> when I was untarring a kernel tree (compressed with bzip2) and in the
> middle of the extraction, bzip2 complained that the thing was
> corrupted.
> 
> I removed what was extracted right away and tried again to extract the
> tree (at this point, suspecting even that something in software had
> problems). The problem with bzip2 occurred again. Then, I rebooted the
> system an the problem magically went away.

If you see it in a form where you can see the amount of corruption, can
you see if it is just four bytes?

I'm asking because I have recently started seeing
impossible-to-reliably-reproduce corruption here, which seems to be only
four bytes at a time, in memory originally but possibly also appearing
on disk (probably because of syncing). I originally wondered if it might
be Suspend2 related (in the first instance, assume I messed up :)), but
I haven't been sure. The corruption I'm seeing only affects the root
filesystem. None of this makes much sense if I assume it's a Suspend2
bug. I could have a bad pointer access somewhere, but the rest is just
confusing.

Regards,

Nigel

> > 4) Is the corruption only in one filesystem or spread across several
> > (if applicable)? (ie in / but not /home or others?)
> 
> I only have one filesystem right now, but given the difficulties that
> I'm seeing, I do plan to go back to a multiple filesystem setup (which I
> always used but thought that was overkill---nothing like time to teach
> us something what is safest).
> 
> If you want to know anything else, don't hesistate to ask.
> 
> 
> Regards,
-- 


