Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCMU40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCMU40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVCMU40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:56:26 -0500
Received: from holomorphy.com ([66.93.40.71]:2225 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261457AbVCMU4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:56:22 -0500
Date: Sun, 13 Mar 2005 11:56:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Matthew Wilcox <matthew@wil.cx>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@au.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH][0/10] verify_area cleanup
Message-ID: <20050313195611.GE15648@holomorphy.com>
References: <Pine.LNX.4.62.0503040247220.2801@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503040247220.2801@dragon.hygekrogen.localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:47:07AM +0100, Jesper Juhl wrote:
> Now that 2.6.11 is out the door it's time to try and submit this again.
> The following patches convert all users of verify_area to access_ok and 
> the final patch then deprecates verify_area acros all archs with the 
> intention of removing it completely later. These patches get rid of 99+% 
> of all users, there's still one or two macros left using it and there are 
> still a few comments left refering to it that could be cleaned up - I'll 
> get to those, but what remains after these patches is extremely little.
> The reason for doing this is that verify_area is just a wrapper for 
> access_ok anyway, so there's no good reason to keep it around - access_ok 
> also seems more readable anyway with saner return values.
> Since these patches touch things all over the tree the CC list would be 
> enormous if I CC'd everyone involved on all patches, so I'll just CC this 
> initial mail to a few key people I think are relevant (I hope I got that 
> list right), and the actual patches I'll just send to linux-kernel and 
> Andrew (or directly to people who ask for that).

The execution at first glance appears good. Out of curiosity, does this
serve a larger purpose than eliminating a redundant API?


-- wli
