Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWBRMzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWBRMzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBRMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38043 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751233AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Thu, 16 Feb 2006 22:53:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Jan Merka <merka@highsphere.net>,
       Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060216215316.GH3490@openzaurus.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com> <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com> <43EF24C0.2040902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EF24C0.2040902@gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> And another fact: Suspend-to-RAM implementation can be derived form
> >> suspend-to-disk but not the other way around.
> > 
> > No, the two are _entirely_ independent.  Suspend-to-RAM does not need to
> > copy memory at all, whereas suspend-to-disk requires it.  That very fact
> > means that suspend-to-RAM is orders of magnitude faster than
> > suspend-to-disk could ever be, especially as RAM gets exponentially larger.
> 
> Well... I see you already planned the implementation and
> have all figured out...
> But the fact is that suspend-to-RAM can be implemented by
> suspend-to-disk without actually store the memory to
> external device...

No, it can not. See Doc*/power/video.txt . And there are more such problems.

> Again... This is a matter of implementation... I believe
> that one complete suspend implementation can suite both disk
> and RAM... The only difference is if you write the state to
> external storage, and how you play with APM. So there is a

How you play with ACPI/hw is major issue. Look at code to learn what you are talking
about. (and nobody uses APM today). 

> Let's see what happened so far:
> 
> First we had swsusp... For many people it did not work, so

...no; for many people it was too slow and not nice enough...

> Suspend2 was developed, but was not merged mainly because it
> had too many UI components in-kernel.

...and because Nigel did not care about mainline for a *long* time.

> Now, you come with a different solution (virtualization), so
> let's delay suspend feature for how long? At least two years?

Virtualization is separate topic. It could be used for s-t-disk,
but it is quite heavy solution, and not likely to be usable for s-t-disk for
4+ years.

> We need (and can get) suspend to work *NOW*, laptops are
> being more and more common... People expect to have this
> ability in a modern operating system, they don't care if it
> is implemented in kernel or in user-space, they also don't
> care if you change it along the way... And if in the future
> Linux will be pure virtual machine, all will be happy....
> And use it... But please consider offering a working
> solution *NOW*.

We have working solution *NOW*. It is called swsusp. If it does not work for you,
report it using bugzilla.kernel.org.

If you want something nicer/faster, help with suspend.sf.net.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

