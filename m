Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268690AbRG0Pc2>; Fri, 27 Jul 2001 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRG0PcS>; Fri, 27 Jul 2001 11:32:18 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:7698 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267643AbRG0PcE>; Fri, 27 Jul 2001 11:32:04 -0400
Message-ID: <3B61893D.A532BD6F@namesys.com>
Date: Fri, 27 Jul 2001 19:31:09 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> > For instance, they compile it with the wrong options set, their boot scripts are wrong, they just
> > shovel software onto the CD.
> 
> Sorry Hans you can rant all you like but you know you are wrong on most
> of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
> and didn't ship until we stopped seeing corruption problems with the mm/fs
> code.
> 
> That test suite caught bugs in kernel revisions other vendors shipped
> blindly to their customers without fixing.
> 
> That is hardly shovelling software onto the CD.
> 
> > Actually, I am curious as to exactly how they manage to make ReiserFS boot longer than ext2.  Do
> > they run fsck or what?
> 
> No. The only thing I can think of that might slow it is that we build with
> the reiserfs paranoia/sanity checks on. Thats because at the time 7.1 was

Yes, that option should never be on for an end user not having a bug that he wants a more detailed
bug report on.  It just makes us look slow compared to ext2.

2.4.2 was not a stable kernel for any FS, not just for ReiserFS.

2.4.4 was the earliest kernel that should have been called 2.4.0, and sad to say, I bet we won't hit
a really stable kernel for another couple of versions.

I understand the marketing pressure on distributions to ship using 2.4.x as soon as 2.4.0 was
available, and that pressure should never have been generated upon them by making an unstable kernel
be named 2.4.0.

It won't surpise me if you agree with me on the kernel naming though, and if so it is pointless for
me to complain to you about it. 

> done the kernel list was awash with reiserfs bug reports and Chris Mason
> tail recursion bug patch of the week.
> 
> That might be something to check to get a fair comparison
> 
> Alan

I don't think that even with CONFIG_REISERFS_CHECK on, journal replay can take as long as fsck on
ext2.  reiserfsck though, if that was on, oh, could even RedHat be that desperate to make us look
bad to users as to run reiserfsck at every boot?

I surely hope not, and I'd like to hear that this user just had something individually wrong with
his configuration.

Hans
