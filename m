Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTFYJHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTFYJHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:07:53 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17291 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264256AbTFYJHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:07:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16121.27054.257166.231690@gargle.gargle.HOWL>
Date: Wed, 25 Jun 2003 11:21:50 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@digeo.com>
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
In-Reply-To: <20030624153154.7243549d.akpm@digeo.com>
References: <20030624124800.72bfb98d.akpm@digeo.com>
	<200306242033.QAA27440@clem.clem-digital.net>
	<16120.50188.29.739261@gargle.gargle.HOWL>
	<20030624153154.7243549d.akpm@digeo.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > >
 > > Apply the patch below (which I posted to LKML yesterday btw).
 > >  2.5.73 incorrectly removed the workaround needed to prevent
 > >  gcc-2.95.x from miscompiling spinlocks on UP (they become
 > >  empty structs, and gcc-2.95.x has problems with those).
 > 
 > Are you sure?  I saw no problems with 2.95.3.  Maybe it's
 > a 2.95.4 problem?

I know the problem exists in 2.95.3 since that's the one I
used for my initial 2.5.73 testing. Having seen the spinlock.h
patch, I strongly suspected things would break.

If I remember correctly, the empty struct miscompilation exists
in all old egcs and gcc-2.95 versions, but was fixed during 3.0
development, so 2.96 is apparently also Ok.

/Mikael
