Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSKUNze>; Thu, 21 Nov 2002 08:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSKUNze>; Thu, 21 Nov 2002 08:55:34 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:41618 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266654AbSKUNze>;
	Thu, 21 Nov 2002 08:55:34 -0500
Date: Thu, 21 Nov 2002 14:00:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021121140009.GH9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com> <3DDC8330.FE066815@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC8330.FE066815@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > OK, got it back to 119000.  Each signal was calling copy_*_user 24 times.
 > > This gets it down to six.
 > Also maybe we can do something about that multiple memcpy in copy_fpu_fxsave()
 > In fact, that looks a bit fishy. We copy 10 bytes each memcpy, but
 > advance the to ptr 5 bytes each iteration. What gives here ?

<morning caffiene kicks in>
Doh, of course.. it's copying shorts. Still looks icky though IMO.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
