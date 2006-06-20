Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWFTIuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWFTIuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWFTIuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:50:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63175 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965211AbWFTIuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:50:51 -0400
Message-ID: <4497B6E6.9050605@garzik.org>
Date: Tue, 20 Jun 2006 04:50:46 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git build breakage
References: <4497A871.8000303@garzik.org> <20060620011738.d72147a8.akpm@osdl.org> <200606201037.05610.ak@suse.de>
In-Reply-To: <200606201037.05610.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 20 June 2006 10:17, Andrew Morton wrote:
>> On Tue, 20 Jun 2006 03:49:05 -0400
>> Jeff Garzik <jeff@garzik.org> wrote:
>>
>>> On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
>>> following build breakage:
>>>
>>> 1) myri10ge: needs iowrite64_copy from -mm
>> Patch has been sent.
>>
>>> 2) forcedeth: git tree conflict, Herbert sent a patch
>>>
>>> 3) pci-gart (ouch!) link: no fix seen yet
>>>
>>> [...]
>>>    LD      init/built-in.o
>>>    LD      .tmp_vmlinux1
>>> arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
>>> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
>>> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
>>> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'
>>> make: *** [.tmp_vmlinux1] Error 1
>> hm.  I could swear we fixed that multiple times, but I don't seem to be
>> able to locate the patch.
>>
>> This one, perhaps?
> 
> Is it new anyways? I don't think either me nor Dave changed anything 
> in this area yet post .17

'make allyesconfig' works on x86-64 in 2.6.17, yes.

	Jeff



