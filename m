Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUCDSQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUCDSQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:16:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13067
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262061AbUCDSQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:16:16 -0500
Date: Thu, 4 Mar 2004 19:16:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040304181657.GS4922@dualathlon.random>
References: <20040303200704.17d81bda.akpm@osdl.org> <132310000.1078421713@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132310000.1078421713@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 09:35:13AM -0800, Martin J. Bligh wrote:
> designed for bigboxen, so 4/4 vs 2/2 would be better, IMHO. People have
> said before that DB performance can increase linearly with shared area
> sizes (for some workloads), so that'd bring you a 100% or so increase
> in performance for 4/4 to counter the loss.

that's a nice theory with the benchmarks that runs with a 64G working
set, but if your working set is smaller than 32G  99% of the time and
you install the 64G to handle the peak load happening 1% of the time
faster, you'll run 30% slower 99% of the time even if the benchmark
only stressing the 64G working set runs a lot faster than with 32G only.
