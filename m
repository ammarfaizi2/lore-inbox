Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUGRW1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUGRW1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUGRW1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:27:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62126 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264561AbUGRW1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:27:05 -0400
Date: Mon, 19 Jul 2004 00:27:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040718222704.GG31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please pull from
> 
> 	bk://kernel.bkbits.net:/home/mochel/linux-2.6-power

I noticed that it now fixes swap signatures early, good.

> <mochel@digitalimplant.org> (04/07/17 1.1865)
>    [swsusp] Remove unneeded suspend_pagedir_lock.

How do you guarantee that while copying pages back and forth,
interrupts are disabled? They have to be, because memory snapshots are
no longer atomic.

In one patch, there's "Invalid partition" message when there's
incorrect signature may be confusing.

Otherwise patches are good. Perhaps it is easier to merge them with
Andrew now and fix remaining few issues with follow up patches?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
