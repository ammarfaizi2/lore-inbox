Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWBXWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWBXWVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWBXWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:21:42 -0500
Received: from fmr19.intel.com ([134.134.136.18]:18315 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932612AbWBXWVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:21:42 -0500
Message-ID: <43FF86DC.3020306@linux.intel.com>
Date: Fri, 24 Feb 2006 23:21:16 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Tony Luck <tony.luck@gmail.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>	 <1140707358.4672.67.camel@laptopd505.fenrus.org> <12c511ca0602241419j312540b4ifb11dc1fa5f2247b@mail.gmail.com>
In-Reply-To: <12c511ca0602241419j312540b4ifb11dc1fa5f2247b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck wrote:
> On 2/23/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
>> As per previous discussions, Linus said he wanted a "static" list for this,
>> eg a list provided by the kernel tarbal, so that most people have the same
>> ordering at least. A script is provided to create this list based on
>> readprofile(1) output. The included list is provisional, and entirely biased
>> on my own testbox and me running a few kernel compiles and some other
>> things.
>>
>> I think that to get to a better list we need to invite people to submit
>> their own profiles, and somehow add those all up and base the final list on
>> that.
> 
> 1) How will this work in the face of CONFIG options that change the
> list of symbols present in your kernel?  E.g. my hot oprofile list
> might well contain a bunch of symbols from my NIC driver and whatever
> filesystem I'm pounding on.

that is fine; symbols that aren't actually present just are ignored by 
the linker in this case

>
> 2) If you add enough lists from enough people, perhaps you'll get enough
> coverage of the kernel with all their different workloads, that you'll have
> too much to fit into the 2M page.

I am more optimistic; the total kernel size in "distro" configuration is 
about 3.5Mb. I would find it hard to believe that more than half of that 
is "hot" code even in a "many people send their profiles" setup.

