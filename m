Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKTKGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTKTKGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:06:11 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:52437 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261552AbTKTKGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:06:08 -0500
Date: Thu, 20 Nov 2003 11:05:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sumit Pandya <sumit@elitecore.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Infinite do_IRQ
Message-ID: <20031120100529.GA2843@wohnheim.fh-wedel.de>
References: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in> <Pine.LNX.4.53.0311190332320.11537@montezuma.fsmlabs.com> <005c01c3aeab$a0aa93c0$3901a8c0@elite.co.in> <Pine.LNX.4.53.0311191032090.11537@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0311191032090.11537@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 November 2003 23:12:58 -0500, Zwane Mwaikambo wrote:
> On Wed, 19 Nov 2003, Sumit Pandya wrote:
> 
> > Hi Zwane,
> >     I'm sorry to bother you again. Following is output from
> > http://kernelnewbies.org/scripts/check-stack.sh
> 
> I think it'd really be easier to back out those patches one by one until 
> your messages stop happening. Otherwise i'm not quite sure which one is 
> really affecting you.

Agreed.  Still, tiny comments on the below.

> > 410 cdrom_number_of_slots
> > 410 cdrom_select_disc
> > 410 cdrom_slot_status
> > 444 cdrom_ioctl

Why do you use the mess from drivers/cdrom?  Unless you have one of
those old cdroms attached to your soundcard, better get rid of them.

> > 47c ide_unregister
> > 490 inflate_fixed
> > 524 inflate_dynamic
> > 5a8 huft_build

Old known problems, no bug reports about the ever.  Should be safe.

> > 73c sanitize_e820_map

This one is new to me.  Does it exist in plain 2.4.22 as well?


Anyway, backing out patches is the way to go.


Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
