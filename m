Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTDYTUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTDYTUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:20:41 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40840 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263669AbTDYTUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:20:40 -0400
Date: Fri, 25 Apr 2003 20:32:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Andreas Dilger <adilger@clusterfs.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@digeo.com>, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030425193235.GB1853@mail.jlokier.co.uk>
References: <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz> <20030424154608.V26054@schatzie.adilger.int> <1051232975.1919.26.camel@laptop-linux> <20030425125918.GA25733@atrey.karlin.mff.cuni.cz> <20030425102014.A26054@schatzie.adilger.int> <1051295327.1722.7.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051295327.1722.7.camel@laptop-linux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Even if we record in the swapfile - while
> suspending - information that gives us the locations of blocks, we still
> need to find the start of the swapfile, or store it somewhere.

If LILO can do it...

The starting block number does not change unless you delete and
recreate the swapfile.  It has the same requirement for location
stability as the kernel image and initrd for LILO.

So, a patched LILO could record the start of the swapfile when it is
run.  Note that you do this as usual when installing a kernel or when
installing a new swapfile.  There's no need to do it when suspending.

If you're booting with Grub or some other fs-aware bootloader, then
the bootloader can presumably find the start of the swapfile just like
it finds the kernel and initrd.

-- Jamie
