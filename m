Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTE0CO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTE0CO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:14:56 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:131
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262451AbTE0COz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:14:55 -0400
Date: Mon, 26 May 2003 22:15:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, "" <davem@redhat.com>, "" <andrea@suse.de>,
       "" <davidsen@tmr.com>, "" <haveblue@us.ibm.com>,
       "" <habanero@us.ibm.com>, "" <mbligh@aracnet.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: userspace irq balancer
In-Reply-To: <20030527021002.GD8978@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305262212070.2265-100000@montezuma.mastecende.com>
References: <20030527000639.GA3767@dualathlon.random>
 <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random>
 <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com>
 <20030526185920.64e9751f.akpm@digeo.com> <20030527021002.GD8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, William Lee Irwin III wrote:

> The number of interrupt sources on a system ends up scaling this up to
> numerous IO-APIC RTE reprograms and ioapic_lock acquisitions per-second
> (granted, with a 5s timeout between reprogramming storms) where it
> competes against IO-APIC interrupt acknowledgements.
> 
> Making the lock per- IO-APIC would at least put a bound on the number
> of competitors mutually interfering with each other, but a tighter
> bound on the amount of work than NR_IRQS would be more useful than that.

Ok there are 16 IOAPICs on an 8quad, but really if we start banging on 
that lock someone is doing way too much hardware access...

	Zwane
-- 
function.linuxpower.ca
