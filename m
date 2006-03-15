Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCOSL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCOSL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWCOSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:11:26 -0500
Received: from fmr20.intel.com ([134.134.136.19]:15269 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751068AbWCOSLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:11:25 -0500
Date: Wed, 15 Mar 2006 10:09:29 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaohua Li <shaohua.li@intel.com>, ntl@pobox.com, ashok.raj@intel.com,
       olel@ans.pl, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com,
       rajesh.shah@intel.com, ak@muc.de, zwane@arm.linux.org.uk
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060315100928.A19557@unix-os.sc.intel.com>
References: <20060315054416.GF3205@localhost.localdomain> <1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060314233138.009414b4.akpm@osdl.org>; from akpm@osdl.org on Tue, Mar 14, 2006 at 11:31:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 11:31:38PM -0800, Andrew Morton wrote:
> >  > see:
> >  > 
> >  > Subject: i386 cpu hotplug bug - instant reboot when onlining secondary
> >  > 
> >  > http://lkml.org/lkml/2006/2/19/186
> >  Works for me. But I saw a warning.
> 
> Guys, will you please stop being so cryptic?  What worked for you?  What
> warning?  wtf is going on?  Who owns this problem, whatever it is?

Nathan's problem is different, its nothing related to this thread.

Appears that a PIII box had trouble to bring a CPU back online after it was
just offlined. Iam not able to reproduce it with the systems i have here.
I have tried a PIII box itself, and also a x86_64 system booting a i386 kernel
and all seems to work ok.

Zwane was attempting to trace Nathan's issue with some experimental patches
but dont think it went far along yet.


> >  -		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
> >  +		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
> 

It might help to post with the actual warning, so we can understand why this
fix is necessary.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
