Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUFYDMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUFYDMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 23:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266190AbUFYDMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 23:12:38 -0400
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:17373 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S266187AbUFYDL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 23:11:58 -0400
Date: Thu, 24 Jun 2004 20:11:37 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory hotplug
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <1088116621.3918.1060.camel@nighthawk>
References: <20040624135838.F009.YGOTO@us.fujitsu.com> <1088116621.3918.1060.camel@nighthawk>
Message-Id: <20040624194557.F02B.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand this idea at last.
Section size of DLPAR of PPC is only 16MB.
But kmalloc area of virtual address have to be contigous 
even if the area is divided 16MB physically.
Dave-san's implementation (it was for IA32) was same index between 
phys_section and mem_section. So, I was confused.

> pfn_to_page(unsigned long pfn)
> {
>        return
> &mem_section[phys_section[pfn_to_section(pfn)]].mem_map[section_offset_pfn(pfn)];
> }
> 

But, I suppose this translation might be too complex.
I worry that many person don't like this which is cause of
performance deterioration.
Should this translation be in common code?

Bye.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


