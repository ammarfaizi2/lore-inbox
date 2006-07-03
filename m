Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWGCUAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWGCUAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGCUAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:00:12 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:33703 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751271AbWGCUAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:00:10 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 12:59:43 -0700
Message-Id: <1151956783.5325.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 18:56 -0700, Daniel Walker wrote:
> On Mon, 2006-07-03 at 03:13 +0200, Roman Zippel wrote:
> I was reviewing these new ntp adjustment functions, and it seems like it
> would be a lot easier to just switch to a better clocksource. These new
> functions seems to compensate for a clock that has a high rating but is
> actually quite poor..

Not quite. The issue is that the adjustment that the ntpd makes is quite
fine grained, and some clocksources while quite stable, might not be
able to make such a fine adjustment. So the extra error accounting just
allows us to keep track and compensate for the resolution differences.

Does that make sense?

thanks
-john


