Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVA1R1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVA1R1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVA1R1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:27:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:12473 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbVA1RZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:25:52 -0500
Message-ID: <41FA7128.1090604@osdl.org>
Date: Fri, 28 Jan 2005 09:06:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1-V0.7.34-01 ACPI err in dmesg
References: <200501072156.54803.gene.heskett@verizon.net> <20050128070840.GA1456@elte.hu>
In-Reply-To: <20050128070840.GA1456@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Gene Heskett <gene.heskett@verizon.net> wrote:
> 
> 
>>  Normal zone: 225280 pages, LIFO batch:16
>>  HighMem zone: 32752 pages, LIFO batch:7
>>DMI 2.2 present.
>>__iounmap: bad address c00f0000  <-why?
>>ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7220
> 
> 
> I have no idea what is causing this. If it still occurs with recent
> kernels then stick a WARN_ON(1) into __iounmap()'s error path, to get a
> stack dump? It is almost certainly not related to -RT.

There was a thread a few weeks ago about this same message (afaik).
The answer then was something like "the __iounmap() call is happening
very early, before the unmap machinery (data/structs) have been
set up for it."  (but I don't know that first-hand, just repeating
close to what I read.)

-- 
~Randy
