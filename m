Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKTTYC>; Wed, 20 Nov 2002 14:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSKTTYB>; Wed, 20 Nov 2002 14:24:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63624 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262667AbSKTTYB>;
	Wed, 20 Nov 2002 14:24:01 -0500
Date: Wed, 20 Nov 2002 19:29:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc2 strange L1 cache values
Message-ID: <20021120192915.GA14194@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Steffen Persvold <sp@scali.com>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <20021120190112.GC10698@suse.de> <Pine.LNX.4.44.0211202011291.15336-100000@sp-laptop.isdn.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211202011291.15336-100000@sp-laptop.isdn.scali.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 08:23:04PM +0100, Steffen Persvold wrote:

 > The original poster reported on 2.4.20-rc2 (which reports 0K), not 2.4.18. 
 > The output I provided was from .18 and that clearly says 'L1 I cache:12K'.
 > Here are some 'sniplets' of my 2.4.18 dmesg :
 > CPU: L1 I cache: 12K, L1 D cache: 8K

My bad. Yes, earlier kernels did confuse the two.
the 12K actually means the trace cache holds 12,000 uops
rather than you have 12KB of cache.

The only bug is the reporting unit.

 > Ok, since this is now fixed (with your patch), I really don't care about 
 > earlier kernels anyway (however some of my customer might have if it was 
 > an issue). Do you know if your patch is going into 2.4.20 release (it's a 
 > rather small and useful patch) ?

I've resubmitted it to Marcelo, but it still didn't show up..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
