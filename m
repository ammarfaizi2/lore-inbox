Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267674AbUHPO4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267674AbUHPO4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHPO4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:56:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28380 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S267676AbUHPOxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:53:51 -0400
Date: Mon, 16 Aug 2004 07:53:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: How to debug 2.6 PReP boot hang?
Message-ID: <20040816145347.GD2377@smtp.west.cox.net>
References: <20040729225559.GJ16468@smtp.west.cox.net> <Pine.GSO.4.44.0408161729570.5336-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0408161729570.5336-100000@math.ut.ee>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 05:39:19PM +0300, Meelis Roos wrote:

> > My suggestion is to go back in releases until one does work, see where
> > the changes are that break it, and work from there.  It should be
> > possible to fix what broke. :)
> 
> OK, did some compiling and testing and fout that my suspicion was right:
> BK changeset 1.1371.384.5 boots ok but 1.1371.384.6 makes it hang.
> 
> It's the one that reorganizes boot code:
> PPC32: Kill off arch/ppc/boot/prep and rearrange some files.

Sadly, that is what I expected.  Try narrowing down the differences
between prep/head.S and simple/head.S (or rather head.s via make
arch/ppc/boot/prep/head.s and simple/head.s to strip out comments, etc).

-- 
Tom Rini
http://gate.crashing.org/~trini/
