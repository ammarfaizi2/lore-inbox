Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSHCW0x>; Sat, 3 Aug 2002 18:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSHCW0x>; Sat, 3 Aug 2002 18:26:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34577 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317922AbSHCW0x>;
	Sat, 3 Aug 2002 18:26:53 -0400
Message-ID: <3D4C5BBB.EBD49EA3@zip.com.au>
Date: Sat, 03 Aug 2002 15:39:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <E17aptH-0008DR-00@starship> <3D4B692B.46817AD0@zip.com.au> <E17b725-00031K-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Wait a second guys, the problem is with the script, look at those CPU
> numbers:
> 
> > ./daniel.sh  39.78s user 71.72s system 368% cpu 30.260 total
> > quad:/home/akpm> time ./daniel.sh
> > ./daniel.sh  38.45s user 70.00s system 365% cpu 29.642 total
> 
> They should be 399%!!  With my fancy script, the processes themselves are
> getting serialized somehow.
> 
> Lets back up and try this again with this pair of scripts, much closer to
> the original:
> 

Still 360%.  I did have a version which achieved 398%, but it
succumbed to the monthly "why is there so much junk in my home
dir" disease.

But it doesn't matter, does it?  We're looking at deltas here.
