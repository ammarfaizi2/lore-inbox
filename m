Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272448AbRH3UxZ>; Thu, 30 Aug 2001 16:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272449AbRH3UxP>; Thu, 30 Aug 2001 16:53:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12815 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272448AbRH3UxE>; Thu, 30 Aug 2001 16:53:04 -0400
Date: Thu, 30 Aug 2001 22:53:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        research@suse.de
Subject: Re: Reiserfs: how to mount without journal replay?
Message-ID: <20010830225323.A18630@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15246.11218.125243.775849@gargle.gargle.HOWL>; from Nikita@Namesys.COM on Thu, Aug 30, 2001 at 04:04:34PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > For recovering broken machine, I'd like to mount without replaying journal.
> 
> You cannot mount without replaying even in read-only mode, because
> file-system meta-data are possibly inconsistent.

Then suse's  use of reiserfs is pretty b0rken. Putting reiserfsck on /
partition is pretty useless -- if it crashes during mount you can't
repair it.

If reiserfsck detects errors on /, you can't repair them because
reiserfsck is on that partition. Ouch.

>  > [reiserfs panics while replaying journal; seems there are still some bugs
>  > hidden in there]. Unfortunately, "nolog" option does not seem imlemented.
> 
> There is a patch allowing to mount reiserfs if there was io error during
> journal replay on mount. It is included into 2.4.9-ac* tree (it was sent
> to Linus several times, but this did not avail).

I already repaired my system -- had to install another copy of suse to
another partition :-(.

> Can you send to Reiserfs mail-list <Reiserfs-List@Namesys.COM> more
> detailed information about your case, like ksymoopsed stack trace,
> etc.

No stack trace, sorry. It refused to mount saying that attempting to
write into log block.. That's panic. Reiserfsck is not usable in such
case, because ... how do you run reiserfsck from partition you can't
mount?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
