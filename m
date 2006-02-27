Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWB0Sno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWB0Sno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWB0Sno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:43:44 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:13742 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751460AbWB0Snn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:43:43 -0500
Date: Mon, 27 Feb 2006 19:33:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH -mm 0/2] mm: shrink_all_memory improvements
Message-ID: <20060227183302.GE2955@elf.ucw.cz>
References: <200602271926.20294.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602271926.20294.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following two patches are designed to improve the shrink_all_memory()
> function used by swsusp and other pm functions.
> 
> The first patch makes shrink_all_memory() overflow-resistant.  The problem is
> that, AFAICT, balance_pgdat(pgdat, nr_to_free, 0) may free more than nr_to_free
> pages, in which case nr_to_free, being unsigned, will overflow (and obviously
> it cannot be less than 0).  Also if the argument is too big, strange things may
> happen.
> 
> The first patch adds a workaround of the problem that shrink_all_memory() may
> return 0 even if there still are some pages to free.  WIth this patch applied
> it sometimes frees 2 times as many pages as without it on my box.
> 
> Please have a look and comment.

ACK on the first one, Andrew, please suggest how to do the second one
better.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
