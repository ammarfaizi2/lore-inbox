Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSDUCKb>; Sat, 20 Apr 2002 22:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDUCKa>; Sat, 20 Apr 2002 22:10:30 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31250 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293048AbSDUCK3>; Sat, 20 Apr 2002 22:10:29 -0400
Date: Sun, 21 Apr 2002 04:09:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020421040942.Q1291@dualathlon.random>
In-Reply-To: <20020420201205.M1291@dualathlon.random> <Pine.LNX.4.33.0204201221120.11732-100000@penguin.transmeta.com> <20020420214114.A11894@wotan.suse.de> <20020420232818.N1291@dualathlon.random> <3CC1EF05.6000702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 03:43:17PM -0700, H. Peter Anvin wrote:
> Andrea Arcangeli wrote:
> >
> >As said in an earlier email it is a matter of memory bandwith, 59 bytes
> >of icache and zero data, against 7 bytes of icache and 512bytes of data.
> >the 512bytes of data are visibly slower, period. Saving mem bandwith is
> >much more important than reducing the number of instructions, even more
> >on SMP!
> >
> 
> It's not 512 bytes of data -- only the part that's actually used is 
> accessed.

On current x86 yes (so far), but the x86-64 the whole 512bytes will have
to be read from ram instead.

Andrea
