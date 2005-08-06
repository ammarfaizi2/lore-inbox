Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263445AbVHFTaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbVHFTaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263446AbVHFTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:30:14 -0400
Received: from xenotime.net ([66.160.160.81]:17047 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S263445AbVHFT2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:28:53 -0400
Date: Sat, 6 Aug 2005 12:28:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeing a dynamic struct cdev
Message-Id: <20050806122849.452290e2.rdunlap@xenotime.net>
In-Reply-To: <1123356380.13845.2.camel@Tachyon.home>
References: <1123334776.29913.3.camel@Tachyon.home>
	<20050806122108.4a458c68.rdunlap@xenotime.net>
	<1123356380.13845.2.camel@Tachyon.home>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Aug 2005 15:26:18 -0400 James C. Georgas wrote:

> On Sat, 2005-08-06 at 12:21 -0700, Randy.Dunlap wrote:
> > On Sat, 06 Aug 2005 09:26:15 -0400 James C. Georgas wrote:
> > 
> > > If I allocate a struct cdev using cdev_alloc(), what function do I call
> > > to free it when I'm done with it?
> > 
> > Should be cdev_put(), which calls kobject_put(), which implements
> > ref counting (using krefs), so that when the last reference is
> > going away, the object will be removed.
> > 
> > ---
> > ~Randy
> 
> cdev_put() is not an exported symbol in the fs/char_dev.c file. Should
> it be?

Sorry about that, typo on my part.  It's cdev_del().

---
~Randy
