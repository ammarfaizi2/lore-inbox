Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274032AbRIXQxG>; Mon, 24 Sep 2001 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRIXQwq>; Mon, 24 Sep 2001 12:52:46 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:42759 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274029AbRIXQwl>; Mon, 24 Sep 2001 12:52:41 -0400
Date: Mon, 24 Sep 2001 18:53:03 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924185303.B10117@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Nicholas Knight wrote:

> > Turn it off (I have no idea of internals, but I presume it'll still
> > be a write-through cache, so reading back will still be served from
> > the buffer). Do hdparm -W0 /dev/hd[a-h].
> 
> I'm sorry, but that's not acceptable.
> Please note the dd timings at the bottom of this message.

Well, of course, turning off the cache will cause performance penalties,
but it at least gives you a chance to get away with a recoverable file
system should the power fail or the box crash.

> Yes, a typical desktop user isn't going to notice much, even a normal 
> webserver or fileserver not dealing with constant updates may not, but 
> certain workloads will. These workloads are real enough that telling 
> people to disable write caching out of hand is a bad idea.

I switched a box to ext3 with write caches off in expectance of multiple
power outages during works, and NOTHING happened. I expect that box is
now writing 4 times slower than before, I have no real figures, and it's
still "smooth enough" in spite of 2.4.9.

> Keep in mind also, that you may be putting your data and filesystems in 
> more risk by not using a write cache as with using it.

Utterly non-sense.

Linear writing as dd mostly does is BTW something which should never be
affected by write caches.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
