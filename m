Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUAZT51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUAZT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:57:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:41156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264971AbUAZT50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:57:26 -0500
Date: Mon, 26 Jan 2004 11:56:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric <eric@cisu.net>
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040126115614.351393f2.akpm@osdl.org>
In-Reply-To: <200401261326.09903.eric@cisu.net>
References: <200401232253.08552.eric@cisu.net>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125220027.30e8cdf3.akpm@osdl.org>
	<200401261326.09903.eric@cisu.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric <eric@cisu.net> wrote:
>
> On Monday 26 January 2004 00:00, Andrew Morton wrote:
>  > "John Stoffel" <stoffel@lucent.com> wrote:
>  > > Sure, the darn thing wouldn't boot, it kept Oopsing with the
>  > >  test_wp_bit oops (that I just posted more details about).
>  >
>  > Does this fix the test_wp_bit oops?
> 
>  Yes, it fixes my test_wp_bit oops. But NOW, when booting 2.6.2-rc1-mm3 (which 
>  i pathed removing -funit-at-a-time and the wp_but oops patch) I get an oops 
>  derefrencing null pointer in blkdev_reread_part.

It is likely that this can be fixed by reverting

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/broken-out/md-06-allow-partitioning.patch
