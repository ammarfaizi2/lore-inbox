Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSLZMsh>; Thu, 26 Dec 2002 07:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLZMsh>; Thu, 26 Dec 2002 07:48:37 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:47252 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S261371AbSLZMsg>;
	Thu, 26 Dec 2002 07:48:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.53-mm1 with contest
Date: Thu, 26 Dec 2002 23:56:44 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212261934.36086.conman@kolivas.net> <3E0ACEBC.D06B1BAB@digeo.com>
In-Reply-To: <3E0ACEBC.D06B1BAB@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212262356.49802.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 26 Dec 2002 08:41 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > ...
> > process_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.52 [3]              84.4    79      17      19      1.26
> > 2.5.52-mm1 [7]          91.0    79      18      19      1.36
> > 2.5.52-mm2 [7]          90.3    79      18      19      1.35
> > 2.5.53 [7]              86.9    77      18      21      1.30
> > 2.5.53-mm1 [7]          117.1   58      47      40      1.75
> > Big change in the balance here in process_load. Probably a better balance
> > really given that process_load runs 4*num_cpus processes, and the kernel
> > compile is make -j (4*num_cpus)
>
> Presumably the run-child-first change.  process_load is complex.  I
> haven't looked into its dynamics and I'm not sure what, if anything,
> we can conclude from this test.
>
> > ...
> > The SMP results seem to fluctuate too much between runs even with the
> > average of 7 runs. I'm wondering whether I should even bother with them
> > any more as they dont add any useful information as far as I can see.
> > Comments on this would be appreciated. Andrew?
>
> Well for the sorts of things which you are interested in, SMP is not the
> target market, shall we say?

Agreed. Can't believe the initial UP v SMP results got slashdotted on 
kerneltrap. I doubt anyone made any sense of them let alone made any useful 
comment relating to them. I'll drop them in the interest of time and signal 
to noise ratio. 

> Is the variability seen in other kernels (especially 2.4)?  If not then
> we'd need to find out what causes it.

A run through previous tests and a fresh run with vanilla 2.4.20 shows just as 
much variation. It seems to be more a function of SMP rather than 2.5.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+CvyMF6dfvkL3i1gRAteoAKCqRu111T5ikGuYcUl4C7FgCjPvBgCfcUU7
gTiMlZxKT5KxjYDg+GeejkE=
=DbYb
-----END PGP SIGNATURE-----
