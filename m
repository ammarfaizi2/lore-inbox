Return-Path: <linux-kernel-owner+w=401wt.eu-S1755319AbXABVh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbXABVh0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbXABVhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:37:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:52377 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319AbXABVhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:37:25 -0500
In-Reply-To: <1167770882.6165.76.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr> <20061231.124531.125895122.davem@davemloft.net> <1167709406.6165.6.camel@localhost.localdomain> <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org> <1167768494.6165.63.camel@localhost.localdomain> <459ABC7C.2030104@firmworks.com> <1167770882.6165.76.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 22:37:32 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do object basically to having something that doesn't also provide
> in-kernel interfaces to access the device nodes & properties.

That's the wrong way around.  Work is underway to instead
have the devicetreefs *use* the in-kernel interfaces.  Would
that be acceptable?

> I don't
> agree with the reasoning that x86 will never need it.

Neither do I :-)

> Now, we have
> currently two slightly different interfaces, on powerpc and sparc, to
> access them, and that's I think we should try to converge and use the
> same interface for x86.

All should converge on the same interface.  That does not
ab initio mean we should converge on what you currently
have (although that might eventually be that case).

> In addition, as sparc64 also moved to an in-memory copy of the tree, I
> tend to be fairly convinced that we should also move toward the same
> -implementation- also based on an in-memory copy of the tree which is
> more efficient (and doesn't use a significant amount of RAM).

Leaving aside the issue of in-memory or not, I don't think
it is realistic to think any completely common implementation
will work for this -- it might for current SPARC+PowerPC+OLPC,
but more stuff will be added over time...


Segher

