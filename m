Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135215AbRAJO5G>; Wed, 10 Jan 2001 09:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbRAJO44>; Wed, 10 Jan 2001 09:56:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12105 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135215AbRAJO4p>; Wed, 10 Jan 2001 09:56:45 -0500
Date: Wed, 10 Jan 2001 15:56:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110155624.D19503@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com> <18634.979127163@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18634.979127163@redhat.com>; from dwmw2@infradead.org on Wed, Jan 10, 2001 at 11:46:03AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 11:46:03AM +0000, David Woodhouse wrote:
> So the VM code spends a fair amount of time scanning lists of pages which 
> it really can't do anything about?

Yes.

> Would it be possible to put such pages on different list, so that the VM

Currently to unmap the other pages we have to waste time on those unfreeable
pages as well.

Once I or other developer finishes with the reverse lookup from page to
pte-chain (an implementation from DaveM just exists) we'll be able to put them
in a separate lru, but it's certainly not a 2.4.1-pre2 thing.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
