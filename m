Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbRGZPsz>; Thu, 26 Jul 2001 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268138AbRGZPsq>; Thu, 26 Jul 2001 11:48:46 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:42886 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S268137AbRGZPsi>; Thu, 26 Jul 2001 11:48:38 -0400
Date: Thu, 26 Jul 2001 17:48:44 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726174844.W17244@emma1.emma.line.org>
Mail-Followup-To: Christoph Hellwig <hch@ns.caldera.de>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010726164516.R17244@emma1.emma.line.org> <200107261502.f6QF2Go10488@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200107261502.f6QF2Go10488@ns.caldera.de>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig schrieb am Donnerstag, den 26. Juli 2001:

> > MTAs do NOT care how the file system is internally managed, they only
> > rely on the rename operation having completed physically on disk before
> > the "my rename call has returned 0" event. They expect that with the
> > call returning the rename operation has completed ultimately, finally,
> > for good, definitely and the old file will not reappear after a crash.
> 
> So they rely on undocumented and non standadisized semantics of some
> implementations.  I'd call this buggy.

If each in the set of "supported systems" document this behaviour for
themselves, there is no bug. I didn't check however for systems other
than FreeBSD 4.x and Linux. And "Linux support" forces these semantics
with chattr +S, at a high price.

Go tell your opinion to those people that refuse to wrap their
rename/link calls with open()/fsync() calls to the respective parents,
particularly Daniel J. Bernstein, Wietse Z. Venema, among others. I
don't possibly know all MTAs.

You will encounter these or similar questions/objections:

1. what systems apart from Linux need this kind of Pampers?

2. manual lookups of parent directories cause additional overhead better
avoided in performance critical systems.

You would not be the first one to tell them...
