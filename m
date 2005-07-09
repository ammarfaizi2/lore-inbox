Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVGIP3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVGIP3C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVGIP3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 11:29:01 -0400
Received: from opersys.com ([64.40.108.71]:51468 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261517AbVGIP3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 11:29:00 -0400
Message-ID: <42CFEFC9.7070007@opersys.com>
Date: Sat, 09 Jul 2005 11:39:53 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
References: <42CF05BE.3070908@opersys.com> <20050709071911.GB31100@elte.hu>
In-Reply-To: <20050709071911.GB31100@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> yeah, they definitely have helped, and thanks for this round of testing 
> too! I'll explain the recent changes to PREEMPT_RT that resulted in 
> these speedups in another mail.

Great, I'm very much looking forward to it.

> Looking at your numbers i realized that the area where PREEMPT_RT is 
> still somewhat behind (the flood ping +~10% overhead), you might be 
> using an invalid test methodology:

I've got to smile reading this :) If one thing became clear out of
these threads is that no matter how careful we are with our testing,
there is always something that can be criticized about them.

Take the highmem thing, for example, I never really bought the
argument that highmem was the root of all evil ;) , and the last
comparison we did between 50-35 and 51-02 with and without highmem
clearly showed that indeed while highmem is a factor, there are
inherent problems elsewhere than the disabling of highmem doesn't
erase. Also, both vanilla and I-pipe were run with highmem, and if
they don't suffer from it, then the problem is/was with PREEMPT_RT.

With ping floods, as with other things, there is room for
improvement, but keep in mind that these are standard tests used
as-is by others to make measurements, that each run is made 5
times, and that the values in those tables represent the average
of 5 runs. So while they may not be as exact as could be, I don't
see why they couldn't be interpreted as giving us a "good idea" of
what's happening.

For one thing, the heavy fluctuation in ping packets may actually
induce a state in the monitored kernel which is more akin to the
one we want to measure than if we had a steady flow of packets.

I would usually like very much to entertain this further, but we've
really busted all the time slots I had allocated to this work. So at
this time, we really think others should start publishing results.
After all, our results are no more authoritative than those
published by others.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
