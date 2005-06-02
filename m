Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFBXU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFBXU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFBXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:20:56 -0400
Received: from fmr24.intel.com ([143.183.121.16]:45513 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261160AbVFBXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:20:46 -0400
Date: Thu, 2 Jun 2005 16:19:38 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 1/5] x86_64: Change init sections for CPU hotplug support
Message-ID: <20050602161938.B16913@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.694382000@araj-em64t> <Pine.LNX.4.61.0506021413330.3157@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0506021413330.3157@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Thu, Jun 02, 2005 at 02:14:28PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 02:14:28PM -0600, Zwane Mwaikambo wrote:
> On Thu, 2 Jun 2005, Ashok Raj wrote:
> 
> > This patch adds __cpuinit and __cpuinitdata sections that need to exist
> > past boot to support cpu hotplug.
> > 
> > Caveat: This is done *only* for EM64T CPU Hotplug support, on request from
> > Andi Kleen. Much of the generic hotplug code in kernel, and none of the 
> > other archs that support CPU hotplug today, i386, ia64, ppc64, s390 and
> > parisc dont mark sections with __cpuinit, but only mark them as __devinit, 
> > and __devinitdata.
> > 
> > If someone is motivated to change generic code, we need to make sure all
> > existing hotplug code does not break, on other arch's that dont use 
> > __cpuinit, and __cpudevinit.
> 
> I'll do i386.
> 

The generic kernel pieces also need to be converted, which is probably the 
bigger chunk of code that could have been marked __cpuinit in cases where
hotplug is not supported.

I can do the ia64 pieces...

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
