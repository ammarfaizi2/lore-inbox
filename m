Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVJNVVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVJNVVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVJNVVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:21:43 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:29617 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750790AbVJNVVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:21:42 -0400
Subject: 2.6.14-rc4-rt5
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
From: John Rigg <lk@sound-man.co.uk>
Message-Id: <E1EQX5p-0001QE-RS@localhost.localdomain>
Date: Fri, 14 Oct 2005 22:27:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri October 14 Ingo Molnar wrote:
>-rt5 should fix that build problem.

Yes 2.6.14-rc4-rt5 compiles and runs on x86_64 smp with latency tracing
enabled :-)
I enabled DEBUG_STACKOVERFLOW too to see what was happening during boot.
Boot messages are so verbose (>100kB) they had to be captured with
serial console. Here's a snip showing the last stack size measurement:

----------------------------->
| new stack-footprint maximum: hotplug/875, 4784 bytes (out of 8112 bytes).
------------|

There are also a *lot* of chunks of output ending with lines like these:

<snip>
{  128} [<ffffffff80178213>] do_no_page+0x443/0x730
{  112} [<ffffffff8017a070>] __handle_mm_fault+0x1a0/0x540
{  272} [<ffffffff802d72cd>] do_page_fault+0x4dd/0x89c
{=3352} [<ffffffff8010ef11>] error_exit+0x0/0x81
<---------------------------
</snip>

Don't know if that's normal. I can send you the full boot message
if required.

John
