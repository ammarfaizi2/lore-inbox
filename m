Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTFKVdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFKVdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:33:03 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:58327 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264447AbTFKVdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:33:01 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
	 <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055367690.18644.69.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 14:41:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 14:36, Bryan O'Sullivan wrote:
> On Wed, 2003-06-11 at 14:23, john stultz wrote:
> 
> > Hmmm. Thats likely part to blame for the lost-ticks code not working. I
> > believe tick_usec is calculated USER_HZ rather then HZ, so you'll be off
> > by an order of magnitude. I ran into the exact same problem. 
> 
> Unlikely.  On my systems, the offset values are off by three orders of
> magnitude, and are always negative.  There's a more basic error
> somewhere before that test.

Ok, that was just the first thing I noticed. Let me dig in and see what
I can find. 


> The actual impact of lost jiffies is pretty low, though.  I've beaten
> vigorously on my systems with the time patch, and they don't lose timer
> interrupts.

Hmm. In my (very quick) testing I'm seeing very frequent 10,000us
inconsistencies. This is w/ and w/o the vsyscall code enabled, so I'm
not sure whats causing it yet. I'll let you know if I trip over
anything.

thanks
-john

