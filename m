Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312090AbSCQSP2>; Sun, 17 Mar 2002 13:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312091AbSCQSPT>; Sun, 17 Mar 2002 13:15:19 -0500
Received: from bitmover.com ([192.132.92.2]:138 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312090AbSCQSPK>;
	Sun, 17 Mar 2002 13:15:10 -0500
Date: Sun, 17 Mar 2002 10:15:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020317101507.N10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <30393.1016362174@redhat.com> <20020317075443.A15420@work.bitmover.com> <16049.1016382201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16049.1016382201@redhat.com>; from dwmw2@infradead.org on Sun, Mar 17, 2002 at 04:23:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 04:23:21PM +0000, David Woodhouse wrote:
> 
> lm@bitmover.com said:
> >  BK works that way on purpose.  If we merge changes into your local
> > changes, there is no automatic way to "unmerge".  It is way to easy to
> > do a pull, do the merge, and then realize you lost work in the merge
> > because you told it to do the wrong thing.
> 
> > Short summary: commit your changes before you pull and you'll be fine.
> 
> If it was changes that deserved a changelog, I'd have committed them. But 
> it's typically one-line hacks to make it compile, which I know will be 
> obsoleted by 'correct' fixes in Linus' tree later. 

Then you get to save them as diffs, unedit the files, and put them back 
after the merge.

> Btw, the citool is cute but would be cuter if
>  - the diffs were '-up' format - showing the function that the hunk is in.

citool is a tcl program, how about you hack it in?  Look for $diffsOpts,
that's what you'll need to modify.  You need to get the diffs parsing 
code to do the right thing with -up style diffs though.

>  - You could select a hunk and say "omit this change from what's committed"

Get bk-2.1.5.  We added multiple options to the edit button, try the fmtool
option and learn how to use it.  You can trivially walk the code and pick
and choose which diffs you want.

> Another thing I have a distinct feeling I'm going to want is tracking
> functions across files. I sometimes shuffle functions between files for
> portability - selective compilation is nicer with your Linux-specific
> functions in one file and eCos-specific functions in another than with a
> litter of ifdefs. If Linus' tree gets a patch to a file that I moved, BK can
> work it out. If Linus' tree gets a patch to a _function_ that I moved to a
> different file while leaving the rest of the original file in place, AFAICT
> not even the merge tool deals with that nicely. Did I miss an option to
> 'apply this diff hunk to a different file'?

We don't have this feature.  We've talked about it, but that's all we've
done.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
