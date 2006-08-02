Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWHBG0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWHBG0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWHBG0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:26:01 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:13792 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751267AbWHBG0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:26:00 -0400
Message-ID: <44D04577.9000904@vmware.com>
Date: Tue, 01 Aug 2006 23:25:59 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [Xen-devel] Re: [PATCH 12 of 13] Pass the mm struct into the
 pgd_free code so the mm is available here
References: <8235caea9d688b78ce4b.1154462450@ezr> <200608020514.52316.ak@suse.de>
In-Reply-To: <200608020514.52316.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> nst char *arch_vma_name(struct vm_area_struct *vma);
>   
>>  
>> +#ifndef pgd_free_mm
>> +#define pgd_free_mm(mm) pgd_free((mm)->pgd)
>> +#endif
>>     
>
> Sorry, but these ifdefs are too ugly. I would prefer if you 
> just updated all architectures, even though it will make the patch
> somewhat bigger
>   
I'm fine with doing that, and yes this is ugly.  Will take awhile though 
- for efficiency of mercurial patch tools, I deprecated all 
architectures but i386, x86_64, and um from my local tree.  <Slaps head>.

Zach
