Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUCTQSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUCTQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:18:17 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50901
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263460AbUCTQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:18:14 -0500
Date: Sat, 20 Mar 2004 17:19:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320161905.GT9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2696050000.1079798196@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 07:56:37AM -0800, Martin J. Bligh wrote:
> > I'm working on my code yes, I think my code is finished, I prefer my
> > design for the various reasons explained in the other emails (you don't
> > swap so you can't appreciate the benefits, you only have to check that
> > performs as well as Hugh's code).
> > 
> > Hugh's and your code is unstable in objrmap, you can find the details in
> > the email I sent to Hugh, mine is stable (running such simulation for a
> > few days just fine on 4-way xeon, without my objrmap fixes it live locks
> > as soon as it hits swap).
> > 
> > You find my anon_vma in 2.6.5-rc1aa2, it's rock solid, just apply the
> > whole patch and compare it with your other below results. thanks.
> 
> Mmmm, if you have a broken out patch, it'd be preferable. If I were to 
> apply the whole of -mjb, I'll get a damned sight better results than 
> any of them, but that's not really a fair comparison ;-) I'll can at 
> least check it's stable for me that way though. 
> 
> I did find your broken-out anon-vma patch, but it's against something
> else, maybe half-way up your tree or something, and I didn't bother
> trying to fix it ;-)

this one is against mainline, but you must use my objrmap patch too
which is fixed so it doesn't crash in 2.6.5-rc1.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00100_objrmap-core-1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00101_anon_vma-2.gz

just backout your objrmap and apply the above two, it should apply
pretty well.
