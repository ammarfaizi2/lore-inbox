Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUA0FoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUA0FoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:44:24 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:57240 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S261973AbUA0FoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:44:22 -0500
From: Eric <eric@cisu.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Mon, 26 Jan 2004 23:43:35 -0600
User-Agent: KMail/1.5.94
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401261326.09903.eric@cisu.net> <20040126115614.351393f2.akpm@osdl.org>
In-Reply-To: <20040126115614.351393f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401262343.35633.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 13:56, Andrew Morton wrote:
> Eric <eric@cisu.net> wrote:
> > On Monday 26 January 2004 00:00, Andrew Morton wrote:
> >  > "John Stoffel" <stoffel@lucent.com> wrote:
> >  > > Sure, the darn thing wouldn't boot, it kept Oopsing with the
> >  > >  test_wp_bit oops (that I just posted more details about).
> >  >
> >  > Does this fix the test_wp_bit oops?
> >
> >  Yes, it fixes my test_wp_bit oops. But NOW, when booting 2.6.2-rc1-mm3
> > (which i pathed removing -funit-at-a-time and the wp_but oops patch) I
> > get an oops derefrencing null pointer in blkdev_reread_part.
>
> It is likely that this can be fixed by reverting
>
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.
>6.2-rc1-mm3/broken-out/md-06-allow-partitioning.patch -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
Lets review folks---
	reverted -funit-at-a-time
	patched test_wp_bit so exception tables are sorted sooner
	reverted md-partition patch
Thank you very much for your help. I hope we all learned something today. I 
definatly did.
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
