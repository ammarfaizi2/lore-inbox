Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWJDPT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWJDPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWJDPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:19:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33228 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161231AbWJDPT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:19:26 -0400
Message-ID: <4523D0DC.6070704@zytor.com>
Date: Wed, 04 Oct 2006 08:18:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, horms@verge.net.au, lace@jankratochvil.net,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 2/12] i386: align data section to 4K boundary
References: <20061003170032.GA30036@in.ibm.com> <20061003170628.GB3164@in.ibm.com> <200610041317.12132.ak@suse.de>
In-Reply-To: <200610041317.12132.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 03 October 2006 19:06, Vivek Goyal wrote:
>> o Currently there is no specific alignment restriction in linker script
>>   and in some cases it can be placed non 4K aligned addresses. This fails
>>   kexec which checks that segment to be loaded is page aligned.
>>
>> o I guess, it does not harm data segment to be 4K aligned.
> 
> iirc P4 optimization guide even recommends to keep writable data 
> away one page from code to avoid some cache invalidations. But:
> 

Yes, that's why the .rodata section should be in between.

It's not just the P4, either.

	-hpa
