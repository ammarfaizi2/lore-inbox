Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSA3Je4>; Wed, 30 Jan 2002 04:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSA3Jeh>; Wed, 30 Jan 2002 04:34:37 -0500
Received: from nrg.org ([216.101.165.106]:33648 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S289014AbSA3Jef>;
	Wed, 30 Jan 2002 04:34:35 -0500
Date: Wed, 30 Jan 2002 01:34:28 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
        <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <3C576648.84CE142B@zip.com.au>
Message-ID: <Pine.LNX.4.40.0201300122590.17246-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Andrew Morton wrote:
> Nigel Gamble wrote:
> > Am I remembering the problem correctly?
>
> I don't think so :)
>
> The problem was that the semaphore was highly contended, so the
> losing process was explicitly scheduling away.
>
> This doesn't necessarily mean that it was a long-held lock.  In
> this case, it was a short-held lock, but it was also very *frequently*
> being held and released.   This is a scenario where a spinlock is
> heaps more appropriate than a semaphore.

Oh, well in that case, I agree that a spinlock is more appropriate.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

