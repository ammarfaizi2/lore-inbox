Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHQH44>; Fri, 17 Aug 2001 03:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269849AbRHQH4n>; Fri, 17 Aug 2001 03:56:43 -0400
Received: from nef.ens.fr ([129.199.96.32]:14599 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S269807AbRHQH4e>;
	Fri, 17 Aug 2001 03:56:34 -0400
Date: Fri, 17 Aug 2001 09:56:27 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: ehaase@inf.fu-berlin.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010817095627.A15129@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01081709381000.08800@haneman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01081709381000.08800@haneman> you write:
> "The Other OS" in its professional version does of course clear the
> deleted blocks with 0's for security reasons

That's not much more than a smoke screen, actually. Wiping out data
from a disk requires more than merely writing 0's, if the bad guy is
assumed to physically have hold of the disk. See, for instance, the
paper from Peter Gutmann, "Secure Deletion of Data from Magnetic and
Solid-State Memory" (published in Usenix'96). Such games are much
dependant on the actual writing technology, and harddisk cache (which
cannot be deacticated on some modern IDE disks) gets in the way.
Besides, performance is terrible (if you need to rewrite seven times a
file with different patterns for each deletion, imagine what happens
when you delete a 100 MBytes file...).

The only truly secure way to do is encryption: if all data that gets to
the disk is encrypted, physical details about the disk are unimportant,
so security cannot be compromised by some smarter physicist with more
expensive tools.


	--Thomas Pornin
