Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTBPGuI>; Sun, 16 Feb 2003 01:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTBPGuI>; Sun, 16 Feb 2003 01:50:08 -0500
Received: from ns.suse.de ([213.95.15.193]:57606 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265939AbTBPGuH>;
	Sun, 16 Feb 2003 01:50:07 -0500
Date: Sun, 16 Feb 2003 08:00:03 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, anton@samba.org, linux-kernel@vger.kernel.org,
       tim@physik3.uni-rostock.de
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-ID: <20030216070003.GA17348@wotan.suse.de>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de.suse.lists.linux.kernel> <20030216020808.GF9833@krispykreme.suse.lists.linux.kernel> <p73znowybo5.fsf@amdsimf.suse.de> <20030215225618.538f4c70.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215225618.538f4c70.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the point of this patch is to catch jiffy wrap bugs in generic code as
> well as in platform-specific code.
> 
> Doing it for 64-bit platforms as well will give us just that bit more testing
> coverage, and has no cost.  (Well, 8 more bytes of kernel image...)

The 64bit platforms already have enough problems due to 64bit unclean
code. No need to add a new unnecessary ones.

Jiffie wrap is purely a 32bit problem, just like highmem. Please keep 
problems where they belong.

-Andi
