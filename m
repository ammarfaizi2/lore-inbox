Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRAaIEq>; Wed, 31 Jan 2001 03:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130367AbRAaIEg>; Wed, 31 Jan 2001 03:04:36 -0500
Received: from smtp.mountain.net ([198.77.1.35]:21509 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S130214AbRAaIER>;
	Wed, 31 Jan 2001 03:04:17 -0500
Message-ID: <3A77C6E7.606DDA67@mountain.net>
Date: Wed, 31 Jan 2001 03:03:51 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: Stephen Frost <sfrost@snowman.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Mhm.  Is it worth the effort to make a dependancy on the CPU type for SMP?
> 
> </idle questions>
> 
> -d
> 
> Stephen Frost wrote:
> 
> > * David Ford (david@linux.com) wrote:
> > > A person just brought up a problem in #kernelnewbies, building an SMP
> > > kernel doesn't work very well, current is undefined.  I don't have more
> > > time to debug it but I'll strip the config and put it up at
> > > http://stuph.org/smp-config
> >
> >         They're trying to compile SMP for Athlon/K7 (CONFIG_MK7=y).
> 

It's not an incompatibility with the k7 chip, just bad code in
include/asm-i386/string.h. in_interrupt() cannot be called from there.

I have posted a patch here many times since last May. Most recent was
Saturday.

Tom
--
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
