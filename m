Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291098AbSAaPOo>; Thu, 31 Jan 2002 10:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291099AbSAaPO0>; Thu, 31 Jan 2002 10:14:26 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:6819 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S291098AbSAaPOJ>; Thu, 31 Jan 2002 10:14:09 -0500
Date: Thu, 31 Jan 2002 08:12:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Rohland <cr@sap.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131151256.GD4970@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0201301005260.1989-100000@penguin.transmeta.com> <m3d6zraqn1.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6zraqn1.fsf@linux.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:09:06AM +0100, Christoph Rohland wrote:
> Hi Linus,
> 
> On Wed, 30 Jan 2002, Linus Torvalds wrote:
> > it would see how far back it can go with an automatic merge and add
> > "d" at the _furthest_ point possible. 
> 
> No, I would prefer a way where the developer gives the merge point and
> bk checks if it merges cleanly. Else it is too easy to have merge
> points which are semantically wrong.

Well, provided the 'backmerge' respects tag, or certain kinds of tags
(ie the tree is 'soft tagged' as v2.5.4-pre3, v2.5.4-pre2, v2.5.4-pre1
and 'hard tagged' as v2.5.3.  'backmerge' will attempt to move a change
back only as far as v2.5.3, since v2.5.3 had an API change here.

Or the other option, since this isn't the _default_ behavior, but an
optional one is to give backmerge a 'don't go past tag' since the
developer should be aware that the API changed at v2.5.3 or v2.5.4-pre2
and even tho the change might apply cleanly further back, since it's
updating the driver to the new API, don't try anyways.)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
