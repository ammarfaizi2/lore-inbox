Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274137AbRIXSZT>; Mon, 24 Sep 2001 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274132AbRIXSZM>; Mon, 24 Sep 2001 14:25:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33216 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274131AbRIXSY5>;
	Mon, 24 Sep 2001 14:24:57 -0400
Date: Mon, 24 Sep 2001 14:25:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
In-Reply-To: <9ont1h$5fl$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109241422270.20253-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Linus Torvalds wrote:

> Well, for one thing I absolutely refused during ext3 development to have
> ext3 just be an "extension" to ext2. That _was_ how it was originally
> thought of, and I very much wanted ext3 to be separate - I strongly felt
> that it would be stupid to force people who use ext2 for "stable"
> reasons to have to get the extensions (and I hate #ifdef's).
> 
> And quite frankly, I don't think we _still_ are at the point where I'd
> be comfortable saying that we could just merge them, and everybody would
> use the superset of the code.

What we can do, though, is to move some of the common code into a
library.  We are not ready to do that right now, but in 2.5 it
might be worth doing.  Same goes for minixfs/sysvfs/ufs - quite
a few things are shared (which is hardly a surprise - filesystems
themselves have a lot in common).

