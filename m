Return-Path: <linux-kernel-owner+w=401wt.eu-S932856AbXABLhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbXABLhT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbXABLhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:37:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:49137 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932856AbXABLhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:37:18 -0500
In-Reply-To: <1167709406.6165.6.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr> <20061231.124531.125895122.davem@davemloft.net> <1167709406.6165.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 12:37:32 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So please do this crap right.
>
> I strongly agree. Nowadays, both powerpc and sparc use an in-memory 
> copy
> of the tree (wether you use the flattened format during the trampoline
> from OF runtime to the kernel or not is a different matter, we created
> that for the sake of kexec and embedded devices with no real OF, but 
> the
> end result is the same, a kernel based tree structure).

Are you really suggesting that using a kernel copy of the
device tree is the correct thing to do, and the only correct
thing to do -- with the sole argument that "that's what the
current ports do"?

> There is already powerpc's /proc/device-tree and sparc's openpromfs, 
> I'm
> all about converging that to a single implementation (a filesystem is
> fine)

We all agree on that, the OLPC people too, they just didn't
have time yet.

> that uses the in-memory tree.

...but to that I can't agree.


Segher

