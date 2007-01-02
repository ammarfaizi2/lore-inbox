Return-Path: <linux-kernel-owner+w=401wt.eu-S1754977AbXABVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXABVd0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbXABVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:33:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:36177 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbXABVdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:33:25 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, David Kahn <dmk@flex.com>,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
In-Reply-To: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <20061230.211941.74748799.davem@davemloft.net>
	 <459784AD.1010308@firmworks.com>
	 <1167709992.6165.18.camel@localhost.localdomain>
	 <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org>
	 <1167768735.6165.68.camel@localhost.localdomain>
	 <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 08:32:36 +1100
Message-Id: <1167773556.6165.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The kernel doesn't care if one CPU is in OF land while the others
> are doing other stuff -- well you have to make sure the OF won't
> try to use a hardware device at the same time as the kernel, true.

That statement alone hides an absolute can of worms btw ;-)

> I'm a bit concerned about the 100kB or so of data duplication
> (on a *quite big* device tree), and the extra code you need
> (all changes have to be done to both tree copies).  Maybe
> I shouldn't be worried; still, it's obviously not a great
> idea to *require* any arch to get and keep a full copy of
> the tree -- it's wasteful and unnecessary.

Well, big device-trees generally are on big machines with enough memory
not to care and the only platform I know where the DT can actually
change over time is IBM pSeries when doing DLPAR, in which case, OF is
dead, it all happens via magic HV/RTAS calls and the kernel is
-supposed- to maintain it's own copy and add/remove nodes from it.

Ben.


