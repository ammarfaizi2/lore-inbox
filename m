Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262827AbSJVOuF>; Tue, 22 Oct 2002 10:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSJVOuF>; Tue, 22 Oct 2002 10:50:05 -0400
Received: from [195.223.140.120] ([195.223.140.120]:34106 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262827AbSJVOuE>; Tue, 22 Oct 2002 10:50:04 -0400
Date: Tue, 22 Oct 2002 16:55:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021022145528.GW19337@dualathlon.random>
References: <20021018145204.GG23930@dualathlon.random> <200210191121.20062.harisri@bigpond.com> <20021019012516.GB23930@dualathlon.random> <200210222048.05592.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210222048.05592.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:48:05PM +1000, Srihari Vijayaraghavan wrote:
> Hello Andrea,
> 
> On Saturday 19 October 2002 11:25, Andrea Arcangeli wrote:
> > that will help a lot, thanks!
> 
> Is there a quick HOWTO on how to apply the individual patches?
> 
> Do I apply 00*gz patches after applying 00* patches?

gz doesn't matter, the `ls` ordering is the only thing that matters. You
can gzip -d * and then apply [0123]* and see if it still breaks.

> When I tried the above procedure there were a lot of hunks and it did not 
> compile bzImage and agpgart.o etc..

something like this will apply cleanly, if every patch is self contained
as it should, it will compile correctly too:

	rm ../2.4.20pre11aa1/*.bz2
	gzip -d ../2.4.20pre11aa1/*.gz
	for i in ../2.4.20pre11aa1/[0123]*; patch -p1 < $i; done

Andrea
