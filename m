Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWJLVem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWJLVem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWJLVem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:34:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47516
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751049AbWJLVel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:34:41 -0400
Date: Thu, 12 Oct 2006 14:34:42 -0700 (PDT)
Message-Id: <20061012.143442.105431995.davem@davemloft.net>
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061012143726.GD21243@ele.uri.edu>
References: <20061010132943.GB18539@ele.uri.edu>
	<20061010.151751.90998930.davem@davemloft.net>
	<20061012143726.GD21243@ele.uri.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 12 Oct 2006 10:37:26 -0400

> This will be difficult as the machine in question isn't one I want to
> reboot too often. The running kernel and modules are compiled with debug
> info, though; if I send you the relevant .o files will that help?

The reason I asked for it in the image is because I want to tell gdb
"x/10i 0xZZZZZ" using the exact program counters in the dumps and get
exactly the instruction that is faulting.

That is very difficult with modules since they can get loaded at any
address, and the gdb listings you provided with those symbol-relative
addresses were non-sensible, and that's why I can't match the true
cause up right now.

So whilst I can try with a module image, you'd have to do things like
tell me exactly what is the base address of the loaded kernel module
at the time of the message trigger and other non-trivial stuff like
that to get me the debugging info I want to fix this.

Thanks.
