Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283795AbRLEQYO>; Wed, 5 Dec 2001 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284459AbRLEQYE>; Wed, 5 Dec 2001 11:24:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:63024 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283795AbRLEQXq>; Wed, 5 Dec 2001 11:23:46 -0500
Date: Wed, 5 Dec 2001 17:23:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <pz@spylog.ru>
Cc: Andrew Morton <akpm@zip.com.au>, theowl@freemail.c3.hu, theowl@freemail.hu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: your mail on mmap() to the kernel list
Message-ID: <20011205172323.C6125@athlon.random>
In-Reply-To: <3C082244.8587.80EF082@localhost>, <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru> <3C08A4BD.1F737E36@zip.com.au> <20011204151549.U3447@athlon.random> <16498470022.20011204183624@spylog.ru> <20011204174824.D3447@athlon.random> <41187009255.20011205191203@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <41187009255.20011205191203@spylog.ru>; from pz@spylog.ru on Wed, Dec 05, 2001 at 07:12:03PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 07:12:03PM +0300, Peter Zaitsev wrote:
> I understand it but does it start so search standard way from the low
> addresses or it looks it above the hint address before looking at
> lower addresses ?

mmap(2) with a "valid" hint (so with enough space in the hole between
'start' and 'start+len') runs with O(log(N)) complexity because it uses
the tree internally to verify that's a valid hole. It's only the search
of an hole that has O(N) complexity, the "check" of one hole has just
O(log(N)) complexity.

Andrea
