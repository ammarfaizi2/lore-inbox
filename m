Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbTEBCgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 22:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTEBCgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 22:36:50 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:33801 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S262871AbTEBCgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 22:36:49 -0400
Date: Thu, 1 May 2003 19:46:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
Message-ID: <20030502024613.GJ30651@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200304292114.h3TLEHBu003733@81-2-122-30.bradfords.org.uk> <200304292059150060.002E747A@smtp.comcast.net> <200304301248.07777.kernel@kolivas.org> <20030430125913.GA21016@wohnheim.fh-wedel.de> <200305011807590220.00677F96@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305011807590220.00677F96@smtp.comcast.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 06:07:59PM -0400, rmoser wrote:
> Had a thought.  Why wait for a compression algorithm?  Jorn, if you are going
> to work on putting the code into the kernel and making the stuff to allow the
> swap code to use it, why not start coding it before the compression code is
> finished?  i.e. get the stuff down for the swap filtering (filtering i.e. passing
> through a compression or encryption routine) and swap-on-ram stuff, and later
> take the compression algo code and place the module interface on it and make
> a kernel module.
> 
> At this point, I'd say to allow specified order filters, to allow for swap cyphering
> and compression.  Security, you know; swap files are a security hazard.  Just
> power-off, boot a root disk, pull up the swap partition, rip out the blocks, and
> look for what looks to be the root password.

While we're having thoughts, this thread keeps me thinking
it would make sense to have a block device driver that would
be assigned unused memory.

I don't mean memory on video cards etc.  I'm thinking of the
10% of RAM unused when 1GB systems are booted with MEM=900M
because they run faster with HIGHMEM turned off.

The primary use for this "device" would be high priority swap.
Even with whatever overhead it takes to access it should be
orders of magnitude faster than any spinning media.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
