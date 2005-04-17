Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVDQReA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVDQReA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 13:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDQRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 13:33:59 -0400
Received: from waste.org ([216.27.176.166]:65002 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261371AbVDQRd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 13:33:58 -0400
Date: Sun, 17 Apr 2005 10:33:54 -0700
From: Matt Mackall <mpm@selenic.com>
To: David Brownell <david-b@pacbell.net>
Cc: akpm@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.12-rc2] revert fs/char_dev.c CONFIG_BASE_FULL change
Message-ID: <20050417173354.GG21897@waste.org>
References: <200504171006.53328.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504171006.53328.david-b@pacbell.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 10:06:53AM -0700, David Brownell wrote:
> I tracked down a regression in PCMCIA (and other software) to a
> new bogus register_chrdev() behavior that got merged last month;
> a patch from Matt Mackall that misbehaves.

Thanks and sorry about that. I actually asked Linus to revert it right
after Andrew pushed it to him, but I hadn't actually seen a problem
report so I didn't pursue it.
 
> This patch just reverts Matt's, restoring the previous behavior
> but at the cost of about a Kbyte of static memory on 32bit CPUs.
> Someday a Real Fix(tm) would be good.

I've got a Real Fix (a refactor of block and chardev name
registration), will need to wait for .12.

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
