Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWD2SGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWD2SGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWD2SGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 14:06:55 -0400
Received: from silver.veritas.com ([143.127.12.111]:24163 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750770AbWD2SGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 14:06:54 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,166,1144047600"; 
   d="scan'208"; a="37731155:sNHT24706724"
Date: Sat, 29 Apr 2006 19:06:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Jeff Garzik <jeff@garzik.org>
cc: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <Pine.LNX.4.64.0604231343010.2515@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0604291901500.4575@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
 <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
 <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
 <4449504D.1040901@garzik.org> <Pine.LNX.4.64.0604231343010.2515@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Apr 2006 18:06:54.0430 (UTC) FILETIME=[B27C0FE0:01C66BB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2006, Hugh Dickins wrote:
> On Fri, 21 Apr 2006, Jeff Garzik wrote:
> 
> > So you really want an ata_make_sure_bus_is_awake_and_working() called at that
> > location.  ata_busy_sleep()'s purpose is to bring a PATA-like bus to the
> > bus-idle state.  So, when working on suspend/resume, the software needs to
> > have points at which the bus state is controlled/queried/asserted.
> 
> As you can see from my questions, I haven't a clue around here.  So for
> now I'll just have to keep that ata_busy_sleep with the patches I apply
> to my kernel, until someone with a clue makes it redundant.  And it is
> now there in the LKML archives for those who find it useful.

I'm glad to report that my ata_busy_sleep is already unnecessary in
2.6.17-rc2-mm1 (and probably in at least -rc1-mm3 before it): unlike in
2.6.17-rc3, T43p resumes reliably from RAM with unpatched libata-core.c.
Something has gone seriously right!  Thanks...

Hugh
