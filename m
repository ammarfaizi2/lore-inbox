Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUIPMTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUIPMTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUIPMTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:19:38 -0400
Received: from holomorphy.com ([207.189.100.168]:63907 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268026AbUIPMSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:18:47 -0400
Date: Thu, 16 Sep 2004 05:17:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040916121747.GQ9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <20040916114515.GP9106@holomorphy.com> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> As for all syscalls/etc. being slower by 50%-100%, I suggest toning

On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> s/all/many/:
> uname <0.000142> ? ? ? ? ? ? ? uname <0.000217>		25% slower
> brk <0.000176> ? ? ? ? ? ? ? ? brk <0.000174>		no change
> open <0.000218> ? ? ? ? ? ? ? ?open <0.000335>		33% slower
> fstat64 <0.000104> ? ? ? ? ? ? fstat64 <0.000191>	90% slower
> or maybe strace simply isn't very accurate and adds signinficant
> noise to the measured delta?

Could you try to estimate the resolution of whatever timer strace uses?

At some point in the past, I wrote:
>> down HZ (we desperately need to go tickless) and seeing if it persists.
>> Also please check that time isn't twice as fast as it should be in 2.6.

On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> I recompiled 2.6 with HZ=100. It's not it.
> Time is running normally too.

Did the kallsyms patches reduce the cpu overhead from get_wchan()? I take
this to mean reducing HZ to 100 did not alleviate the syscall problems?
How do microbenchmarks fare, e.g. lmbench?


-- wli
