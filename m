Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbULQQ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbULQQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbULQQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:59:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:25999 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262067AbULQQ7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:59:10 -0500
Date: Fri, 17 Dec 2004 17:59:09 +0100
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [RFC] fork historic module
Message-ID: <20041217165909.GF14229@wotan.suse.de>
References: <41C30ED6.5010201@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C30ED6.5010201@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 05:52:38PM +0100, Manfred Spraul wrote:
> Andi wrote:
> 
> >>+/* IOCTL numbers */
> >>+/* If you add a new IOCTL number don't forget to update FH_MAXNR */
> >>+#define FH_MAGIC	0x35
> >>+#define FH_REGISTER	_IO(FH_MAGIC,0)
> >>+#define FH_UNREGISTER	_IO(FH_MAGIC,1)
> >
> >Is this really unique? 32bit emulation currently needs unique ioctl 
> >numbers.
> > 
> >
> Are there plans to fix that? Perhaps move the emulation callback into 
> struct file?

Yes. See the thread on l-k i started two days ago.

Actually the main reason is that the current conversion setup has a 
unfixable module unload race.

-Andi
