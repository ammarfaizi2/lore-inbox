Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbTLFEyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTLFEyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:54:20 -0500
Received: from holomorphy.com ([199.26.172.102]:56789 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264954AbTLFEyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:54:19 -0500
Date: Fri, 5 Dec 2003 20:54:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stian Jordet <liste@jordet.nu>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206045409.GK8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stian Jordet <liste@jordet.nu>,
	Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
	linux-kernel@vger.kernel.org
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au> <20031206030755.GI8039@holomorphy.com> <1070684918.7934.2.camel@chevrolet.hybel> <20031206043757.GJ8039@holomorphy.com> <1070686126.1166.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070686126.1166.0.camel@chevrolet.hybel>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

l?r, 06.12.2003 kl. 05.37 skrev William Lee Irwin III:
>> Yeah, it looks like it hit you too.
>> Could you boot with noirqbalance on the kernel commandline and see if
>> the problem goes away?

On Sat, Dec 06, 2003 at 05:48:46AM +0100, Stian Jordet wrote:
> Wow, that actually fixed it :)
>            CPU0       CPU1
>   0:      65636      63667    IO-APIC-edge  timer
>   1:        150        136    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:          2          1    IO-APIC-edge  serial
>   8:          3          1    IO-APIC-edge  rtc
>   9:          0          0   IO-APIC-level  acpi
>  14:         18         37    IO-APIC-edge  ide0

Okay, irqbalance has gaffed (as predicted). Could you send in
/proc/cpuinfo and /var/log/dmesg?


-- wli
