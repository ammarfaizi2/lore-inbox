Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWC2CCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWC2CCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWC2CCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:02:18 -0500
Received: from koto.vergenet.net ([210.128.90.7]:17099 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750733AbWC2CCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:02:18 -0500
Date: Wed, 29 Mar 2006 10:57:46 +0900
From: Horms <horms@verge.net.au>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab: optimize constant-size kzalloc calls
Message-ID: <20060329015745.GA29301@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142868958.11159.0.camel@localhost>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I feel like I mist be dreaming, but this patch, which was inlcuded
in Linus' tree as 40c07ae8daa659b8feb149c84731629386873c16 calls
__you_cannot_kzalloc_that_much(), but that does not seem to exist.

On i386 at least that causes a build failure

# make mrproper
# make allyesconfig
# make 
[snip]
drivers/built-in.o: In function `kzalloc':include/linux/slab.h:128: undefined reference to `__you_cannot_kzalloc_that_much'
:include/linux/slab.h:128: undefined reference to
`__you_cannot_kzalloc_that_much'
make: *** [.tmp_vmlinux1] Error 1

-- 
Horms
