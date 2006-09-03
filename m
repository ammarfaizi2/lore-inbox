Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWICBk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWICBk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 21:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWICBk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 21:40:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751866AbWICBk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 21:40:58 -0400
Date: Sat, 2 Sep 2006 18:40:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "John Stoffel" <john@stoffel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1, make oldconfig from 2.6.18-rc5 destroys LVM
Message-Id: <20060902184054.5db9fe00.akpm@osdl.org>
In-Reply-To: <17658.9856.132429.196116@smtp.charter.net>
References: <17658.9856.132429.196116@smtp.charter.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006 20:49:04 -0400
"John Stoffel" <john@stoffel.org> wrote:

> 
> Andrew,
> 
> When I do a make oldconfig under 2.6.18-rc5-mm1, with my working
> 2.6.18-rc5 .config file (appended below), all the LVM and MD stuff
> gets blown away silently.  It looks like the drivers/md/Kconfig didn't
> get updated properly when it was tweaked, possibly the new options to
> get rid of BLOCK devices, or the ripping out of LVM1 stuff.
> 
> It looks like instead of 'if CONFIG_BLOCK' at the top, it just needs
> to be 'if BLOCK' instead.  

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/
contains a fix for this.

> And I'd really suggest that it NOT be this silly name BLOCK, something
> more meaningful, like USE_BLOCK_DEVICES or something equally useful to
> parse.

mm...  I think CONFIG_BLOCK is a reasonable compromise between the needs for
brevity and understandability.

-- 
VGER BF report: H 0.277375
