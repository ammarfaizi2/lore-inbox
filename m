Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUA0Gie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUA0Gie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:38:34 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:41881 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S262925AbUA0Gid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:38:33 -0500
From: Eric <eric@cisu.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Tue, 27 Jan 2004 00:37:43 -0600
User-Agent: KMail/1.5.94
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org>
In-Reply-To: <20040126215056.4e891086.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401270037.43676.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 23:50, Andrew Morton wrote:
> Eric <eric@cisu.net> wrote:
> > YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
> >  Lets review folks---
> >  	reverted -funit-at-a-time
> >  	patched test_wp_bit so exception tables are sorted sooner
> >  	reverted md-partition patch
>
> The latter two are understood, but the `-funit-at-a-time' problem is not.
>
> Can you plesae confirm that restoring only -funit-at-a-time again produces
> a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I
> guess we'll need to only enable it for gcc-3.4 and later.
>
Yes, confirmed. My  version of gcc, I just sent you adding the 
-funit-at-a-time hung after uncompressing the kernel. I booted a secondary 
kernel, recompiled without it and all was fine again. Confirmed non-boot for 
2.6.2-rc1-mm3 but without a doubt for all kernels previous where 
-funit-at-a-time is active in the makefile.

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
