Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbTCLXaZ>; Wed, 12 Mar 2003 18:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbTCLXaZ>; Wed, 12 Mar 2003 18:30:25 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:57318 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262134AbTCLXaY>; Wed, 12 Mar 2003 18:30:24 -0500
Date: Thu, 13 Mar 2003 10:40:15 +1100
From: CaT <cat@zip.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Tomasz Torcz, BG" <zdzichu@irc.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
Message-ID: <20030312234015.GC456@zip.com.au>
References: <1047245678.8985.188.camel@ixodes.goop.org> <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 04:06:24PM -0600, Patrick Mochel wrote:
> 
> On 9 Mar 2003, Jeremy Fitzhardinge wrote:
> 
> > On Sun, 2003-03-09 at 12:31, Patrick Mochel wrote:
> > > I was able to reproduce the Oops with a USB device on multiple insert/
> > > removals. The patch below fixes the Oops for me. Could people who have 
> > > seen the Oops try it out and let me know if it helps them? 
> > > 
> > > [ Unfortunately, I can't test some of the exact failure scenarios, as I 
> > > don't use ppp, and my one system with PCMCIA has decided that it doesn't 
> > > want to let me (physically) insert cards anymore.. ]
> > 
> > I'm still getting a crash with this patch+mm4.  I got this on ethernet
> > card removal:
> 
> Bah, we're accidentally dropping the refcount on the directory one too 
> many times, which is a different, though slightly related, problem to the 
> one the previous patch fixed. 
> 
> Please try this patch (after removing the previous one). Thanks,

I wanted to give this a go but it does not apply vs my 2.5.64. None of
the patches I've applied to it touch that file so I'm guessing I'm
missing something else.

What am I missing and/or is it possible to get this vs 2.5.64? I tried
hand adding it in but didn't due to the files being rather different.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

