Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJCWKl>; Thu, 3 Oct 2002 18:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSJCWKl>; Thu, 3 Oct 2002 18:10:41 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:42650 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261318AbSJCWKk>;
	Thu, 3 Oct 2002 18:10:40 -0400
Date: Thu, 3 Oct 2002 23:19:19 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] [TRIVIAL] missing entry in Intel cache table
Message-ID: <20021003221919.GA14919@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
References: <20021003212821.E1A2E40E31@kraid.nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003212821.E1A2E40E31@kraid.nerim.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:38:40PM +0200, Jean Delvare wrote:
 > Hello everyone.
 > 
 > It seems that the Intel cache table in arch/i386/kernel/setup.c misses one entry. It must have been lost in 2.4.20-pre1 when Andy Grover converted the old switch-case-based method to the much-nicer table-based one.
 > 
 > --- linux-2.4.20-pre8/arch/i386/kernel/setup.c.orig	Thu Oct  3 19:34:34 2002
 > +++ linux-2.4.20-pre8/arch/i386/kernel/setup.c	Thu Oct  3 19:36:39 2002
 > @@ -2212,6 +2212,7 @@
 >  	{ 0x7B, LVL_2,      512 },
 >  	{ 0x7C, LVL_2,      1024 },
 >  	{ 0x82, LVL_2,      256 },
 > +	{ 0x83, LVL_2,      512 },
 >  	{ 0x84, LVL_2,      1024 },
 >  	{ 0x85, LVL_2,      2048 },
 >  	{ 0x00, 0, 0}
 > 
 > The same applies to the 2.5 tree, see my next post.

See the patch I posted last Sunday fixing this, and
several other cache related issues.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
