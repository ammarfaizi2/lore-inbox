Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVKASdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKASdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVKASdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:33:24 -0500
Received: from waste.org ([216.27.176.166]:41358 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751074AbVKASdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:33:24 -0500
Date: Tue, 1 Nov 2005 10:28:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Subject: Oops! Forgot [PATCH 0/20] inflate cleanups
Message-ID: <20051101182816.GA8126@waste.org>
References: <2.196662837@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2.196662837@selenic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Just realized that my 0/20 description didn't go out, so here it is.
I'll wait a bit more before respinning the set with feedback.]

This is a refactored version of the lib/inflate.c I posted about a
year ago. It has a few end goals:

- clean up some really ugly code
- clean up atrocities like '#include "../../../lib/inflate.c"'
- drop a ton of cut and paste code from the kernel boot
- move towards making the boot decompressor pluggable
- move towards unifying the multiple inflate implementations
- save space

This touches 11 architectures, which makes things slightly
interesting. Rather than break the patches out by arch, I've gone the
route of making a number of small incremental changes that sweep
across the tree. Patches that touch the per-arch code are marked
"(arch)".

I've been primarily testing this on x86, but various versions of this
code have gotten testing on a variety of architectures as part of my
linux-tiny tree.

-- 
Mathematics is the supreme nostalgia of our time.
