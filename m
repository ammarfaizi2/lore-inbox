Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265723AbSKATVL>; Fri, 1 Nov 2002 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSKATVL>; Fri, 1 Nov 2002 14:21:11 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59265 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265723AbSKATVE>;
	Fri, 1 Nov 2002 14:21:04 -0500
Date: Fri, 1 Nov 2002 19:26:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Akihiro Matsushima <amatsus@jaist.ac.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add Intel cache-detection descriptors to the table
Message-ID: <20021101192618.GB31669@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Akihiro Matsushima <amatsus@jaist.ac.jp>,
	linux-kernel@vger.kernel.org
References: <20021029.091355.41631341.amatsus@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029.091355.41631341.amatsus@jaist.ac.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 09:13:55AM +0900, Akihiro Matsushima wrote:
 > This patch adds new discriptors to IA-32 cache-detection table
 > and fixes a failure in L2 cache detection on 2.4.20-pre series.
 > 
 > Thanks,
 > Akihiro
 > 
 > --- arch/i386/kernel/setup.c.orig	Sat Oct 19 10:30:52 2002
 > +++ arch/i386/kernel/setup.c	Sat Oct 19 10:40:16 2002
 > @@ -2202,6 +2202,8 @@
 >  	{ 0x23, LVL_3,      1024 },
 >  	{ 0x25, LVL_3,      2048 },
 >  	{ 0x29, LVL_3,      4096 },
 > +	{ 0x39, LVL_2,      128 },
 > +	{ 0x3C, LVL_2,      256 },
 >  	{ 0x41, LVL_2,      128 },
 >  	{ 0x42, LVL_2,      256 },
 >  	{ 0x43, LVL_2,      512 },
 > @@ -2214,7 +2216,9 @@
 >  	{ 0x7A, LVL_2,      256 },
 >  	{ 0x7B, LVL_2,      512 },
 >  	{ 0x7C, LVL_2,      1024 },
 > +	{ 0x7E, LVL_2,      256 },
 >  	{ 0x82, LVL_2,      256 },
 > +	{ 0x83, LVL_2,      512 },
 >  	{ 0x84, LVL_2,      1024 },
 >  	{ 0x85, LVL_2,      2048 },
 >  	{ 0x00, 0, 0}

I sent a more complete fix to Marcelo some time ago.
It's queued for .21 aparently.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
