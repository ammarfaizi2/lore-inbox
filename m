Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWGCB4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWGCB4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWGCB4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:56:30 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:23505 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750896AbWGCB43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:56:29 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: Daniel Walker <dwalker@mvista.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Valdis.Kletnieks@vt.edu, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607030256581.17704@scrub.home>
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
Content-Type: text/plain
Date: Sun, 02 Jul 2006 18:56:22 -0700
Message-Id: <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 03:13 +0200, Roman Zippel wrote:

> It's a possibility, but the signed/unsigned usage is pretty much 
> intentional. The assumptation is that time only goes forward so nothing 
> there should become negative, only adjustments happen in both directions.
> It's really weird why it's getting completely so out of control early 
> during boot. It would be great if you could also test the patch below, it 
> should trigger closer to when it goes wrong and help to analyze the 
> problem (or at least rule out a number of possibilities).

I was reviewing these new ntp adjustment functions, and it seems like it
would be a lot easier to just switch to a better clocksource. These new
functions seems to compensate for a clock that has a high rating but is
actually quite poor..

Daniel

