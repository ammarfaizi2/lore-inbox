Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUIEC5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUIEC5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUIEC5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:57:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:13489 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266003AbUIEC5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:57:41 -0400
Date: Sun, 5 Sep 2004 03:57:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: faith@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.9-rc1-bk11/driver/char/drm/gamma_drm.c does not compile
In-Reply-To: <200409051749.i85Hnrx03529@freya.yggdrasil.com>
Message-ID: <Pine.LNX.4.58.0409050356150.14009@skynet>
References: <200409051749.i85Hnrx03529@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gamma is marked as broken now it shouldn't even build anymore.. it is
broken, in more ways than makes it easy to fix, no DRI developer has any
major interest in it.. and we think we tracked down the 3 users ....

Dave.

On Sun, 5 Sep 2004, Adam J. Richter wrote:

> 	drivers/char/drm/gramm_drm.c compiled under bk10, but fails
> to compile under bk11.  I think the bad patch was "DRM initial function
> table support", at the URL
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109395880025924&w=2 .
>
> 	It looks like gamma_driver_register_fns() tries to set some
> nonexistant fields in dev->fn_tbl to point to some nonexistant
> subroutines.  I would guess that the lines from gamma_dma.c can just
> be deleted, but perhaps this compile error indicates some more
> substantial version skew.
>
> drivers/char/drm/gamma_dma.c: In function `gamma_driver_register_fns':
> drivers/char/drm/gamma_dma.c:943: error: structure has no member named `dma_flush_block_and_flush'
> drivers/char/drm/gamma_dma.c:944: error: structure has no member named `dma_flush_unblock'
>
>                     __     ______________
> Adam J. Richter        \ /
> adam@yggdrasil.com      | g g d r a s i l
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

