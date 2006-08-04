Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWHDUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWHDUjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbWHDUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:39:06 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:13472 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161292AbWHDUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:39:05 -0400
Date: Fri, 4 Aug 2006 13:31:47 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Arjan van de Ven <arjan@linux.intel.com>,
       Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com
Subject: Re: A proposal - binary
In-Reply-To: <44D3A9F3.2000000@goop.org>
Message-ID: <Pine.LNX.4.63.0608041325280.18862@qynat.qvtvafvgr.pbz>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
    <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>   
 <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>  
  <1154667875.11382.37.camel@localhost.localdomain>    <20060803225357.e9ab5de1.akpm@osdl.org>
    <1154675100.11382.47.camel@localhost.localdomain>   
 <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>  
 <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>  
 <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>  <44D39F73.8000803@linux.intel.com>
  <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz> <44D3A9F3.2000000@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Jeremy Fitzhardinge wrote:

>> so if I understand this correctly we are saying that a kernel compiled to 
>> run on hypervisor A would need to be recompiled to run on hypervisor B, and 
>> recompiled again to run on hypervisor C, etc
>> 
>> where A could be bare hardware, B could be Xen 2, C could be Xen 3, D could 
>> be vmware, E could be vanilla Linux, etc.
>
> Yes, but you can compile one kernel for any set of hypervisors, so if you 
> want both Xen and VMI, then compile both in.  (You always get bare hardware 
> support.)

how can I compile in support for Xen4 on my 2.6.18 kernel? after all xen 2 and 
xen3 are incompatable hypervisors so why wouldn't xen4 (and I realize there is 
no xen4 yet, but there is likly to be one during the time virtual servers 
created with 2.6.18 are still running)

>> this sounds like something that the distros would not support, they would 
>> pick their one hypervisor to support and leave out the others. the big 
>> problem with this is that the preferred hypervisor will change over time 
>> and people will be left with incompatable choices (or having to compile 
>> their own kernels, including having to recompile older kernels to support 
>> newer hypervisors)
>
> Why?  That's like saying that distros will only bother to compile in one scsi 
> driver.
>
> The hypervisor driver is tricker than a normal kernel device driver, because 
> in general it needs to be present from very early in boot, which precludes it 
> from being a normal module.  There's hope that we'll be able to support 
> hypervisor drivers as boot-time grub/multiboot modules, so you'll be able to 
> compile up a new hypervisor driver for a particular kernel and use it without 
> recompiling the whole thing.

distros don't offer kernels with all options today, why would they in the future 
(how many distros offer seperate 486/586/K6/K7/Pentium/P2/P3/P4 kernels, none. 
they offer a least-common denominator kernel or two instead)

I also am missing something here. how can a system be compiled to do several 
different things for the same privilaged opcode (including running that opcode) 
without turning that area of code into a performance pig as it checks for each 
possible hypervisor being present?

David Lang
