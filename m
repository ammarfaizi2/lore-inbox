Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUCLUbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCLU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:29:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58382
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262513AbUCLU1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:27:00 -0500
Date: Fri, 12 Mar 2004 21:27:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312202741.GG30940@dualathlon.random>
References: <40520928.4050409@nortelnetworks.com> <Pine.LNX.4.44.0403121405170.6494-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121405170.6494-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 02:06:17PM -0500, Rik van Riel wrote:
> On Fri, 12 Mar 2004, Chris Friesen wrote:
> 
> > What happens when you have more than PAGE_SIZE processes running?
> 
> Forked off the same process ?
> Without doing an exec ?
> On a 32 bit system ?
> 
> You'd probably run out of space to put the VMAs,
> mm_structs and pgds long before reaching this point ...

7.5k users are being reached in a real workload with around 2gigs mapped
per process and with tons of vma per process. with 2.6 and faster cpus
I hope to go even further.
