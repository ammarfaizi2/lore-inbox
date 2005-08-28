Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVH1JVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVH1JVc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVH1JVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 05:21:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:43720 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750757AbVH1JVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 05:21:31 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Date: Sun, 28 Aug 2005 11:21:24 +0200
User-Agent: KMail/1.8
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1125069494.18155.27.camel@betsy> <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz> <20050828080959.GB2039@elf.ucw.cz>
In-Reply-To: <20050828080959.GB2039@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508281121.25101.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 28. August 2005 10:09 schrieb Pavel Machek:
> 
> > >>Of late I have been working on a driver for the IBM Hard Drive Active
> > >>Protection System (HDAPS), which provides a two-axis accelerometer and
> > >>some other misc. data.  The hardware is found on recent IBM ThinkPad
> > >>laptops.
> > >>
> > >>The following patch adds the driver to 2.6.13-rc6-mm2.  It is
> > >>self-contained and fairly simple.
> > >
> > >Do we really need input interface *and* sysfs interface? Input should be 
> > >enough.
> > 
> > I think he doesn't need to export it at all and he should write code to 
> > park and disable hard disk instead.
> > (in userspace it's unsolvable --- i.e. you can't enable hard disk when 
> > detected stable condition if the daemon is swapped out on that hard disk)
> 
> man mlockall() :-).

If you need that, it belongs into the kernel.

	Regards
		Oliver

