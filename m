Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSGYPwy>; Thu, 25 Jul 2002 11:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSGYPwy>; Thu, 25 Jul 2002 11:52:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61191 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315419AbSGYPwx>; Thu, 25 Jul 2002 11:52:53 -0400
Date: Thu, 25 Jul 2002 08:57:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Matt_Domsch@Dell.com, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.28 and partitions
In-Reply-To: <Pine.GSO.4.21.0207250739390.17037-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0207250855030.4966-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2002, Alexander Viro wrote:>
> On Wed, 24 Jul 2002, Linus Torvalds wrote:
> > Right now that means that 16TB really is a hard limit for at least some
> > device access on a 32-bit machine with a 4kB page-size (yes, you could
> > make a filesystem that is bigger, but you very fundamentally cannot make
> > individual files larger than 16TB).
>
> ITYM "8Tb" - indices are signed, IIRC.  OTOH, it's not 2^31 * PAGE_SIZE -
> it's 2^31 * PAGE_CACHE_SIZE, which can be bigger.

Hmm. The index really should be unsigned, but obviously there could be
sign errors.

The stupid BSD approach of putting metadata in negative offsets is just
that - stupid. Under Linux the people who do that just have another
address space for metadata.

Your PAGE_CACHE_SIZE vs PAGE_SIZE thing is true, but separating the two
out is going to be less than pleasant in practice, methinks.

		Linus

