Return-Path: <linux-kernel-owner+w=401wt.eu-S965086AbXADWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbXADWhN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbXADWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:37:13 -0500
Received: from pqueuea.post.tele.dk ([193.162.153.9]:37514 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbXADWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:37:11 -0500
X-Greylist: delayed 1773 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 17:37:11 EST
Subject: Re: BUG, 2.6.20-rc3 raid autodetection [repost due to forgotten CC]
From: Redeeman <redeeman@metanurb.dk>
Reply-To: redeeman@metanurb.dk
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1167947115.8595.6.camel@localhost>
References: <1167936465.6594.5.camel@localhost>
	 <58cb370e0701041107n5369edfdj2efc871de0fe7d24@mail.gmail.com>
	 <1167940677.8595.1.camel@localhost>
	 <58cb370e0701041207s5c2e3e26j434dd7fe6809e50b@mail.gmail.com>
	 <1167944429.8595.3.camel@localhost>
	 <58cb370e0701041306w5c99c974j1137883b7b95a8@mail.gmail.com>
	 <1167947115.8595.6.camel@localhost>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 23:06:26 +0100
Message-Id: <1167948386.8595.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 22:45 +0100, Kasper Sandberg wrote:
> On Thu, 2007-01-04 at 22:06 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > On Thu, 2007-01-04 at 21:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > > On Thu, 2007-01-04 at 20:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > > > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > > > > Hello.
> > > > > > >
> > > > > > > i just attempted to test .20-rc3-git4 on a box, which has 6 drives in
> > > > > > > raid5. it uses raid autodetection, and 2 ide controllers (via and
> > > > > > > promise 20269).
> > > > > > >
> > > > > > > there are two problems.
> > > > > > >
> > > > > > > first, and most importantly, it doesent autodetect, i attempted with
> > > > > > > both the old ide drivers, and the new pata on libata drivers, the drives
> > > > > > > appears to be found, but the raid autoassembling just doesent happen.
> > > > > > >
> > > > > > > this is .17, which works:
> > > > > > > http://sh.nu/p/8001
> > > > > > >
> > > > > > > this is .20-rc3-git4 which doesent work, in pata-on-libata mode:
> > > > > > > http://sh.nu/p/8000
> > > > > > >
> > > > > > > this is .20-rc3-git4 which doesent work, in old ide mode:
> > > > > > > http://sh.nu/p/8002
> > > > > >
> > > > > > For some reason IDE disk driver is not claiming IDE devices.
> > > > > >
> > > > > > Could you please double check that IDE disk driver is built-in
> > > > > > (CONFIG_BLK_DEV_IDEDISK=y in the kernel configuration)
> > > > > > and not compiled as module?
> > > > > i need not check even once, i do not have module support enabled, so
> > > >
> > > > OK
> > > >
> > > > > everything 1000000% surely is built in. this is the case for .17 too
> > > > > (and earlier, this box was started with .15 i think.)
> > > >
> > > > Could you send me your config?
> > > > I'll try to reproduce this locally.
> > > sure thing.
> > >
> > > http://sh.nu/p/8004 <-- .17 working
> > 
> > CONFIG_BLK_DEV_IDEDISK=y
> > 
> > > http://sh.nu/p/8005 <-- .20-rc3-git4 nonworking, idemode, the one with
> > > libata i dont have anymore, but the only difference is that i use the
> > > libata drivers, but as its same result, shouldnt matter
> > 
> > # CONFIG_BLK_DEV_IDEDISK is not set
> > 
> > so not everything is "1000000% surely" built-in ;)
> i see your point, im afraid i may have misinterpreted you, since you
> said "and not compiled as module", so i thought you meant i had to make
> sure it wasnt moduled only.
> 
> i will try with this now, what about pataonlibata, do i need this for
> that too?
> > 
> > Bart
> > 
-- 
Redeeman <redeeman@metanurb.dk>

