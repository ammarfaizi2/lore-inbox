Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUHJNNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUHJNNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUHJNKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:10:55 -0400
Received: from holomorphy.com ([207.189.100.168]:18921 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265040AbUHJNK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:10:27 -0400
Date: Tue, 10 Aug 2004 06:10:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: V13 <v13@priest.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810131010.GW11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, V13 <v13@priest.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu> <20040810125651.GV11200@holomorphy.com> <20040810130122.GA26326@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810130122.GA26326@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> This is serial port IO; would that make the same kind of difference?

On Tue, Aug 10, 2004 at 03:01:22PM +0200, Ingo Molnar wrote:
> serial port IO is even more heavy, it also generates IRQ traffic. I'd
> suggest the following tests: modified kernel without serial console, and
> original kernel without serial console. This way you can find out 
> whether the hang itself is triggered by the serial console.
> another attack angle is to find out what state the system has during the
> hang. Is it debuggable?

I can get a very small amount of register state out of POD but most of
it is clobbered by trapping with the NMI/MCA I send from the L2 to get
into the POD (Prom Only Debugger), and it's not entirely clear what may
have been clobbered in this process. The state I can extract from this
is very difficult to interpret. It's unclear how well the consolidated
L2 console (a.k.a.  firmware console) and machine console interoperate
with e.g. kgdb and the like. I might as well try that, too.

It's unclear how much of the progress I can track without the serial
console as there are no other output devices besides the serial console.
I'll try it anyway, since the worst that can happen is a boot where it
crashes.


-- wli
