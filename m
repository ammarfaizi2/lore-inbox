Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSBKLzV>; Mon, 11 Feb 2002 06:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSBKLzM>; Mon, 11 Feb 2002 06:55:12 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:18449 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S288158AbSBKLy7>; Mon, 11 Feb 2002 06:54:59 -0500
Date: Mon, 11 Feb 2002 12:55:28 +0100
To: Heinz Diehl <hd@cavy.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk-I/O and kupdated@99.9% system (2.4.18-pre9)
Message-ID: <20020211115527.GA336@bik-gmbh.de>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de> <20020210115509.GA493@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020210115509.GA493@chiara.cavy.de>
User-Agent: Mutt/1.3.24i
From: Florian Hars <hars@bik-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz Diehl wrote:
> Downgrade to 2.4.18-pre8 and use Michael Cohen's patch from
> "ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/",

That doesn't help. I tried 2.4.16 with Debian modifications, said 
kernel patched to 2.4.18-pre9, stock 2.4.17, stock 2.4.18-pre9 and
2.4.18-pre8-mjc with preempt and lockbreak, and all behave alike.

On a plain ext2-filesystem on a primary partition I get (with -mjc):

During the sync the system is extremly sluggish, and once during my
tests it froze completely (it did still return pings with a normal
speed) so that I had to press reset.

The same operations on a slower computer running 2.2.20 are consideraby
faster:

$ time tar -xzf linux-2.4.17.tar.gz; time sync

real    0m7.716s
user    0m5.430s
sys     0m2.110s

real    0m6.332s
user    0m0.000s
sys     0m0.120s
 
> Latency in stock 2.4.17/18-pre kernels is well known :\

this looks like more than a latency issue :-(.

Yours, Florian Hars.
