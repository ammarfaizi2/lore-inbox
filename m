Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUHYX1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUHYX1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHYX1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:27:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:6844 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266065AbUHYXZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:25:43 -0400
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
References: <412AD123.8050605@jp.fujitsu.com>
	 <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
	 <1093417267.2170.47.camel@gaston>
	 <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1093476204.2170.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 09:23:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "good news" is that I doubt very many drivers will care enough to do
> this. I suspect you'll only have a few very specific drivers used in 
> fault-tolerant circumstances, where you care more about the errors than 
> about the inevitable serialization.

Yup, but then, the user have to take care that behind a single "error
checking" entity (a bridge for example), all devices have such drivers
that honor the bridge-level locking and not their own.

On ppc64, I think we always have 1 bridge = 1 slot though, makes things
easier (well, provided we don't start to try playing with error coming
from slots on the g5).

> > I don't know what is the best thing to do here... The arch is the one to
> > know what is the granularity of the error management (per slot ? per segment
> > or per domain ?) and so to know what kind of lock is needed...
> 
> It will have to depend on the bus setup. Not arch-specific per se, but 
> clearly specific to the bus controllers in question. 

Right.

Ben.


