Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275266AbTHSAkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275264AbTHSAkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:40:04 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:49650 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S275266AbTHSAje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:39:34 -0400
Date: Mon, 18 Aug 2003 20:37:18 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
In-Reply-To: <200308191028.11109.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.56.0308182032320.23352@onpx40.onqynaqf.bet>
References: <20030817003128.04855aed.voluspa@comhem.se>
 <200308172336.42593.kernel@kolivas.org> <3F416BD4.3040302@sbcglobal.net>
 <200308191028.11109.kernel@kolivas.org>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Con Kolivas wrote:

> > Is there a way to figure out when a process is spinning on a wait and
>
> That's the trick isn't it? No there isn't or else I'd fix it in a jiffy. If
> someone can think of a way I'd love to know.

Have you considered instrumenting waits/locks ? I had to do that for a
schedular/locks/events (not Linux based), by extending the structures
to include current ownership and waiters...  At a problem point, you'd
then have to use something like sysreq to trigger a scan of the relevant
data areas.  I had to cause an error and do a postmortem via paper dump
:(

-- 
Rick Nelson
> : Any porters out there should feel happier knowing that DEC is shipping
> : me an AlphaPC that I intend to try getting linux running on: this will
> : definitely help flush out some of the most flagrant unportable stuff.
> : The Alpha is much more different from the i386 than the 68k stuff is, so
> : it's likely to get most of the stuff fixed.
>
> It's posts like this that almost convince us non-believers that there
> really is a god.
	-- Anthony Lovell, to Linus's remarks about porting
