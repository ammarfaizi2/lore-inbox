Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266919AbRGHQsl>; Sun, 8 Jul 2001 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266920AbRGHQs3>; Sun, 8 Jul 2001 12:48:29 -0400
Received: from geos.coastside.net ([207.213.212.4]:38887 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S266919AbRGHQsQ>; Sun, 8 Jul 2001 12:48:16 -0400
Mime-Version: 1.0
Message-Id: <p05100312b76e3e9b2e53@[207.213.214.37]>
In-Reply-To: <Pine.GSO.4.21.0107080320280.28651-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0107080320280.28651-100000@weyl.math.psu.edu>
Date: Sun, 8 Jul 2001 09:46:18 -0700
To: Alexander Viro <viro@math.psu.edu>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Eugene Crosser <crosser@average.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:26 AM -0400 2001-07-08, Alexander Viro wrote:
>On Sat, 7 Jul 2001, Jamie Lokier wrote:
>
>>  Daniel Phillips wrote:
>>  > > Reading a tarball is the distillation of what you describe into
>>  > > efficient form :)
>>  >
>>  > /me downloads tar file definition
>>  >
>>  > Um, gnu tar or posix tar? or some new, improved tar?
>>
>>  I suggest cpio, which is more compact and in some ways more standard.
>>  (tar has a silly pad-to-multiple-of-512-byte per file rule, which is
>>  inappropriate for this).  GNU cpio creates cpio format just fine.
>
>GNU cpio is a race-ridden unmaintained pile of junk. Look at the size
>of, say it, Debian patch to upstream source. Then try to read the
>patched code.  Quite a few of us simply don't have that FPOS on their
>boxen.
>
>Using cpio archive layout is OK, but _please_, don't make it dependent
>on GNU cpio.

If size is an issue (and of course it is), presumably the archive 
would be compressed. As long as tar can be convinced to pad with 
(say) nulls, the padding shouldn't have that much of an impact on 
archive size.
-- 
/Jonathan Lundell.
