Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUCEJab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUCEJab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:30:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:714 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262273AbUCEJa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:30:26 -0500
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       =?ISO-8859-1?Q?Martin-=C9ric?= Racine <q-funk@pp.fishpool.fi>
In-Reply-To: <20040305092422.C22156@flint.arm.linux.org.uk>
References: <1078473270.5703.57.camel@gaston>
	 <20040305085838.B22156@flint.arm.linux.org.uk>
	 <1078477504.5700.69.camel@gaston>
	 <20040305092422.C22156@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1078478951.5698.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 20:29:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I know - but the point is its impossible to review, and I think
> you at least have an extra level of locking which isn't needed.
> 
> But I wouldn't know because of the huge number of changes which make
> it impossible to read.

That semaphore locking is only used to guard open/close against the
power management callback. It greatly simplify the deal with the shared
irq (the irq is shared between both ports). It's not used during
normal operations.

Ben.


