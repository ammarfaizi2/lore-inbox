Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbTCLXcK>; Wed, 12 Mar 2003 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbTCLXcK>; Wed, 12 Mar 2003 18:32:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262152AbTCLXcI>;
	Wed, 12 Mar 2003 18:32:08 -0500
Date: Wed, 12 Mar 2003 16:45:07 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: CaT <cat@zip.com.au>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Tomasz Torcz, BG" <zdzichu@irc.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
In-Reply-To: <20030312234015.GC456@zip.com.au>
Message-ID: <Pine.LNX.4.33.0303121644170.1034-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Mar 2003, CaT wrote:

> On Sun, Mar 09, 2003 at 04:06:24PM -0600, Patrick Mochel wrote:
> > 
> > On 9 Mar 2003, Jeremy Fitzhardinge wrote:
> > 
> > > On Sun, 2003-03-09 at 12:31, Patrick Mochel wrote:
> > > > I was able to reproduce the Oops with a USB device on multiple insert/
> > > > removals. The patch below fixes the Oops for me. Could people who have 
> > > > seen the Oops try it out and let me know if it helps them? 
> > > > 
> > > > [ Unfortunately, I can't test some of the exact failure scenarios, as I 
> > > > don't use ppp, and my one system with PCMCIA has decided that it doesn't 
> > > > want to let me (physically) insert cards anymore.. ]
> > > 
> > > I'm still getting a crash with this patch+mm4.  I got this on ethernet
> > > card removal:
> > 
> > Bah, we're accidentally dropping the refcount on the directory one too 
> > many times, which is a different, though slightly related, problem to the 
> > one the previous patch fixed. 
> > 
> > Please try this patch (after removing the previous one). Thanks,
> 
> I wanted to give this a go but it does not apply vs my 2.5.64. None of
> the patches I've applied to it touch that file so I'm guessing I'm
> missing something else.
> 
> What am I missing and/or is it possible to get this vs 2.5.64? I tried
> hand adding it in but didn't due to the files being rather different.

Sorry, the patches were relative to the latest BK tree, as well as the 
latest BK snapshot from kernel.org. 

The fix has been integrated into Linus's tree, so by getting the latest 
snapshot, things should be fixed for you.

	-pat

