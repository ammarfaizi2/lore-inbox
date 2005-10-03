Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVJCOp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVJCOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVJCOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:45:59 -0400
Received: from dvhart.com ([64.146.134.43]:54930 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750943AbVJCOp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:45:58 -0400
Date: Mon, 03 Oct 2005 07:45:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: David Lang <david.lang@digitalinsight.com>,
       Magnus Damm <magnus.damm@gmail.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Message-ID: <77150000.1128350759@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--David Lang <david.lang@digitalinsight.com> wrote (on Monday, October 03, 2005 00:34:40 -0700):

> On Mon, 3 Oct 2005, Magnus Damm wrote:
> 
>> On 10/1/05, Dave Hansen <haveblue@us.ibm.com> wrote:
>>> On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
>>>> These patches implement NUMA memory node emulation for regular i386 PC:s.
>>>> 
>>>> NUMA emulation could be used to provide coarse-grained memory resource control
>>>> using CPUSETS. Another use is as a test environment for NUMA memory code or
>>>> CPUSETS using an i386 emulator such as QEMU.
>>> 
>>> This patch set basically allows the "NUMA depends on SMP" dependency to
>>> be removed.  I'm not sure this is the right approach.  There will likely
>>> never be a real-world NUMA system without SMP.  So, this set would seem
>>> to include some increased (#ifdef) complexity for supporting SMP && !
>>> NUMA, which will likely never happen in the real world.
>> 
>> Yes, this patch set removes "NUMA depends on SMP". It also adds some
>> simple NUMA emulation code too, but I am sure you are aware of that!
>> =)
>> 
>> I agree that it is very unlikely to find a single-processor NUMA
>> system in the real world. So yes, "[PATCH 02/07] i386: numa on
>> non-smp" adds _some_ extra complexity. But because SMP is set when
>> supporting more than one cpu, and NUMA is set when supporting more
>> than one memory node, I see no reason why they should be dependent on
>> each other. Except that they depend on each other today and breaking
>> them loose will increase complexity a bit.
> 
> hmm, observation from the peanut gallery, would it make sene to look at 
> useing the NUMA code on single proc machines that use PAE to access 
> more then 4G or ram on a 32 bit system?

2 problems:

1) there aren't any ;-)
2) The memory is not physically differently separated from the CPUs, so
it's not NUMA.

M.

