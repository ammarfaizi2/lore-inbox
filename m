Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVH3EUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVH3EUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVH3EUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:20:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10693
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932078AbVH3EUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:20:24 -0400
Date: Mon, 29 Aug 2005 21:20:21 -0700 (PDT)
Message-Id: <20050829.212021.43291105.davem@davemloft.net>
To: torvalds@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
References: <1125371996.11963.37.camel@gaston>
	<Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	<Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 29 Aug 2005 21:09:24 -0700 (PDT)

> So 2.6.13 is being "safe". It allocates the space for the ROM in the
> resource tables, but it neither enables it nor does it write the
> (disabled) address out to the device, since both of those actions have
> been shown to break on PC's. And sadly (or happily, depends on your
> viewpoint), PC's have a _much_ wider range of hardware, so they are the
> ones we have to work around.

Actually, I can tell you that it is a known fact that Qlogic ISP
PCI cards will not respond to I/O and MEM space when you enable
the ROM.  And this behavior exists in quite a few other PCI parts
as well.

So I think the kernel, by not enabling the ROM, is doing the
right thing here.
