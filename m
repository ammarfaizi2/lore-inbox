Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUEAL6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUEAL6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUEAL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:58:53 -0400
Received: from pop.gmx.net ([213.165.64.20]:37609 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261682AbUEAL6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:58:52 -0400
X-Authenticated: #4512188
Message-ID: <409390F8.2010007@gmx.de>
Date: Sat, 01 May 2004 13:58:48 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: CaT <cat@zip.com.au>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
References: <20040429234258.GA6145@zip.com.au>	<200404300208.32830.bzolnier@elka.pw.edu.pl>	<20040430093919.GA2109@zip.com.au>	<200404301800.08763.bzolnier@elka.pw.edu.pl>	<20040501030828.GE2109@zip.com.au> <20040430222157.17f5db82.akpm@osdl.org>
In-Reply-To: <20040430222157.17f5db82.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> 
>>Here's the patch that Joe sent me. It doesn't apply cleanly mainly due
>> to formatting errors in the patch but a bit of manual fixerupping made
>> it all apply.
>>
>> --- 8< ---
>> --- linux-2.6.4-orig/arch/i386/pci/fixup.c      2004-03-11 
>> 03:55:36.000000000 +0100
>> +++ linux-2.6.4/arch/i386/pci/fixup.c   2004-03-16 13:12:25.706569480 +0100
>> @@ -187,6 +187,22 @@
>>                dev->transparent = 1;
>> }
>>
>> +/*
>> + * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
>> + * must be disabled when APIC is used (or lockups will happen).
>> + */
> 
> 
> I had this in -mm for a while.  Ended up dropping it because it made some
> people's CPUs run warmer and because it "wasn't the right fix".
> 
> Does anyone know what the right fix is?  If not, it seems that a warm CPU
> is better than a non-functional box.  Maybe enable it via a boot option?

Ross' C1halt idle patch is the right thing to take. No fix, but stable 
work-around.

Prakash
