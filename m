Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbSKUSPE>; Thu, 21 Nov 2002 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSKUSPE>; Thu, 21 Nov 2002 13:15:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6293 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266929AbSKUSPC>;
	Thu, 21 Nov 2002 13:15:02 -0500
Date: Thu, 21 Nov 2002 18:18:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021121181818.GA19079@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com> <3DDC8330.FE066815@digeo.com> <20021121132014.GC9883@suse.de> <3DDD162B.BAC88F94@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD162B.BAC88F94@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 09:21:47AM -0800, Andrew Morton wrote:

 > > Good eyes. But.. this also applies to 2.4 (which should also then
 > > get faster). So the gap between 2.4 & 2.5 must be somewhere else ?
 > 
 > But 2.4 already inlines the usercopy functions.   With this benchmark,
 > the cost of the function call is visible.   Same with the dir_rtn_1
 > test - it is performing zillions of 3, 7, 10-byte copies into userspace.

But the reduction of number of copy_*_user's applies to 2.4 too right ?

 > We'd buy a bit by arranging for the in-kernel copy of the fp state
 > to have the same layout as the hardware.  That way it can be done in
 > a single big, fast, well-aligned slurp.  But for some reason that code has
 > to convert into and out of a different representation.

Possibly hardware restrictions, I'm unfamiliar with how this voodoo works.

 > But the real low-hanging fruit here is the observation that the
 > test application doesn't use floating point!!!

Interesting point. What was the test app ? contest ?
(I missed the beginning of this thread).

 > Maybe we need to take an fp trap now and then to "poll" the application
 > to see if it is still using float.

Neat idea. Bonus points for making it work 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
