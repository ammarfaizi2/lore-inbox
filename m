Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRLZQfK>; Wed, 26 Dec 2001 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282400AbRLZQfA>; Wed, 26 Dec 2001 11:35:00 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:61143 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281843AbRLZQer>; Wed, 26 Dec 2001 11:34:47 -0500
Message-ID: <3C2855EF.DC7F584F@home.com>
Date: Tue, 25 Dec 2001 05:33:19 -0500
From: Paul Boley <pboley@home.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
In-Reply-To: <E16JFVe-00024J-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >              total       used       free     shared    buffers
> > cached
> > Mem:        417472     412192       5280          0      20632
> > 315680
> 
> Thyose values dont show any problems. In fact your machine seems to think it
> had a ton of free memory to waste and has let it fill up with stuff that has
> been accessed - just on the chance that it may be reused.
> 
> It hasn't even felt enough memory pressure to start swapping. When you
> say it "becomes slow", what precisely becomes slow ?

When this happens in X, the mouse drags and skips, any processes running
(like tar/gzip. ls in an empty dir takes about 10 seconds) slow down,
and it happens usually for about 10sec-2min, often for no apparent
reason.  The big decompression was just a way I can easily duplicate
it.  Oddly enough though, according to top, it caches all that memory at
once, and my free goes down to 5 megs, with the system hanging/slow to
respond, for 10sec-2min.  Even typing in the console has delay before
the characters appear, and according to top, tar and gz are both using
under 1% cpu while this happens, and about 50% of the cpu is in use by
the system (not by any processes that I can see.  kupdated goes up to
about 0.3% during this)

> 
> Also what disks do you have and how are they set up ?
> -

/dev/hdb3 on / type ext2 (rw)
/dev/hdb4 on /home type ext2 (rw)
/dev/hda1 on /dos/c type vfat (rw)
/dev/hdb1 on /dos/d type vfat (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc type proc (rw)

and my swap is /dev/hdb2
