Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVBHJu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVBHJu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVBHJu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:50:56 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:63604 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261501AbVBHJt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:49:57 -0500
Message-ID: <42088B3E.7050701@yahoo.com.au>
Date: Tue, 08 Feb 2005 20:49:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Matthew Dobson <colpatch@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <20050208095440.GA3976@in.ibm.com>
In-Reply-To: <20050208095440.GA3976@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> On Mon, Feb 07, 2005 at 03:59:49PM -0800, Matthew Dobson wrote:
> 
> 
>>Sorry to reply a long quiet thread, but I've been trading emails with Paul 
>>Jackson on this subject recently, and I've been unable to convince either 
>>him or myself that merging CPUSETs and CKRM is as easy as I once believed.  
>>I'm still convinced the CPU side is doable, but I haven't managed as much 
>>success with the memory binding side of CPUSETs.  In light of this, I'd 
>>like to remove my previous objections to CPUSETs moving forward.  If others 
>>still have things they want discussed before CPUSETs moves into mainline, 
>>that's fine, but it seems to me that CPUSETs offer legitimate functionality 
>>and that the code has certainly "done its time" in -mm to convince me it's 
>>stable and usable.
>>
>>-Matt
>>
> 
> 
> What about your proposed sched domain changes?
> Cant sched domains be used handle the CPU groupings and the
> existing code in cpusets that handle memory continue as is?
> Weren't sched somains supposed to give the scheduler better knowledge
> of the CPU groupings afterall ?
> 

sched domains can provide non overlapping top level partitions.
It would basically just stop the multiprocessor balancing from
moving tasks between these partitions (they would be manually
moved by setting explicit cpu affinities).

I didn't really follow where that idea went, but I think at least
a few people thought that sort of functionality wasn't nearly
fancy enough! :)

