Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274617AbRIYKm3>; Tue, 25 Sep 2001 06:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274611AbRIYKmT>; Tue, 25 Sep 2001 06:42:19 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24588 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274612AbRIYKmI>; Tue, 25 Sep 2001 06:42:08 -0400
Date: Tue, 25 Sep 2001 12:42:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925124231.A1390@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924200537.SRVB23487.femail38.sdc1.sfba.home.com@there> <20010925021113.B22073@emma1.emma.line.org> <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Nicholas Knight wrote:

> It's a very remote possability of failure, like most instances where 
> write-cache would cause problems. Catastrophic failure of the IDE cable 
> in mid-write will cause problems. If write cache is enabled, the write 
> stands a higher chance of having made it to the drive before the cable 
> died, with it off, it stands a higher chance of NOT having made it 
> entirely to the drive.

Cables don't suddenly die without the help of e. g. your CPU fan.

> For most drives, I don't know for sure if they'd finish the write 
> that's now sitting in their cache, but I expect higher quality drives 
> (such as our IBM drives) definitely would. Infact I may even be willing 
> to test this later (my swap partition looks like it wants to help :)

Drives would not write incomplete blocks.

> > It may be an implementation problem in our IBM drives which ship with
> > their write caches enabled, someone please do this test on current
> > Fujitsu, Maxtor or Seagate IDE drives or with different controllers.
> 
> Either Maxtor or Western Digital share very close designs to IBM 
> drives, I belive they had some sort of development partnership. I'm not 
> sure if it was Maxtor or WD. 

The Western Digital 420400D (20 GB, 5400/min) and its 7200/min brother
with 18 GBs were IBM disk drives, supposedly, but the WD ...AA/BB drives
and whatever else there was looked some different from IBM drives.

> > Why are disk drives slower with their caches disabled on LINEAR
> > writes?
> 
> Maybe the cache isn't doing what we think it is?

Maybe. A monitor software or debug mode would be good to see when writes
are scheduled and which blocks are written (I need to ask a friend of
mine who hacked ll_rw_blk.c on a different purpose for his diploma
thesis, maybe his code is valuable to figure things out.)

> Does anyone have contacts at IBM and/or Western Digital? Something's 
> up... The 256MB write with write-cache off was going at 5.8MB/sec, and 
> with it on it was going at 14.22MB/sec (averages). One interesting 
> thing, the timings are showing a pretty consistant but tiny increase in 
> sys time with write caching on.

I also saw that here, but again, it's basically the same hardware.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
