Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKTS4H>; Wed, 20 Nov 2002 13:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSKTS4H>; Wed, 20 Nov 2002 13:56:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:40584 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262215AbSKTS4G>;
	Wed, 20 Nov 2002 13:56:06 -0500
Date: Wed, 20 Nov 2002 19:01:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc2 strange L1 cache values
Message-ID: <20021120190112.GC10698@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Steffen Persvold <sp@scali.com>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <20021120181359.GA10698@suse.de> <Pine.LNX.4.44.0211201941290.15336-100000@sp-laptop.isdn.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201941290.15336-100000@sp-laptop.isdn.scali.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 07:48:27PM +0100, Steffen Persvold wrote:

 > >  > <6>CPU: L1 I cache: 0K, L1 D cache: 8K
 > Yep that works (I have two Xeon boxes with the same issue) :
 > But why does this P4 Trace cache report as L1 I cache on 2.4.18 ? 

Look again above, and you'll see .18 said it had 0K L1 (which is
correct, L1 != Trace cache).
 
 > Does this have any implications on the 2.4.18 performance (or the 
 > 2.4.20-rc2 performance without the descriptors.diff) ?

The SMP weighting should be done with L2 cache size, which
was correct on .18 too, so it should be ok.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
