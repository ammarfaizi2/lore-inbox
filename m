Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVAVL0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVAVL0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 06:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVAVL0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 06:26:12 -0500
Received: from ns.suse.de ([195.135.220.2]:62091 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262701AbVAVL0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 06:26:10 -0500
Date: Sat, 22 Jan 2005 12:26:08 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050122112608.GB1303@wotan.suse.de>
References: <200501202032.31481.rjw@sisk.pl> <20050122025019.GC27060@wotan.suse.de> <20050122095432.GA2366@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122095432.GA2366@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * TLB flush is purely and debugging attempt to make it fail fast if we
> + * do something wrong. TLB is properly flushed in swsusp_restore.

Did you measure it doesn't noticeable slow down suspend? CR3 reload is quite
expensive, and doing it for each page is quite often.

Also if you want to really flush everything you should do a global
flush.

-Andi
