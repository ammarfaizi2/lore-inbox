Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUAFGJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUAFGJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:09:16 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:49928 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S266072AbUAFGJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:09:11 -0500
Message-ID: <3FFA51D1.2000401@nishanet.com>
Date: Tue, 06 Jan 2004 01:12:33 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla Thunderbird 0.5a (20040102)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux hangs on nVidia nForce2 400 Ultra
References: <20040104173624.19046.qmail@iname.com> <3FF8558A.2080308@reactivated.net>
In-Reply-To: <3FF8558A.2080308@reactivated.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All correct, and if you have Award bios an update
may help stability with nforce2.

-Bob D

Daniel Drake wrote:

> Hi,
>
> Theres been some work done on this issue lately. Originally, my system 
> only hung when I had IO-APIC and local APIC support compiled into the 
> kernel. But I think other people had hanging problems even without this.
>
> You could first try using a 2.6-mm series kernel, as these include 
> some patches which fix nforce2 problems for most people (but not me).
>
> The other option is to try Ross Dickinson's patches:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107199838022614&w=2
>
> If you use Ross's patches, as well as the -mm fixes, you should revert 
> out the nforce-disconnect-quirk patch to avoid your CPU getting 
> needlessly hot.
>
> Personally, I have stability running 2.6.1-rc1-mm1 with the 
> disconnect-quirk reverted out, Ross's patches, booting with parameter 
> apic_tack=2. I have APIC/IOAPIC compiled in and working.
>
> Daniel.
>
> Herve Fache wrote:
>
>> Hi chaps!    My system hangs (no oops, nothing) on disk access using 
>> either 2.4.23 or 2.6.0. A rather reliable way for me to  crash it is 
>> to, for example, copy the sources of the Linux kernel.    It hanged 
>> once on CD-ROM access, which could lead to a more IDE-level problem. 
>> Also, the only time it did it in  another operating system (humm...) 
>> was after it crashed in Linux and I pressed reset (no shut down), 
>> which  makes me think it could the IDE controller [driver]'s 
>> fault...    It seems I'm the only one on Earth to have this problem 
>> (according to Google), but if there was a way to track it down I'd be 
>> happy to try.    I have attached my 2.6.0 kernel config for info.    
>> Thanks!  Hervé.  
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

