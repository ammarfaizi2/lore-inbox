Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWHIMIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWHIMIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWHIMIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:08:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49631 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161016AbWHIMI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:08:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 3/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 14:07:19 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608091209.03695.rjw@sisk.pl> <20060809115145.GT3308@elf.ucw.cz>
In-Reply-To: <20060809115145.GT3308@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091407.19845.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:51, Pavel Machek wrote:
> > Make swsusp handle highmem pages similarly to the pages of the "normal"
> > memory.
> 
> Is it feasible to create kernel/power/highmem.c?

Not really ...

> >  include/linux/suspend.h |    6 
> >  kernel/power/power.h    |    2 
> >  kernel/power/snapshot.c |  822 ++++++++++++++++++++++++++++++++++++------------
> >  kernel/power/swap.c     |    2 
> >  kernel/power/swsusp.c   |   53 +--
> >  kernel/power/user.c     |    2 
> >  mm/vmscan.c             |    3 
> >  7 files changed, 658 insertions(+), 232 deletions(-)
> 
> +400 lines for highmem... I hope highmem dies, dies, dies. Anyway, I'd
> hate to debug this at the same time as the bitmap code. Can we get the
> bitmaps in, wait for a while, and only then change highmem handling?

Sure, why not.  I'll prepare a series without the highmem patch for now.

Rafael
