Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313725AbSDHUvK>; Mon, 8 Apr 2002 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDHUvJ>; Mon, 8 Apr 2002 16:51:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59398 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313725AbSDHUvJ>; Mon, 8 Apr 2002 16:51:09 -0400
Date: Mon, 8 Apr 2002 22:51:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work
Message-ID: <20020408205110.GA31172@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz> <1018254348.571.129.camel@psuedomode> <20020408102508.GA2494@elf.ucw.cz> <1018275683.10462.134.camel@psuedomode> <20020408150005.GC29960@atrey.karlin.mff.cuni.cz> <1018279092.10463.155.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > the documentation suggests that you do not need to specify resume= .  Is
> > > this only true if you have the sysvinit patch in use?  Is swapon -a
> > 
> > Then docs is wrong.
> > 								Pavel
> Then you need to change this from your previous "all in one" patch.
> 
> from the swsusp.txt in "Using the code" 3rd paragraph
> <
> Either way it saves the state of the machine into active swaps and then
> reboots. By the next booting the kernel's resuming function is either
> triggered by swapon -a (which is ought to be in the very early stage of
> booting) or you may explicitly specify the swap partition/file to resume
> from with ``resume='' kernel option. 
> >
> This seems to suggest that you have a choice. Which last time i checked,
> you dont.  

Fixed, thanx.

> from the swsusp.txt in "How the code works" 2nd paragraph
> Same thing as before basically.  swapon -a does not trigger a resume
> 
> under warnings! 
> Ext3 fs seems to show no more of a risk than a non-journalling fs.
> perhaps that problem is reiserfs only?

Warning about journalling filesystem was obsoleted. In now should work
okay with journalled filesystems.

> Also, mention of the swap files being described in fstab is made in
> "Using the code" but no mention is made to how they must be loaded and
> must be actual raw partitions.  Files of course would not work as viable
> swaps for resume because the fs would have to be mounted to load them.

Killed relevant part.


> and one more thing.  What happens when you have multiple swap files all
> of equal priority (normal swap conditions have a striping effect (like
> raid))  Will swsusp choose one ?   How do we know which one it chose? Is
> it just the first one in /proc/swaps all the time?  That kind of
> behavior would be nice to document in swsusp.txt.  

Just don't use multiple swap partitions for now.

> Thanks for the patches.  it seems to work on my non X box (p4)  just
> fine.  I'll have to risk disaster and try it out on a dri X session soon
> since that's where the convenience would come into play. 

Switch to text console and do suspend there. That should work.

				Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
