Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbTGWHfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTGWHfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:35:45 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:52106 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267274AbTGWHfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:35:44 -0400
Date: Wed, 23 Jul 2003 03:50:32 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Linux 2.6.0-test1 on PPC
In-reply-to: <20030722182254.GA15636@gandalph.mad.hu>
To: Gergely Nagy <algernon@bonehunter.rulez.org>, linux-kernel@vger.kernel.org
Message-id: <200307230350.42200.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <20030722182254.GA15636@gandalph.mad.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 22 July 2003 14:22, Gergely Nagy wrote:
> Hi!
>
> I've tried to compile linux 2.6.0-test1 on ppc, and so far, ran into two
> easily fixable problems: first, in arch/ppc/kernel/time.c
> do_settimeofday has new_sec and new_nsec defined twice. When I removed
> one of the definitions (I chose to remove the ones that were not
> explictly initialised).

Already fixed.

> Then drivers/ide/ppc/pmac.c failed to compile,
> due to a missing ide_dma_intr and others. I looked into
> includes/linux/ide.h, and noticed that these are only defined if
> CONFIG_BLK_DEV_IDE_DMA_PCI is defined, and my config didn't have that,
> only CONFIG_BLK_DEV_IDE_DMA_PPC. So - as a quick and rude solution - I
> changed the ifdef in ide.h, which is probably the wrong solution.

I have no idea, and I'm going to get some sleep first. :-)

> The kernel is still compiling, but I don't expect other failures.. If
> anyone wants a patch for the above two trivial thingies, or has a
> pointer to a ppc tree that is likely to be more up-to-date, please shout

We'll see...

Jeff.

- -- 
Keyboard not found!
Press F1 to enter Setup
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Hj5LwFP0+seVj/4RAlPoAJ4otaDBCzSROWaRiVhrymurRvXvngCgz+9N
kWXKRbCM0AxM6rJoHNj41Ps=
=j4dJ
-----END PGP SIGNATURE-----

