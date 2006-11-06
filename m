Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753821AbWKFVTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbWKFVTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbWKFVTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:19:00 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:14306 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1753817AbWKFVS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:18:59 -0500
Date: Mon, 6 Nov 2006 22:19:03 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061106211903.GC691@wohnheim.fh-wedel.de>
References: <20061103101901.GA11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz> <20061103122126.GC11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz> <20061103134802.GD11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz> <20061103145329.GE11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031953411.30722@artax.karlin.mff.cuni.cz> <20061104104601.GA16991@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611041946580.24713@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611041946580.24713@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 November 2006 19:50:01 +0100, Mikulas Patocka wrote:
> 
> LFS fragments data by design ... it can't write to already allocated 
> space, so if you write to the middle of LFS directory, it will allocate 
> new block, new indirect pointers to that directory, new block in inode 
> table etc.

Based on the assumption that reads don't matter, which proved wrong.
Yes.

Your allocation strategy sounds fairly good.  I'm not a benchmark
person, so I can only tell horrible from decent, not decent from good.
Your benchmarks speak for themselves, so I guess it is more than just
decent.

However, going back to crash counts and transaction counts, I still
don't understand why you don't just have two checkpoints (or any other
objects, if you don't like the name) with a 64bit version number each
that you alternately write for sync().  You seem to have that concept
for managing free space, just not to manage valid data.  What is the
difference?

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
