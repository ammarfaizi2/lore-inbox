Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVBHWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVBHWSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBHWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:18:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5773 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261589AbVBHWRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:17:40 -0500
Message-ID: <42093A7D.7020605@us.ibm.com>
Date: Tue, 08 Feb 2005 14:17:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Paul Jackson <pj@sgi.com>, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       LSE Tech <lse-tech@lists.sourceforge.net>, hch@infradead.org,
       steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]>	 <200408061730.06175.efocht@hpce.nec.com>	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>	<20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>	 <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <44870000.1107879300@[10.10.2.4]>
In-Reply-To: <44870000.1107879300@[10.10.2.4]>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Sorry to reply a long quiet thread, but I've been trading emails with 
>>Paul Jackson on this subject recently, and I've been unable to convince 
>>either him or myself that merging CPUSETs and CKRM is as easy as I once 
>>believed.  I'm still convinced the CPU side is doable, but I haven't 
>>managed as much success with the memory binding side of CPUSETs.  
> 
> 
> Can you describe what the difficulty is with the mem binding side?

Well, basically we need to ensure that when CPUSETs are marked "mems_exclusive" 
that no one else in the system is allowed to allocate from those "exclusive" 
nodes.  This can't be guaranteed without hooks in the allocation code much like 
what Paul has already written in his CPUSETs patchset.

> Thanks,
> 
> M.
> 
> PS. If you could also make your mailer line-wrap, that'd be splendid ;-)

I believe my mailer is line-wrapping correctly, but it's hard to be sure 
without feedback.  I switched to Thunderbird last week, and I think I've 
(un)checked all the appropriate boxes.  And yes, line wrapping is splendid. 
Splendiferous, even.

-Matt
