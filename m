Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266640AbUFXRWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUFXRWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUFXRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:22:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48608
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266640AbUFXRWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:22:20 -0400
Date: Thu, 24 Jun 2004 19:22:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, Andi Kleen <ak@muc.de>,
       discuss@x86-64.org, tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624172225.GO30687@dualathlon.random>
References: <20040623234644.GC38425@colin2.muc.de> <20040624154429.GC8014@hygelac> <20040624161539.GC8085@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624161539.GC8085@wotan.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 06:15:40PM +0200, Andi Kleen wrote:
> reasonable to require the user to pass special boot options and
> tie up much memory.

the boot parameter will always work and it avoids a new zone. btw, if we
would link the driver into the kernel no boot parameter would be
necessary, if the hardware would be discovered it could allocated its
tons of memory with bootmem. But it sounds like there are too many
drivers in troubles so I believe we can't link them all.
