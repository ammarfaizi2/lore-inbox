Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUHECA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUHECA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUHECAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:00:50 -0400
Received: from holomorphy.com ([207.189.100.168]:15296 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261685AbUHECAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:00:49 -0400
Date: Wed, 4 Aug 2004 19:00:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040805020041.GQ2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com> <41104C8F.9080603@bigpond.net.au> <20040804074440.GL2334@holomorphy.com> <4111882B.9090504@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4111882B.9090504@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Software constructs are less of a concern. This also presumes that
>> taking timer interrupts when cpu-intensive workloads voluntarily
>> yield often enough is necessary or desirable.

On Thu, Aug 05, 2004 at 11:06:51AM +1000, Peter Williams wrote:
> Voluntary yielding can't be relied upon.  Writing a program that never 
> gives up the CPU voluntarily is trivial.  Some have been known to do it 
> without even trying :-)

No reliance is implied. In such a scenario, the timers for timeslice
expiry are always cancelled because userspace voluntarily yields first,
so no timer interrupts are delivered. Should userspace fail to do so,
timer interrupts programmed for timeslice expiry would not be cancelled.


-- wli
