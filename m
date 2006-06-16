Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWFPMsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWFPMsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWFPMsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:48:50 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29662 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751390AbWFPMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:48:49 -0400
Message-ID: <4492A8A1.5000101@bull.net>
Date: Fri, 16 Jun 2006 14:48:33 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de> <44928FB1.5070107@sgi.com> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com> <4492A5E4.9050702@bull.net> <4492A6E6.3090805@sgi.com>
In-Reply-To: <4492A6E6.3090805@sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 14:52:31,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 14:52:32,
	Serialize complete at 16/06/2006 14:52:32
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Zoltan Menyhart wrote:
> 
>>Just to make sure I understand it correctly...
>>Assuming I have allocated per CPU data (numa control, etc.) pointed at by:
> 
> 
> I think you misunderstood - vgetcpu is for userland usage, not within
> the kernel.
> 
> Cheers,
> Jes
> 
I did understand it as a user land stuff.
This is why I want to map the current task structure into the user space.
In user code, we could see the actual value of the "current->thread_info.cpu".
My "#define current ((struct task_struct *) 0x...)" is not the same as
the kernel's one.

Thanks,

Zoltan
