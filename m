Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCIU1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUCIU1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:27:11 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32526
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262132AbUCIU1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:27:06 -0500
Date: Tue, 9 Mar 2004 21:27:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309202744.GS8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu> <20040309163345.GK8193@dualathlon.random> <20040309195752.GA16519@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309195752.GA16519@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 08:57:52PM +0100, Ingo Molnar wrote:
> 'enterprise quality'. My main worry is that we are now at a dozen emails
> regarding this topic and you still dont seem to be aware of the severity
> of this quality of implementation problem.)

the quality of such objrmap patch is still better than rmap. The DoS
thing is doable with vmtruncate too in any kernel out there.

merging objrmap is the first step. Any other effort happens on top of
it.

I never said this was finished with objrmap, I said since the first
place that it was the building block.

> way. This stuff must not be added (to mainline) until it can take the
> load.

mainline is worthless without objrmap even if you don't run into swap,
at least with objrmap it works unless you push the machine into swap.
