Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280818AbRKTBir>; Mon, 19 Nov 2001 20:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280819AbRKTBii>; Mon, 19 Nov 2001 20:38:38 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:32619 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S280818AbRKTBia>;
	Mon, 19 Nov 2001 20:38:30 -0500
Date: Tue, 20 Nov 2001 03:37:01 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: <lk@behemoth.ts.ray.fi>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: Tommi Kyntola <kynde@ts.ray.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
In-Reply-To: <E165zi9-0001AG-00@localhost>
Message-ID: <Pine.LNX.4.33.0111200328550.842-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > And it is not immutable, the only ext2 file attribute set is the "d"
> Not on my system:
> bodnar42:/home/bodnar42# rm /.journal
> rm: remove write-protected file `/.journal'? y
> rm: cannot unlink `/.journal': Operation not permit
>
> That's about as immutable as a file can get, and I'm quite sure I did 
> not set it immutable manually.

Yes my mistake, the .journal is indeed immutable on my other ext3 
partitions, but as you could see from my previous mail, the
immutable wasn't set for that particular partition and
the rm succeeded.

(could be due to the fact that I had to remove it there using
the tune2fs -O to check out wether it's visible or not when
created unmounted)

Even so, I'm wondering wether this removal is standardad
procedure for hiding it once and for all or not?
Since what's there to stop you from 'chattr -i .journal ; rm .journal'.


-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */



