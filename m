Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272873AbRISTEn>; Wed, 19 Sep 2001 15:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274136AbRISTEd>; Wed, 19 Sep 2001 15:04:33 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:6016
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S272873AbRISTEN>; Wed, 19 Sep 2001 15:04:13 -0400
Date: Wed, 19 Sep 2001 12:04:00 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200109191904.f8JJ40001476@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
In-Reply-To: <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
In-Reply-To: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan> <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have reiserfs mounts from /etc/fstab failing in 2.4.9-ac12, so
I straced the mount process.  With options "defaults" in /etc/fstab,
"mount /usr/local" does:

  mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0x80597a8) = -1 EINVAL (Invalid argument)

While "mount /dev/hde8 /usr/local" gives:

  mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0) = 0

But with the options "notail" in /etc/fstab, "mount /usr/local" does:

  mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0x806d3e0) = 0

Vital statistics:

  RedHat 7.1.93
  Linux version 2.4.9-ac12
  gcc version 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3)
  mount 2.11g

Cheers, Wayne
