Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUDHXtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUDHXtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:49:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46291
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261925AbUDHXtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:49:02 -0400
Date: Fri, 9 Apr 2004 01:49:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040408234901.GC31667@dualathlon.random>
References: <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random> <29690000.1081462791@flay> <20040408221915.GV31667@dualathlon.random> <32730000.1081466048@flay> <20040408232215.GY31667@dualathlon.random> <39780000.1081467757@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39780000.1081467757@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 04:42:37PM -0700, Martin J. Bligh wrote:
> but still not perfect. Hmm. I'll go think about it ;-)

nothing is perfect anyways ;), if you've an implementation it'd be very
interesting to see a result in the kernel compile with -j with mem=800m,
that should be close to a real life worst case. Then we'll see if the
setup after execve is slowed down measurably, it's hard to tell, but we
know there's a chance since you measure significant slowdown from
pte-highmem on very highmem machines with short lived tasks. btw, note that
if the task isn't short lived, good apps should flood with mmap either (at
least on 64bit ;)
