Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUJVG0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUJVG0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269932AbUJVGVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:21:44 -0400
Received: from dp.samba.org ([66.70.73.150]:26284 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269783AbUJVGSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:18:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.42476.100810.814646@samba.org>
Date: Fri, 22 Oct 2004 16:17:16 +1000
To: Jim Houston <jim.houston@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: idr in Samba4
In-Reply-To: <1098383538.987.359.camel@new.localdomain>
References: <16759.16648.459393.752417@samba.org>
	<1098383538.987.359.camel@new.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim,

 > The attached patch against linux-2.6.9 should do the job without
 > additional overhead.  Andrew, I hope you will add this patch to
 > your tree.

Thanks, that looks good, and it now passes my randomized testsuite.

If you are interested, my test code is at:

  http://samba.org/ftp/unpacked/junkcode/idtree/

Note that I made idr_remove() and sub_remove() return an int for
success/failure, as that was more useful for my code, and it also
means we skip the layer free logic on remove failure (not that it does
any harm, just seems a bit of a loose end).

Cheers, Tridge
