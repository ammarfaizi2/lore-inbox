Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSGNTMc>; Sun, 14 Jul 2002 15:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSGNTMc>; Sun, 14 Jul 2002 15:12:32 -0400
Received: from zork.zork.net ([66.92.188.166]:18367 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S317006AbSGNTMb>;
	Sun, 14 Jul 2002 15:12:31 -0400
Date: Sun, 14 Jul 2002 20:15:24 +0100
From: Sean Neakums <sneakums@zork.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714191524.GB9202@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de> <20020714184006.GA13867@louise.pinerecords.com> <20020714190657.GB13867@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714190657.GB13867@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text advisory: HACKING, DENIAL OF THE ANTECEDENT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Tomas Szepe  quotation:
> > > A Pentium 1200 running Linux-2.5.25 (ext3) results in:
> > > 
> > > # star -xp -time < rock.tar.bz2
> > > star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
> > > star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
> > > star: Total time 3190.483sec (32 kBytes/sec)
> > > 53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w
> > > 
> > > You see, during the 53:20, the machine is only 7% idle!
> > 
> > A Pentium 1200, eh?
> > More like Pentium 120 or star just doesn't cut it.
> 
> Now I'm actually pretty sure you meant 386DX/33!
> 
> I don't know whom you're trying to fool, but even my P2/233
> can get the work done in under 5 minutes:
> 
> kala@hubert:/tmp$ time tar xjf rock.tar.bz2
> 
> real    4m50.598s
> user    0m36.700s
> sys     1m51.860s
> 
> Linux 2.4.19-pre10-ac2, reiserfs 3.6.

Aha, but reiserfs's directories are indexed, are they not?  Whereas
ext3's directories are flat and require a linear search for lookups
and modifications.  This may be what Joerg's example highlights.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
