Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274209AbRIXWRi>; Mon, 24 Sep 2001 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274206AbRIXWR2>; Mon, 24 Sep 2001 18:17:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:23271 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274210AbRIXWRS>; Mon, 24 Sep 2001 18:17:18 -0400
Message-ID: <3BAFB108.22D81127@redhat.com>
Date: Mon, 24 Sep 2001 18:17:44 -0400
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Preliminary testing results for 2.4.10
In-Reply-To: <mailman.1000842780.25404.linux-kernel2news@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> Hi.
> 
> In the Red Hat testlab, Bob Matthews has run the stress-test part of our
> normal "release signoff tests" on 2.4.10pre11 to evaluate the new VM for
> stability.

I've just finished a quick test cycle with 2.4.10.  Here are the results
we observed:

There are two tests running, both with HIMEM set to 64G.  

machine test1:  2xPIII, 2G RAM/4G Swap.  Appears to be in a memory
related deadlock.  All test related processes save one are in D state. 
Vmstat indicates no swapping activity.  Top says both processors are
~95% idle.  The exception is the TTCP test, which has a very small
memory footprint and is running normally.

machine test4:  4xPIII, 1G/2G.  Appears to be running normally, but top
indicates frequent stalls with CPU idle times shooting up to 90% on all
processors for brief, but recurring periods.

No processes have been killed by OOM at this point.
-- 
Bob Matthews
Red Hat, Inc.
