Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRKHSMf>; Thu, 8 Nov 2001 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKHSMQ>; Thu, 8 Nov 2001 13:12:16 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:3069 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S277230AbRKHSMA>;
	Thu, 8 Nov 2001 13:12:00 -0500
Date: Thu, 8 Nov 2001 11:10:24 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, tim@physik3.uni-rostock.de,
        jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
Message-ID: <20011108111024.X5922@lynx.no>
Mail-Followup-To: kuznet@ms2.inr.ac.ru,
	"David S. Miller" <davem@redhat.com>, tim@physik3.uni-rostock.de,
	jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	netdev@oss.sgi.com, ak@muc.de
In-Reply-To: <20011107.160950.57890584.davem@redhat.com> <200111081754.UAA24454@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111081754.UAA24454@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Nov 08, 2001 at 08:54:29PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, 2001  20:54 +0300, kuznet@ms2.inr.ac.ru wrote:
> I want to _ask_ one thing people working on these changes.
> _Please_, defer this edit to 2.5. The changes are very good,
> but time for them is very bad.
> 
> When I wrote this code the macros did not exist.

Well, Alan said the same thing, and I went and checked - the macros existed
since 2.1.106, probably the last time there was a "jiffies wrap" effort.  It
is more likely that nobody knows about them, because nobody uses them, 
because nobody knows about them, etc.

> However, this code is right, take my word. Hence, it is pure maintanance
> problem and as soon as main reader of this code is me, I would be glad to
> see the changes, but only having no deadlines.

If people don't want to see them, that is fine with me - they will stop.

Tim and I were only trying to fix instability that he noticed when
initializing jiffies to some large pre-wrap value.  If people are OK
with 2.4 Linux boxes hanging after 497 days, that is fine with me.

The only box I have that could stay up that long is my router (486/33),
and it does not have a UPS so it is not likely to actually make it
(record is 6 months or so).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

