Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317195AbSFBPRe>; Sun, 2 Jun 2002 11:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317196AbSFBPRd>; Sun, 2 Jun 2002 11:17:33 -0400
Received: from dsl-213-023-038-078.arcor-ip.net ([213.23.38.78]:12437 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317195AbSFBPRc>;
	Sun, 2 Jun 2002 11:17:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: KBuild 2.5 Impressions
Date: Sun, 2 Jun 2002 17:16:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu> <E17EWV7-0000Pv-00@starship> <20020602165643.A1940@mars.ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17EX5v-0000Qd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 June 2002 16:56, Sam Ravnborg wrote:
> On Sun, Jun 02, 2002 at 04:38:33PM +0200, Daniel Phillips wrote:
> > You mean, fixing the bugs you introduced by trying to add it piecemeal?
> > How about breaking it up where it makes sense to do so, and not breaking
> > it up where it's silly.
>
> Can we agree that it makes sense to add features one-by-one when
> they are independent?

Oh absolutely, and have you looked at the current factoring?

   http://marc.theaimsgroup.com/?a=102296100300003&r=1&w=2

This is still being improved, of course.

> If thats the case then it is a simple matter of looking through the
> features already present in kbuild-2.5.
> Then to compare those features with the work done by Kai.

Well, actually a lot of the work done by Kai is simply importing
portions of Keith's work that break out easily, which is purely
duplication of effort, since such work is already in progress.  In
fact it creates more work, because then we have to go parse Kai's
patches and find out what he submitted, then see if it gets applied
so we can mark it 'applied' in the list.  This is a real waste of
time, and did I mention, it's divisive?

> If the feature is worth it and can be introduced without the core,
> then introduce it in kbuild-2.4.
> This will make this specific feature visible to many people, and 
> those who feel against it can speak up.
>
> > If you have a specific suggestion about which part should be broken out,
> > feel free to provide details.
>
> I already gave a list of features that could be broken out. Do you request
> more information than that?

Yes, those seem to be good suggestions.  What I'd suggest is: import
enough of kbuild 2.5 to support the feature (in some case nothing
needs to be imported), then make it work also for old kbuild (in
some cases that will require no work.  This I'd call cooperation,
which would look good on everybody involved.

I'm not working on this, please pass your specific suggestions to:

   Thunder from the hill <thunder@ngforever.de>

> I already submitted 4 patches digged out from kbuild-2.5, one of them
> introducing a bug. The bug was present in kbuild-2.5!
> This bug was easy to spot since the patch was selfcontained, but
> within several thousands of kbuild-2.5 source lines it would have been missed
> most probarly.

Good point.  The bright side of all this is, we're getting more eyeballs
than ever actually looking at the code, and chances are, even thinking
about how it works.

By the way, kbuild 2.5 running on 2.4.19-pre9 turns in a build time of
5.4 seconds when nothing needs to be rebuilt and 8.3 seconds after
touch fs/ext2/inode.c, on my 2 x 1 GHz compile box.  And so far, hasn't
embarrassed itself once.

-- 
Daniel
