Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVAMTuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVAMTuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVAMTrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:47:40 -0500
Received: from one.firstfloor.org ([213.235.205.2]:60099 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261442AbVAMTn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:43:58 -0500
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
Cc: sander@humilis.net, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: NUMA or not on dual Opteron
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	<200501121824.44327.rathamahata@ehouse.ru>
	<Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
	<20050113094537.GB2547@favonius> <41E6472B.5020701@imag.fr>
	<20050113170733.GA14524@linuxtx.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 Jan 2005 20:43:54 +0100
In-Reply-To: <20050113170733.GA14524@linuxtx.org> (Justin M. Forbes's
 message of "Thu, 13 Jan 2005 11:07:33 -0600")
Message-ID: <m1k6qh2jyd.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin M. Forbes" <jmforbes@linuxtx.org> writes:


> This is somewhat true.  There are 2 types of dual opteron boards. Those in
> the $200 US range only have one memory bank, which is attached to CPU0.
> They operate as a single node, and may perform better with numa turned off.
> Those in the $400+ range tend to have one bank per CPU and will certainly
> perform better with numa on.  They do usually have a bios option to
> interleave the nodes which would show up as a single node, and probably
> perform better with numa turned off, but a better solution is to turn off
> the node interleave in bios and run the kernel with numa support.
> Basically if you have 2 CPUs and only one memory bank, maybe turning numa
> off will give better performance, but if you have one memory bank per CPU
> numa should be on.

[agreed, except:]

There is no significant performance difference between NUMA on and off
on the crippled boards. So best is to always enable CONFIG_NUMA on x86-64. 
The distribution kernels for x86-64 should ship in this configuration
too.

I would recommend to always disable node interleaved on the non crippled
board with multiple memory banks. Most boards ship with this disabled by 
default, only a few enable it.

-Andi
