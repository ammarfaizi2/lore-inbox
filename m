Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275363AbRJBPfd>; Tue, 2 Oct 2001 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275377AbRJBPfX>; Tue, 2 Oct 2001 11:35:23 -0400
Received: from waste.org ([209.173.204.2]:32121 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S275363AbRJBPfM>;
	Tue, 2 Oct 2001 11:35:12 -0400
Date: Tue, 2 Oct 2001 10:37:50 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: /dev/random entropy calculations broken?
In-Reply-To: <20011002015114.A24826@turbolinux.com>
Message-ID: <Pine.LNX.4.30.0110021031151.19213-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Andreas Dilger wrote:

> Fifth fix: in extract_entropy() the "redundant but just in case" check was
>   wrong, comparing entropy bit count and pool words.  This had the effect
>   of losing 31/32 of the random pool on each access.  BAD, BAD program!

> +	if (r->entropy_count > r->poolinfo.poolwords * 32)
> +		r->entropy_count = r->poolinfo.poolwords * 32;

Damnit, I read that line 30 times yesterday!

While we're on words/bytes/bits confusion, add_entropy_words() seems to
get called with number of bytes rather than words.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

