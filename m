Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312065AbSCQQXv>; Sun, 17 Mar 2002 11:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312066AbSCQQXm>; Sun, 17 Mar 2002 11:23:42 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:12284 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312065AbSCQQXa>; Sun, 17 Mar 2002 11:23:30 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020317075443.A15420@work.bitmover.com> 
In-Reply-To: <20020317075443.A15420@work.bitmover.com>  <3C938027.4040805@mandrakesoft.com> <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <30393.1016362174@redhat.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 16:23:21 +0000
Message-ID: <16049.1016382201@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
>  BK works that way on purpose.  If we merge changes into your local
> changes, there is no automatic way to "unmerge".  It is way to easy to
> do a pull, do the merge, and then realize you lost work in the merge
> because you told it to do the wrong thing.

> Short summary: commit your changes before you pull and you'll be fine.

If it was changes that deserved a changelog, I'd have committed them. But 
it's typically one-line hacks to make it compile, which I know will be 
obsoleted by 'correct' fixes in Linus' tree later. I don't want them (and 
the subsequent merges and conflicting new files) cluttering up my tree, 
especially as AFAICT BK won't let me undo the change later if I commit any 
changes after it - even if the later changes are _completely_ unrelated.

Btw, the citool is cute but would be cuter if
 - the diffs were '-up' format - showing the function that the hunk is in.
 - You could select a hunk and say "omit this change from what's committed"

Again, the latter is because some stuff really does live as local hacks in 
a build tree and never deserves the honour of a changelog entry.

Another thing I have a distinct feeling I'm going to want is tracking
functions across files. I sometimes shuffle functions between files for
portability - selective compilation is nicer with your Linux-specific
functions in one file and eCos-specific functions in another than with a
litter of ifdefs. If Linus' tree gets a patch to a file that I moved, BK can
work it out. If Linus' tree gets a patch to a _function_ that I moved to a
different file while leaving the rest of the original file in place, AFAICT
not even the merge tool deals with that nicely. Did I miss an option to
'apply this diff hunk to a different file'?


--
dwmw2


