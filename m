Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRG0O4s>; Fri, 27 Jul 2001 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbRG0O4i>; Fri, 27 Jul 2001 10:56:38 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17676 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266715AbRG0O4f>; Fri, 27 Jul 2001 10:56:35 -0400
Message-ID: <3B6180CD.9D68CC07@namesys.com>
Date: Fri, 27 Jul 2001 18:55:09 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Joshua Schmidlkofer wrote:
> 
> I've almost quit using reiser, because everytime I have a power outage, the
> last 2 or three files that I've editted, even ones that I haven't touched in
> a while, will usually be hopelessly corrupted.  The '<file>~' that Emacs
> makes is usually fine though.   It seems to be that any open file is
> in danger.  I don't know if this is normal, or not, but I switched to XFS on
> several machines.  I have nothing against reiser.  I assumed that these
> problems were due to immaturity....
> 
>    One more thing - All my computers with Reiser as '/'  on them had a
> disturbingly long boot time.   From the time when the Redhat startup scripts
> began, it was.... hideously slow.   I thought nothing of it, blaming bash,

Don't use RedHat with ReiserFS, they screw things up so many ways.....

For instance, they compile it with the wrong options set, their boot scripts are wrong, they just
shovel software onto the CD.

Use SuSE, and trust me, ReiserFS will boot faster than ext2.

Actually, I am curious as to exactly how they manage to make ReiserFS boot longer than ext2.  Do
they run fsck or what?

Hans

> etc, Until I switched to ext2 on all those.  Now the boot time is...  SUPER
> fast.  [3 Computers, 1 K6-2, a Pentium III, and a Pentium II, all 128+meg,
> and IDE] I currently have 3 computers running reiserfs left, all are using
> MySQL databases.
>     Once,  I lost power in on my SQL box, [it was blessedly during a
> period of no use.]  I had to rebuild all the indexes.  Not  only THAT, but
> what happens to that box if I lose power whilst in the middle of operations?
> I am working on the migration plan to move that to XFS because of these
> concerns. [However, I am doing a better job of testing with XFS first.]
> 
>   I think that Reiser is cool, and has neat ideology, but I am un-nerved by
> this behaviour.
> 
> js
> 
> >
> > Yup. I know ext2 can do it. I expect a filesystem to not foul up my data
> > when something happens. Especially not shuffle around sectors in several
> > files. I can understand that the changes I made are not on disc, I can
> > even understand it if my files are gone, but not when it corrupts my data.
> > That just plain sucks.
> >
> > A friend of mine has had crashes as well (not reiser related btw), where
> > files he was using at the time suddenly contained different pieces of
> > different files. It's just plain annoying. The reason why *I* use(d)
> > reiserfs was the fact that I thought that it would protect my data when
> > something does crash. From my experience, it doesn't, and I'd rather wait
> > a couple of minutes for ext2 to fsck than use reiserfs and be sure I can
> > start all over again.
> >
> > Regards,
> >
> > Bas Vermeulen
