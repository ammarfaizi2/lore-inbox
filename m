Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbVICGNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbVICGNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbVICGNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:13:54 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:36489 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161157AbVICGNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:13:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Date: Sat, 3 Sep 2005 16:13:10 +1000
User-Agent: KMail/1.8.2
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org> <20050902175623.D6546@flint.arm.linux.org.uk>
In-Reply-To: <20050902175623.D6546@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031613.10915.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005 02:56, Russell King wrote:
> On Sat, Sep 03, 2005 at 01:43:57AM +1000, Con Kolivas wrote:
> > Ok I've resynced all the patches with 2.6.13-mm1, made some cleanups and
> > minor modifications. As pm timer is the only supported timer for dynticks
> > I've also made it depend on it.
> >
> > A rollup patch against 2.6.13-mm1 is here:
> >
> > http://ck.kolivas.org/patches/dyn-ticks/2.6.13-mm1-dtck1.patch
> >
> > also available in the dyn-ticks directory are the older patches and these
> > split out patches posted here.
>
> Are you guys going to sync your interfaces with what ARM has, or are
> we going to have two differing dyntick interfaces in the kernel, one
> for ARM and one for x86?
>
> I mentioned this before.  I seem to be ignored.

RMK

Noone's ignoring you. 

What we need to do is ensure that dynamic ticks is working properly on x86 and 
worth including before anything else. If and when we confirm this it makes 
sense only then to try and merge code from the other 2 architectures to as 
much common code as possible as no doubt we'll be modifying other 
architectures we're less familiar with. At that stage we will definitely want 
to tread even more cautiously at that stage.

Cheers,
Con
