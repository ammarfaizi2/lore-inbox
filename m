Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161384AbWHDTtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161384AbWHDTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWHDTtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:49:25 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:32997 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932609AbWHDTtY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:49:24 -0400
Date: Fri, 4 Aug 2006 12:45:50 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <44D39F73.8000803@linux.intel.com>
Message-ID: <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
   <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>  
 <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>  
 <1154667875.11382.37.camel@localhost.localdomain>   <20060803225357.e9ab5de1.akpm@osdl.org>
   <1154675100.11382.47.camel@localhost.localdomain>  
 <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> 
 <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> 
 <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz> <44D39F73.8000803@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Arjan van de Ven wrote:

> David Lang wrote:
>> I'm not commenting on any of the specifics of the interface calls (I trust 
>> you guys to make that be sane :-) I'm just responding the the idea that the 
>> interface actually needs to be locked down to an ABI as opposed to just 
>> source-level compatability.
>
> you are right that the interface to the HV should be stable. But those are 
> going
> to be specific to the HV, the paravirt_ops allows the kernel to smoothly deal
> with having different HV's.
> So in a way it's an API interface to allow the kernel to deal with multiple
> different ABIs that exist today and will in the future.

so if I understand this correctly we are saying that a kernel compiled to run on 
hypervisor A would need to be recompiled to run on hypervisor B, and recompiled 
again to run on hypervisor C, etc

where A could be bare hardware, B could be Xen 2, C could be Xen 3, D could be 
vmware, E could be vanilla Linux, etc.

this sounds like something that the distros would not support, they would pick 
their one hypervisor to support and leave out the others. the big problem with 
this is that the preferred hypervisor will change over time and people will be 
left with incompatable choices (or having to compile their own kernels, 
including having to recompile older kernels to support newer hypervisors)

David Lang


