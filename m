Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRG0Pfj>; Fri, 27 Jul 2001 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRG0PfY>; Fri, 27 Jul 2001 11:35:24 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:8455 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268841AbRG0Pev>; Fri, 27 Jul 2001 11:34:51 -0400
Message-ID: <3B6189E2.77F072DD@namesys.com>
Date: Fri, 27 Jul 2001 19:33:54 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <0107271706460G.00285@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips wrote:
> 
> On Friday 27 July 2001 16:18, Joshua Schmidlkofer wrote:
> > I've almost quit using reiser, because everytime I have a power
> > outage, the last 2 or three files that I've editted, even ones that I
> > haven't touched in a while, will usually be hopelessly corrupted.
> 
> My early flush patch will fix this, or at least it will if I get
> together with the ReiserFS guys and figure out how to integrate their
> flushing mechanism with the standard bdflush.  Or they could
> incorporate the ideas from my early flush in their own flush daemon,
> though generalizing the standard flush would have more value in the
> long run.

Can you describe early flush?

> 
> > The '<file>~' that Emacs makes is usually fine though.
> 
> Because it's "created" by a rename.
> 
> [...]
> >     Once,  I lost power in on my SQL box, [it was blessedly during a
> > period of no use.]  I had to rebuild all the indexes.  Not  only
> > THAT, but what happens to that box if I lose power whilst in the
> > middle of operations? I am working on the migration plan to move that
> > to XFS because of these concerns. [However, I am doing a better job
> > of testing with XFS first.]
> 
> Help is on its way.  You can try full-data journalling with the journal
> on NVRAM or on a separate disk.  You can also wait for me to get a

Well, if you have NVRAM, you might try using our new journal relocation patch to put the journal on
NVRAM.

> I think it's not hard to fix.
> 
> --
> Daniel
