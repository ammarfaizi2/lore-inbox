Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJMW2G>; Sun, 13 Oct 2002 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbSJMW2G>; Sun, 13 Oct 2002 18:28:06 -0400
Received: from dp.samba.org ([66.70.73.150]:2459 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261733AbSJMW2F>;
	Sun, 13 Oct 2002 18:28:05 -0400
Date: Mon, 14 Oct 2002 08:31:14 +1000
From: Anton Blanchard <anton@samba.org>
To: James Simmons <jsimmons@infradead.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <20021013223114.GA26506@krispykreme>
References: <20021012014332.GA7050@krispykreme> <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ugh!!! The reason I reworked the console system is because over the years
> hack after hack has been added. It now has lead to this twisted monster.
> Take a look at the fbdev driver codes in 2.4.X. Instead of another hack
> the console system should be cleaned up with a well thought out design to
> make the code base smaller and more effiencent.

Where is the hack? The ppc64 early console code uses a hypervisor call
or a serial port routine which have no business being in a generic
console infrastructure.

At the moment its two lines called before start_kernel to register the
console, and 4 lines of disable_early_printk. We use existing routines
to talk to the hypervisor or serial console.

How is the reworked console system going to reduce this? :)

Anton
