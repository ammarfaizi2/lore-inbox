Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264945AbTLFFJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLFFJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:09:18 -0500
Received: from holomorphy.com ([199.26.172.102]:60373 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264945AbTLFFJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:09:17 -0500
Date: Fri, 5 Dec 2003 21:09:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stian Jordet <liste@jordet.nu>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206050908.GL8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stian Jordet <liste@jordet.nu>,
	Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
	linux-kernel@vger.kernel.org
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au> <20031206030755.GI8039@holomorphy.com> <1070684918.7934.2.camel@chevrolet.hybel> <20031206043757.GJ8039@holomorphy.com> <1070686126.1166.0.camel@chevrolet.hybel> <20031206045409.GK8039@holomorphy.com> <1070686634.1166.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070686634.1166.3.camel@chevrolet.hybel>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

l?r, 06.12.2003 kl. 05.54 skrev William Lee Irwin III:
>> Okay, irqbalance has gaffed (as predicted). Could you send in
>> /proc/cpuinfo and /var/log/dmesg?

On Sat, Dec 06, 2003 at 05:57:14AM +0100, Stian Jordet wrote:
> Here they are. Thanks for looking into this :)

This tells me you're not being mistaken for HT.

It also suggests it's the policy not doing what you want it to. If your
interrupt rate isn't high (according to what metric I have no idea;
presumably it should depend on the expense of handling it, which is
driver-dependent but about which the code has no knowledge), it won't
rebalance the irq's.

If you actually manage to get interrupt rates exceeding its thresholds,
you should see interrupts migrated, but only dynamically and on-demand,
not under light usage.

There might still be something wrong with it, but we'd have to dig deeper.


-- wli
