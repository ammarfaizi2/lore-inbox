Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSL1Ss5>; Sat, 28 Dec 2002 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSL1Ss5>; Sat, 28 Dec 2002 13:48:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:1214 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266295AbSL1Ss4>;
	Sat, 28 Dec 2002 13:48:56 -0500
Date: Sat, 28 Dec 2002 18:55:57 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.53 AGP module oops
Message-ID: <20021228185556.GA26508@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200212280045.BAA01994@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212280045.BAA01994@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 01:45:22AM +0100, Mikael Pettersson wrote:
 > The stack trace shows that we should be in agp_find_max() as
 > called from agp_backend_initialize(). However, agp_find_max()
 > is __init and its code has already been removed at this point
 > (since agpgart and intel-agp are separate modules), causing
 > the kernel to execute random code and eventually oops.
 > 
 > The patch below works around this by changing agpgart's __init
 > code & data to normal code & data. Tested, works for me.

Looks good to me, applied.

Thanks.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
