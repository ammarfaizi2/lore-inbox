Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSD2VX4>; Mon, 29 Apr 2002 17:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314870AbSD2VXz>; Mon, 29 Apr 2002 17:23:55 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:17932 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313022AbSD2VXx>; Mon, 29 Apr 2002 17:23:53 -0400
Date: Mon, 29 Apr 2002 23:12:35 +0200
From: tomas szepe <kala@pinerecords.com>
To: frank@gevaerts.be
Subject: Re: Sparc32 oops in chmod (2.2.20 SMP)
Message-ID: <20020429211235.GE26814@louise.pinerecords.com>
In-Reply-To: <20020429201445.A431@gevaerts.be> <20020429190557.GA26292@louise.pinerecords.com> <20020429211705.A435@gevaerts.be> <20020429192410.GB26369@louise.pinerecords.com> <20020429212709.A547@gevaerts.be> <20020429192842.GC26369@louise.pinerecords.com> <20020429223234.A306@gevaerts.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 15:00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > OK. If I can get my cpio file down to reasonable size, and still crash the
> > > system, I'll put it online and send you an URL.
> > Oook.
> http://www.xs4all.be/~gevaerts/ca.cpio.gz
> (+- 1.5 MB, 26 MB uncompressed)
> (contains one postscript file of some calvin & hobbes strips)
> cat ca.cpio.gz|gunzip|cpio -ivmd
> hangs my system reliably.

kala@louise:/ap/tmp/t$ wget -q http://www.xs4all.be/~gevaerts/ca.cpio.gz
kala@louise:/ap/tmp/t$ ls -l
total 1476
-rw-r--r--    1 kala     users     1503405 Apr 29 22:27 ca.cpio.gz
kala@louise:/ap/tmp/t$ time cat ca.cpio.gz| gunzip| cpio -ivmd
cpio: warning: archive header has reverse byte-order
ch.ps
50867 blocks

real    0m18.468s
user    0m8.330s
sys     0m17.060s
kala@louise:/ap/tmp/t$ ls -la
total 26952
drwxr-xr-x    2 kala     users        4096 Apr 29 23:10 ./
drwxrwxrwt    3 root     root         4096 Apr 29 23:08 ../
-rw-r--r--    1 kala     users     1503405 Apr 29 22:27 ca.cpio.gz
-rw-rw-r--    1 kala     users    26043638 Jan 29 22:05 ch.ps

hmmmmm.
what now?

T.

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
