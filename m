Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbTDLFC2 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 01:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTDLFC2 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 01:02:28 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:5275 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263160AbTDLFCB (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 01:02:01 -0400
Date: Sat, 12 Apr 2003 15:13:40 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030412051340.GB455@zip.com.au>
References: <20030401100237.GA459@zip.com.au> <20030401022844.2dee1fe8.akpm@digeo.com> <20030412021638.GA650@zip.com.au> <20030411192413.279f0574.akpm@digeo.com> <20030412023848.GB650@zip.com.au> <20030411195308.11812ee9.akpm@digeo.com> <20030412044840.GA455@zip.com.au> <20030411220158.28f88097.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411220158.28f88097.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 10:01:58PM -0700, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> >
> > Do you still want the alt-sysrq-m stuff? And is there anything else I
> > can do? profiling? apply a patch with debugging stuff that'd give you a
> > clue? etc...
> 
> Can't think of a lot really.

doh.

> Are you sure that fsck is only running journal recovery?  Is it possible that
> it is performing a full fsck for some reason?

It's still in the journal stage. 2 reasons lead me to believe this:

1. if I hit ^c then mount does the journal recovery (and does it
   quick-smart - the hd light is on full-force during this)
2. the progress bar that comes up during a full fsck is not displayed.

> Make sure you're running current e2fsprogs?

I've compiled 1.32+1.33-WIP-2003.03.30 (debian e2fsprogs from sid). I'll
install that now.

> Boot with `init=/bin/sh', run fsck by hand in the background, poke around
> with `ps' to see what it's up to, etc.

I'll try to remember to do this when my laptop loses power again (it
happens often - power connector is wonky). Don't wanna do it right now
cos I have the connector in just the right spot so that the laptop is
actually getting power.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
