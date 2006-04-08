Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWDHRak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWDHRak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWDHRak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:30:40 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:23199 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S965032AbWDHRaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:30:39 -0400
Date: Sat, 8 Apr 2006 20:30:38 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux list <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
Message-ID: <20060408173038.GR8304@mea-ext.zmailer.org>
References: <44379AB8.6050808@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44379AB8.6050808@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 12:12:56PM +0100, James Courtier-Dutton wrote:
> Hi,
> 
> I have had an idea for a black box flight recorder type feature for 
> Linux. Before I try to implement it, I just wish to ask here if anyone 
> has already tried it, and whether the idea works or not.
> 
> Description for feature:
> Stamp the dmesg output on RAM somewhere, so that after a reset (reset 
> button pressed, not power off), the RAM can be read and details of 
> oopses etc. can be read.

The idea of  dmesg  buffer comes to Linux from SunOS 4.x series
on hardware, where system boot code explicitely left aside memory
space which was not _cleared_ during boot (it was parity-regenerated,
though).  The command to display that ring-buffer content was (no
surprise there?) "dmesg".

I do wish so many things from PC hardware, but it has stayed so b***y
inferior to real computers forever.  Lattest AMD CPUs have nice
features making them almost as good as IBM S/370 from early 1970es,
but still BIOSes are rather primitive things keeping things back.
( IOMMUs are things that have been invented since, and are definitely
a good thing.  Otherwise it has been faster and more capacitious
processing and memory at cheaper system cost... )

Like others have noted, display card memory spaces have been used
for this kind of "survives over reset" uses  -- I do also know some
embedded boot codes that created similar ring buffers for similar
reasons.  They don't generally survive over power-cycling, of course.


> The main advantage of something like this would be for newer 
> motherboards that are around now that don't have a serial port.
> 
> If no one has tried this, I will spend some time testing.
> 
> James


/Matti Aarnio
