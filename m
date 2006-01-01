Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWAAMA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWAAMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 07:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAAMA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 07:00:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60687 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751317AbWAAMA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 07:00:56 -0500
Date: Sun, 1 Jan 2006 13:00:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Howto set kernel makefile to use particular gcc
Message-ID: <20060101120057.GS3811@stusta.de>
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in> <200512301624.24229.chriswhite@gentoo.org> <dp89d4$u0i$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dp89d4$u0i$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 07:03:15PM +0900, Kalin KOZHUHAROV wrote:
> 
> As I just stumbeled into a similar problem, I am going to ask here.
> 
> I know the "trick" of `make -j8 CC=distcc` and I always use it. But is there a way to hardwire
> "CC=distcc" insie the Makefile? Just setting it there does not help it seems.

Setting it somewhere at the top of the Makefile doesn't help since the 
Makefile sets it itself later overriding your setting.

The Makefile contains the line
  CC              = $(CROSS_COMPILE)gcc

Change this line to
  CC              = $(CROSS_COMPILE)distcc

> Kalin.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

