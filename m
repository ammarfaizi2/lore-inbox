Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVAMULK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVAMULK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVAMUHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:07:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261460AbVAMUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:03:42 -0500
Date: Thu, 13 Jan 2005 20:59:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050113195941.GD2599@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200412262127.49897.Rafal.Wysocki@fuw.edu.pl> <20041226221046.GA1406@elf.ucw.cz> <200501131909.26021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501131909.26021.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Can you try this one? It would be nice to have reproducible way to
> > > > trigger this before trying to fix it, through.
> > > > 
> > > > [Patch is for 2.6.9something+my bigdiff, may need small tweaks]
> > > 
> > > It's for i386, isn't it?  Will it work as expected on AMD64?
> > 
> > Ouch, no, it probably will not work on amd64. Some assembly tweaks
> > would be needed.
> > 
> > Anyway here's that patch ported to 2.6.10+my_bigdiff (just in case
> > anyone has the same problem on i386).
> 
> Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> or an alternative?

Was that hugang's patch we were talking about?

Anyway ugly workaround for this is to just try harder to free memory during
suspend... Just do free_some_memory five times with msleep(200) in between.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

