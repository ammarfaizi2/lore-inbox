Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273961AbRIXPrq>; Mon, 24 Sep 2001 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273963AbRIXPr0>; Mon, 24 Sep 2001 11:47:26 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10757 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273961AbRIXPrV>; Mon, 24 Sep 2001 11:47:21 -0400
Date: Mon, 24 Sep 2001 17:47:45 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924174745.A8230@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <20010924173210.A7630@emma1.emma.line.org> <E15lXup-0002uj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15lXup-0002uj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Alan Cox wrote:

> > > better. Decent write caching on IDE devices (like the 2meg buffer on the IBM) 
> > > can completely hide this issue.
> > 
> > Decent write caching on IDE devices can eat your whole file system.
> 
> YM bad write caching 8)

Well, drives do reorder their cache flushes, otherwise, they don't need
the cache.

> > Turn it off (I have no idea of internals, but I presume it'll still be a
> > write-through cache, so reading back will still be served from the
> > buffer). Do hdparm -W0 /dev/hd[a-h].
> 
> You can't turn it off and on many drives you can't flush the cache either
> the operation is not implemented.

Those drives should be blacklisted and rejected as soon as someone tries
to mount those pieces rw. Either the drive can make guarantees when a
write to permanent storage has COMPLETED (either by switching off the
cache or by a flush operation) or it belongs ripped out of the boxes and
stuffed down the throat of the idiot who built it.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
