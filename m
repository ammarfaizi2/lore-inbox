Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUKHVz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUKHVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKHVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:55:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:3208 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261255AbUKHVxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:53:33 -0500
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@pol.net
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200411081706.55261.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 08:52:01 +1100
Message-Id: <1099950722.10262.166.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 17:06 +0800, Antonino A. Daplas wrote:

> 
> How about this patch?  This is almost the original macro in riva_hw.h,
> with the __force annotation.

I don't like it neither. It lacks barriers. the rivafb driver
notoriously lacks barriers, except in a few places where it was so bad
that it actually broke all the time, where we added some. This
originates from the X "nv" driver written by Mark Vojkovich who didn't
want to hear about barriers for perfs reasons I think.

Ben.


