Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312087AbSCQSfD>; Sun, 17 Mar 2002 13:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312091AbSCQSex>; Sun, 17 Mar 2002 13:34:53 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:16382 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312087AbSCQSek>; Sun, 17 Mar 2002 13:34:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020317101507.N10086@work.bitmover.com> 
In-Reply-To: <20020317101507.N10086@work.bitmover.com>  <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <30393.1016362174@redhat.com> <20020317075443.A15420@work.bitmover.com> <16049.1016382201@redhat.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 18:34:29 +0000
Message-ID: <23384.1016390069@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
>  Then you get to save them as diffs, unedit the files, and put them
> back  after the merge. 

I can do better than that. If I save them as diffs, I don't get to use your 
cute merge tools. I could commit them with a throwaway changelog, do the 
pull and use the merge tools, then copy the resulting files, undo both the 
pull and the previous merge, do the pull again and then lock the files and 
drop the previously-saved copies into place.

It's a bit contrived though - it would be nice if BK would do something 
like that for me instead of just bailing out when files are modified. 
Asking me if I'm really sure I want to continue is fine. Aborting 
unconditionally less so.

>  citool is a tcl program, how about you hack it in?  Look for
> $diffsOpts, that's what you'll need to modify.  You need to get the
> diffs parsing  code to do the right thing with -up style diffs though.

Er, actually I can't get 'bk diffs -up' to give output the same as (GNU)
'diff -up' either. What I was after was stuff like:

	@@ -331,6 +331,7 @@ int jffs2_decompress(unsigned char compr

> We don't have this feature.  We've talked about it, but that's all
> we've done.

Which? Actually tracking functions that move between files, or the hack in
the merge tool? I appreciate that the former is a _lot_ harder to achieve.

--
dwmw2


