Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVLYC06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVLYC06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 21:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLYC06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 21:26:58 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:54540
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1750792AbVLYC06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 21:26:58 -0500
Date: Sat, 24 Dec 2005 18:26:56 -0800
From: Brad Boyer <flar@allandria.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051225022656.GA18947@pants.nu>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk> <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be> <20051215181405.GB27946@ftp.linux.org.uk> <20051215185829.GC27946@ftp.linux.org.uk> <20051215200521.GA18346@pants.nu> <20051222050655.GO27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222050655.GO27946@ftp.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 05:06:55AM +0000, Al Viro wrote:
> On Thu, Dec 15, 2005 at 12:05:21PM -0800, Brad Boyer wrote:
> > I would like to stop using adb_request in mac/misc.c as well, but it's not
> > as simple as just changing it to use cuda_request and pmu_request. That
> > should do it for the cuda and pmu based models, but the egret (Mac IIsi
> > and friends) based models get left out by that fix. If noone else looks
> > at it before me, I'll check this out after I fix some other stuff related
> > to m68k mac support.
> 
> OK...  AFAICS, patch I've just posted to l-k and linux-m68k (subject:
> [PATCH 04/36] m68k: switch mac/misc.c to direct use of appropriate
> cuda/pmu/maciisi requests) should so it.  Do you have any problems with
> that variant?

I don't have any big issues with it. However, I am not at home right now
and can't actually try it out on real hardware. It looks like it should
work as well as the version it is replacing. I'm pretty sure the IIsi
case was broken before. I think we should go ahead and commit this to
get rid of the issues it fixes, and then come back to it later and take
another pass at it to fix the fact that it has never worked in 2.6 on
some models. It's better than nothing.

	Brad Boyer
	flar@allandria.com

