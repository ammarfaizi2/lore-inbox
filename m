Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314487AbSEHQjq>; Wed, 8 May 2002 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314625AbSEHQjq>; Wed, 8 May 2002 12:39:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42493 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314487AbSEHQjp>; Wed, 8 May 2002 12:39:45 -0400
Subject: Re: [PATCH] preemptive kernel for 2.4.19-pre7-ac4
From: Robert Love <rml@tech9.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020508123221.GF22050@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 09:39:56 -0700
Message-Id: <1020875996.2084.121.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 at 05:32, Tomas Szepe wrote:

> > The preempt-kernel patch for 2.4.19-pre7-ac4 is now available at
> > 	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-pre7-ac4-1.patch
> 
> ... applies to -pre8-ac1 as well. Safe to use?

Yep.  I sent Alan a few more scheduler updates - if he puts them in
pre8-ac2, that may break the diff but still nothing incompatible. 
Always assume (with most patches, really) that if it applies, it is
fine.

An exception would be things like lock-break or low-latency that assume
intricate knowledge of the locking and calling semantics of functions. 
If they apply, they should compile and boot, but a deadlock may lurk. 
This is partly why these solutions are horrible to maintain or get right
and the preemptible kernel is a wiser long-term solution to latency and
such.

	Robert Love

