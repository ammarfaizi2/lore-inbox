Return-Path: <linux-kernel-owner+w=401wt.eu-S965150AbWLMUDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWLMUDP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWLMUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:03:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:41268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965143AbWLMUDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:03:12 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:03:11 EST
X-Authenticated: #3612999
Date: Wed, 13 Dec 2006 20:56:18 +0100 (CET)
From: Karsten Weiss <knweiss@gmx.de>
To: Christoph Anton Mitterer <calestyo@scientia.net>
cc: linux-kernel@vger.kernel.org, ak@suse.de, andersen@codepoet.org,
       cw@f00f.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
In-Reply-To: <45804C0B.4030109@scientia.net>
Message-ID: <Pine.LNX.4.64.0612132014340.2963@addx.localnet>
References: <4570CF26.8070800@scientia.net> <Pine.LNX.4.64.0612021048200.2981@addx.localnet>
 <45804C0B.4030109@scientia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Christoph Anton Mitterer wrote:

>> Christoph, I will carefully re-read your entire posting and the
>> included links on Monday and will also try the memory hole
>> setting.
>>
> And did you get out anything new?

As I already mentioned the kernel parameter "iommu=soft" fixes
the data corruption for me. We saw no more data corruption
during a test on 48 machines over the last week-end. Chris
Wedgewood already confirmed that this setting fixed the data
corruption for him, too.

Of course, the big question "Why does the hardware iommu *not*
work on those machines?" still remains.

I have also tried setting "memory hole mapping" to "disabled"
instead of "hardware" on some of the machines and this *seems*
to work stable, too. However, I did only test it on about a
dozen machines because this bios setting costs us 1 GB memory
(and iommu=soft does not).

BTW: Maybe I should also mention that other machines types
(e.g. the HP xw9300 dual opteron workstations) which also use a
NVIDIA chipset and Opterons never had this problem as far as I
know.

Best regards,
Karsten

-- 
Dipl.-Inf. Karsten Weiss - http://www.machineroom.de/knweiss
