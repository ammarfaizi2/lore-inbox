Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVJCHfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVJCHfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVJCHfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:35:20 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:34504 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932173AbVJCHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:35:19 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Mon, 3 Oct 2005 00:34:40 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
In-Reply-To: <aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz>
References: <20050930073232.10631.63786.sendpatchset@cherry.local><1128093825.6145.26.camel@localhost>
 <aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Magnus Damm wrote:

> On 10/1/05, Dave Hansen <haveblue@us.ibm.com> wrote:
>> On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
>>> These patches implement NUMA memory node emulation for regular i386 PC:s.
>>>
>>> NUMA emulation could be used to provide coarse-grained memory resource control
>>> using CPUSETS. Another use is as a test environment for NUMA memory code or
>>> CPUSETS using an i386 emulator such as QEMU.
>>
>> This patch set basically allows the "NUMA depends on SMP" dependency to
>> be removed.  I'm not sure this is the right approach.  There will likely
>> never be a real-world NUMA system without SMP.  So, this set would seem
>> to include some increased (#ifdef) complexity for supporting SMP && !
>> NUMA, which will likely never happen in the real world.
>
> Yes, this patch set removes "NUMA depends on SMP". It also adds some
> simple NUMA emulation code too, but I am sure you are aware of that!
> =)
>
> I agree that it is very unlikely to find a single-processor NUMA
> system in the real world. So yes, "[PATCH 02/07] i386: numa on
> non-smp" adds _some_ extra complexity. But because SMP is set when
> supporting more than one cpu, and NUMA is set when supporting more
> than one memory node, I see no reason why they should be dependent on
> each other. Except that they depend on each other today and breaking
> them loose will increase complexity a bit.

hmm, observation from the peanut gallery, would it make sene to look at 
useing the NUMA code on single proc machines that use PAE to access more 
then 4G or ram on a 32 bit system?

David Lang
