Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275861AbRJBIUE>; Tue, 2 Oct 2001 04:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJBITy>; Tue, 2 Oct 2001 04:19:54 -0400
Received: from mail.zmailer.org ([194.252.70.162]:11276 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S275861AbRJBITn>;
	Tue, 2 Oct 2001 04:19:43 -0400
Date: Tue, 2 Oct 2001 11:20:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'dd' local works, but not over net, help as to why?
Message-ID: <20011002112005.K1144@mea-ext.zmailer.org>
In-Reply-To: <NDBBJDKDKDGCIJFBPLFHMEJPCGAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <NDBBJDKDKDGCIJFBPLFHMEJPCGAA.law@sgi.com>; from law@sgi.com on Tue, Oct 02, 2001 at 12:52:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 12:52:48AM -0700, LA Walsh wrote:
> I'm sure there's an obvious answer to this, but it is eluding me.
    Probably...

> If I am on my local laptop, I can 'dd' an 8G partition to a
> removable HD of the same or slightly larger size (slightly large
> because of geometry differences).
> 
> If I am on my desktop, "I can 'dd' the same size partition to
> a slightly larger one -- again, no problem.
> 
> But if I use:
> 
> dd if=/dev/hda2 bs=1M|rsh other-system of=/dev/sda2 bs=1M, I
> get failures of running out of room on target.  I've tried
> a variety of block size ranging from 1K->64G, but no luck.

   You are missing one 'dd' from the other system side, but
   are you also sure that the remote system can support large
   files, and that the dd in there does support large files ?

   Verify that you can 'dd if=/dev/zero of=/dev/sda2 bs=1M'
   at that remote system -- then we know that dd in there
   (and the system) can do it, and the bug-sphere shrinks.

> Is there something in the networking code that's preventing me
> from transferring more than a 2 or 4 G limit?

   There should not be anything such.
   (But of course things like RSH could have some nasty surprises
    in them...)

> I just wanted an exact image off onto another system.  Would
> seem to have been straight forwared. but I guess not?  
> 
> Thanks in advance for any work-arounds and explanations...
> 
> -linda

/Matti Aarnio
