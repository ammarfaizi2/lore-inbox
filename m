Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293476AbSCFLbA>; Wed, 6 Mar 2002 06:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293478AbSCFLat>; Wed, 6 Mar 2002 06:30:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16398 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293476AbSCFLak>; Wed, 6 Mar 2002 06:30:40 -0500
Date: Wed, 6 Mar 2002 12:30:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020306113033.GE27043@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> <20020228160552.C23019@devcon.net> <20020304162614.C96@toy.ucw.cz> <20020305222910.A17336@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020305222910.A17336@devcon.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, and I *did* need unrm few times. Few examples:
> > 
> > /dev# rm sbpcd *     (simple typo, recovered by immediate powerdown + fsck)
> 
> % rm sbpcd *
> zsh: sure you want to delete all the files in /dev [yn]? n
> rm: remove write-protected file `sbpcd'? n
> %

Is it decent enough to do rm -rf /usr/src/linux without asking?

> > /big$ mp1enc > samotari.mpg (oops, I did it twice, second time by mistake, and
> > 		powerswitch was too far away to make it in time)
> > 
> > So yes, unrm is usefull. And it would be even more usefull if it recovered
> > truncated files, too.  How many times did you do > instead of >>? I did that
> > mistake many times, its just easy..
> 
> % cat > foo
> zsh: file exists: foo
> % cat >| foo
> [Now zsh is quiet. It even "fixes up" the history if you want so, so
> that you can simply press "Up"+"Enter" if you really want to overwrite
> the file]

This would not help. mp1enc has nasty habit of randomly not starting,
so I had to repeat the command above few times. What was wrong was
that I repeated it one time too many times.

> Surely, protection against typos etc. has its value. But do it at the
> place where does typos happen (ie. at the shell prompt), not by
> messing with lowlevel stuff like the unlink syscall, which

Not sure it is possible. What you want is safety nets in every
app.

>   a) catches only very few ways of destroying a files contents
>   b) poses a /great/ deal of complexity on you (like having to
>      identify tempfiles, managing disk space etc.)

Really? ext2 *already* is undelete capable. mc: cd /#undel:hda3. So,
where's that great complexity?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
