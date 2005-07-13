Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVGMVd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVGMVd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGMVbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:31:10 -0400
Received: from dvhart.com ([64.146.134.43]:58038 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262351AbVGMV3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:29:07 -0400
Date: Wed, 13 Jul 2005 14:29:02 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <368700000.1121290141@flay>
In-Reply-To: <20050713211650.GA12127@taniwha.stupidest.org>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Len Brown, a year ago: "The bottom line number to laptop users is
>> battery lifetime.  Just today somebody complained to me that Windows
>> gets twice the battery life that Linux does."
> 
> It seems the motivation for lower HZ is really:
> 
>    (1) ACPI/SMM suckage in laptops
> 
>    (2) NUMA systems with *horrible* remote memory latencies

It makes a difference on more normal SMP systems as well, just not as
much. See earlier in the thread. The NUMA system I used as an example
was actually a newer one with something like a 4:1 ratio, not an older
one with 20:1 or so. I have a feeling it's more to do with the number
of procs and the scheduler being invoked more than it is really to do
with NUMA ratios.
 
It seems people are agreed we want sub-HZ timers, and eventually go
to tickless ... the question is more what to do in the meantime.

M.

