Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSINOhB>; Sat, 14 Sep 2002 10:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSINOhA>; Sat, 14 Sep 2002 10:37:00 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:43963 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317257AbSINOhA>;
	Sat, 14 Sep 2002 10:37:00 -0400
Subject: Re: 2.4.20pre5aa2
From: Stephen Lord <lord@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Samuel Flory <sflory@rackable.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
In-Reply-To: <20020913211844.GP11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
	<1031768655.24629.23.camel@UberGeek.coremetrics.com>
	<20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com>
	<20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu>
	<20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com>
	<20020913125345.GO11605@dualathlon.random> <3D825422.8000007@rackable.com> 
	<20020913211844.GP11605@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Sep 2002 09:39:24 -0500
Message-Id: <1032014367.1050.2.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 16:18, Andrea Arcangeli wrote:

> So, returning to xfs, it is possible dbench really generates lots of
> simultaneous vmaps because of its concurrency, so I would suggest to add
> an atomic counter increased at every vmap/vmalloc and decreased at every
> vfree and to check it after every increase storing the max value in a
> sysctl, to see what's the max concurrency you reach with the vmaps. (you
> can also export the counter via the sysctl, to verify for no memleaks
> after unmounting xfs)
> 
> Andrea

There are no vmaps during normal operation on xfs unless you are
setting extended attributes of more than 4K in size, or you
used some more obscure mkfs options. Only filesystem recovery will
use it otherwise. 

Steve


