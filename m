Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTBFWnU>; Thu, 6 Feb 2003 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTBFWnT>; Thu, 6 Feb 2003 17:43:19 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9144 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267671AbTBFWnS>;
	Thu, 6 Feb 2003 17:43:18 -0500
Date: Thu, 6 Feb 2003 22:49:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: niteowl@intrinsity.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 kernel bugs
Message-ID: <20030206224900.GA15328@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, niteowl@intrinsity.com,
	linux-kernel@vger.kernel.org
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com> <20030206131640.2e668374.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206131640.2e668374.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 01:16:40PM -0800, Andrew Morton wrote:

 > gcc -W generates ten megabytes of warnings, with a few gems.  We really need
 > finer-grained control of gcc warnings so that the good ones can be turned on.
 > gcc warnings are being redone at present and this might yet happen...

A 'spare time' project of mine is to get -W builds at least 'mostly clean'
The low hanging fruit got fixed up a while back. Most of the remainder
is signed comparison warnings.  gcc-3.4 has promoted this warning to
show up in regular builds too, so at some point, either a lot of effort
is going to have to be undertaken to fix those, or we use -Wno-signed-compare
during builds.

 > As for the rest well gee.  Perhaps we should stick #error's in there to
 > flush out some people who can test the fixes.

Just for giggles I did a quick audit of the results of a make
allyesconfig a few weekends ago. The number of drivers we still have
that need updating to new APIs (from tqueue conversions to cli/sti etc)
is quite disturbing. There's a lot of groundwork to be done there
hopefully before we get to a 2.6test phase, or we're going to be
obsoleting boatloads of drivers.

I meant to clean up the output and feed it all into bugzilla.
I'll get around to it sometime..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
