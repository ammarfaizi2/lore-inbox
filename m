Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHGL3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHGL3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWHGL3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:29:04 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:32373 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750727AbWHGL3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:29:03 -0400
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
	aliasing problem)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: schwidefsky@googlemail.com, johnstul@us.ibm.com, akpm@osdl.org,
       zippel@linux-m68k.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, ak@muc.de
In-Reply-To: <20060807.011319.41196590.anemo@mba.ocn.ne.jp>
References: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
	 <20060804.005352.128616651.anemo@mba.ocn.ne.jp>
	 <6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
	 <20060807.011319.41196590.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 07 Aug 2006 13:28:35 +0200
Message-Id: <1154950115.6721.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 01:13 +0900, Atsushi Nemoto wrote:
> On Fri, 4 Aug 2006 16:02:43 +0200, "Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:
> > Good start, now you only have the change the 30+ calls to do_timer in
> > the various architecture backends.
> 
> OK, then this is a patch contains the changes.
> Adding S390 maintainer Martin Schwidefsky to CC.
> 
> This patch is against current git tree, so does not contains a change
> to arch/avr32 which is in mm tree.  I can create a patch against mm
> tree if expected.
> 
> 
> [PATCH] cleanup do_timer and update_times
> 
> Pass ticks to do_timer() and update_times().
> 
> This also make a barrier added by
> 5aee405c662ca644980c184774277fc6d0769a84 needless.
> 
> Also adjust x86_64 and s390 timer interrupt handler with this change.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


