Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWHACfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWHACfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWHACfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:35:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13026 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030395AbWHACfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:35:19 -0400
Message-ID: <44CEBDD1.10302@zytor.com>
Date: Mon, 31 Jul 2006 19:34:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com>	<20060706081520.GB28225@host0.dyn.jankratochvil.net>	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>	<20060707133518.GA15810@in.ibm.com>	<20060707143519.GB13097@host0.dyn.jankratochvil.net>	<20060710233219.GF16215@in.ibm.com>	<20060711010815.GB1021@host0.dyn.jankratochvil.net>	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>	<20060731202520.GB11790@in.ibm.com>	<20060731210050.GC11790@in.ibm.com> <m18xm9425s.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xm9425s.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>> Ok. I am decompressing the kernel to 16MB and after reducing 1MB of
>> CONFIG_PHYSICAL_START I am left with 15MB which is not 4M aligned
>> hence I seems to be running into it.
>>
>> I changed it to
>>
>> if ((u32)output) & 0x3fffff)
>>
>> and kdump kernel booted fine. But this will run into issues if I load
>> kernel at 1MB.
>>
>> I got a dump question. Why do I have to load the kernel at 4MB alignment?
>> Existing kernel boots loads at 1MB, which is non 4MB aligned and it works
>> fine?
> 
> 4MB is a little harsh, but I haven't worked through what the exact rules
> are, I know 4MB is the worst case alignment for arch/i386.
> 

4 MB would be worst case for i386; 2 MB for x86-64.  Actually the x86-64 
worst case would be gigabyte, but that's more than a little bit extreme.

	-hpa
