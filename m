Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTLDBTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTLDBTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:19:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18409 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262960AbTLDBTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:19:44 -0500
Date: Wed, 03 Dec 2003 17:20:29 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Minutes from OSDL talk at LSE call today
Message-ID: <189470000.1070500829@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LSE Call minutes from Dec 3, 2003

	Zwane Mwaikambo - OSDL experiences

Generally working with the OSDL has been great.

In order to use the OSDL machines you have to sign up to be an associate
and register a project. Then wait for OSDL to review it. Zwane just wanted
a large marchine to work on the irq subsystem. He needed access to the
NUMA-Q machines to test for regressions.

Most of his interactions have been with Christine who is fairly responsive
to email and has fixed the few problems that have popped up.

Zwane has had some trouble using the PLM (Patch Lifetime Manager). Cliff
is going to talk to him about using it. Zwane has been doing something 
similar manually. 

The STP enables the engineer to save time by not having to wait inbetween
each step. It automates much of the testing process.

Marcelo Tosatti - Also uses the OSDL machines. He said it has been very easy to
use. They are the only high mem systems he has available now. He uses
them to stress test stuff and sometimes test 2.6 on it.

Zwane said he likes the cross compilation capabilities recently added.
Cliff said that was a direct result of comments from OLS this year.

Zwane said one downside of STP and Tinderbox is the huge amount of 
data that comes out of it and it is hard to parse. He would prefer more
minimal info saying if the kernel booted or not and the some of the
errors. Cliff told him to try HackBench the most minimal of tests 
the STP runs.

The turn around time from patch submission to results on an idle system
is 1.5 hours. Due to the reimaging of the entire system between runs.
Cliff is going to look into making that faster.

Bill Irwin suggested using nfs for the root partition then the host
system can feed it nfs and could cleanup and check using md5checksums
which would be much faster than reimaging. Cliff said most users wont
use nfs on root and it may effect the benchmark results. Bill said
most benchmarks arent run on root anyway. Cliff said it is a good
idea and worth looking into.

	Cliff White - Kernel Tinderbox

History- Came from Brazil. Christian Reis of Asynch Open Source who worked
on the Mozilla Tinderbox asked Marcelo about doing a Kernel Tinderbox. 
Marcelo told Christian to go talk to the OSDL people and the rest is
history.

The Mozilla Tinderbox is based on CVS and can do fancy things with
triggers. The kernel one is not as fancy because they are still
working out issues with BK.

Basically, the client runs in a loop and every 15 minutes wakes up and
checks bkbits. If there are any changes within thos 15 minutes the
new kernel is downloaded and compiled with John Cherry's comp regress
script, which is exhaustive. The best way to see the results is to
go to http://developer.osdl.org and click on the tinderbox link.
or here (http://tinderbox.osdl.org/showbuilds.pl?tree=linux2.5-bk)

Intel has contributed a 32 and 64 bit client. OSDL is looking to get
other architectures added to it (hint hint nudge nudge, especially
Power right now).

Marcelo asked if it also boots the kernel. Cliff, no it just compiles
at this point. Working on a client that will boot but the STP is
best for booting an unknown kernel generally. Cliff is looking at
using STP as a client of Tinderbox.

They are not doing mm or other trees as they only work off bkbits
right now.

Cliff asked if anyone has Power hardware they could really use one.
It doesnt have to be onsite, just need access to a machine. Zwane
said they could use cross compilation to test Power stuff instead
since they dont boot.

If anyone has a desire to tweak the client is available off Cliffs
page on osdl: http://developer.osdl.org/cliffw/

------

minutes compiled by hannal@us.ibm.com
 

