Return-Path: <linux-kernel-owner+w=401wt.eu-S1754851AbXABUIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbXABUIa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXABUIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:08:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:48815 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbXABUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:08:29 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
In-Reply-To: <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
	 <20061231.124531.125895122.davem@davemloft.net>
	 <1167709406.6165.6.camel@localhost.localdomain>
	 <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 07:08:14 +1100
Message-Id: <1167768494.6165.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 12:37 +0100, Segher Boessenkool wrote:
> >> So please do this crap right.
> >
> > I strongly agree. Nowadays, both powerpc and sparc use an in-memory 
> > copy
> > of the tree (wether you use the flattened format during the trampoline
> > from OF runtime to the kernel or not is a different matter, we created
> > that for the sake of kexec and embedded devices with no real OF, but 
> > the
> > end result is the same, a kernel based tree structure).
> 
> Are you really suggesting that using a kernel copy of the
> device tree is the correct thing to do, and the only correct
> thing to do -- with the sole argument that "that's what the
> current ports do"?

Well, there are reasons why that's what the current ports do :-)

We could of course have the interface work either on a copy of the tree
or on a real OF (though that means changing things like get_property on
powerpc and fixing the gazillions of users) but I tend to think that
working on a copy always is more efficient.

Ben.


