Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUKMSAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUKMSAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUKMSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 13:00:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:8597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261856AbUKMSAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 13:00:47 -0500
Date: Sat, 13 Nov 2004 10:00:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: adaplas@pol.net
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Guido Guenther <agx@sigxcpu.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <200411132000.31465.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix>
 <200411132000.31465.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> 
> Why not use in_be* and out_be* for __raw_read and raw_write? 

Please don't start using some stupid magic ppc-specific macros for a 
driver that has no reason to be PPC-specific. It then only causes bugs 
that show on one platform and not another.

		Linus
