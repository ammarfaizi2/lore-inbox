Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTGFKeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 06:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTGFKeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 06:34:20 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:10505 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261801AbTGFKeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 06:34:16 -0400
Date: Sun, 6 Jul 2003 12:48:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Daniel Cavanagh <nofsk@vtown.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel problem (disklabel and swap)
Message-ID: <20030706104846.GA17191@win.tue.nl>
References: <3F07B957.4010206@vtown.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F07B957.4010206@vtown.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 03:53:27PM +1000, Daniel Cavanagh wrote:

> i recently had the problem with a bsd disklabel and swap and as someone 
> suggested, the swap slice did not have SWAPSPACE in it and that running 
> mkswap would fix this. sure enough it did, but then i wondered why 
> swapon allowed /dev/hda3 as a valid swap. so i had a look and SWAPSPACE2 
> was there, right at the start of the openbsd partition, inside the 
> disklabel. so i have come to the conclusion that openbsd tells the world 
> via the disklabel that a partition/slice is swap rather than at the 
> start of the swap slice.

I don't know about openbsd, but this sounds rather unlikely.
More likely is that you (or some installation script run by you)
marked that partition as swapspace.
mkswap for SWAPSPACE2 will preserve the first 1024 bytes, so it is possible
that you did this mkswap without destroying the disklabel.
Note that partition numbering is a black art, especially when you mix
several types of partition table. The name (number) of your partition
may depend on kernel version and on for what partition table types you
have support in your kernel.


