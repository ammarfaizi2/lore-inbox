Return-Path: <linux-kernel-owner+w=401wt.eu-S933245AbXAADs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbXAADs2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933246AbXAADs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:48:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:38855 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933245AbXAADs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:48:28 -0500
In-Reply-To: <4597A4A2.9060304@flex.com>
References: <20061230.211941.74748799.davem@davemloft.net>	<459784AD.1010308@firmworks.com>	<45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net> <4597A4A2.9060304@flex.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5798025b8c1eef2c3536c56ac7711560@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Mon, 1 Jan 2007 04:48:50 +0100
To: David Kahn <dmk@flex.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would not exactly call what we have for powerpc
> "exporting the OFW device tree". I don't quite know
> what it is, but it isn't as simple as exporting the
> OFW device tree. I don't think we really wanted to
> get into any of that here.

The Linux PowerPC port uses an OF-like device tree on
*every* platform, even those that don't have a native OF.
It also has to work around lots of bugs in many OF
implementations.  It's doing lots of stuff, and not all
of it is nicely separated into logical modules I'm afraid.

> Sure they can take advantage of it, if what they need
> to export is a read-only copy of the actual device tree
> without any legacy burden or having a writable/changeable
> copy of it with a trivial implementation.

So give them an interface that allows them to hook up to
your new code :-)

> This is a trivial implementation that suits it's purpose.
> It's simple. I'm not sure what more is needed for this
> project when it's pretty clear that i386 will never need
> any additional support for open firmware.

Never say never...


Segher

