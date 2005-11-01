Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKAJ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKAJ4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVKAJ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:56:05 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:3769 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750714AbVKAJ4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:56:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=JtHa3CeqNFo2oiR+Ac1Q/5w0TuMNY7gNOM7TBeu8pCVxBkPfnBUodYyNJyWbyvsRVT7ISvSZNb8DH3ehiNNxiwHT3bijzBpOj6zTC8OKITVD92pfyALDaZMw9L1a3UBbwYyzBWeh0Q0W0XzN03DFB8LHZxJXE/uzboImGAIEGO4=
Message-ID: <43673B6F.5030909@gmail.com>
Date: Tue, 01 Nov 2005 10:54:55 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ondrej Zary <linux@rainbow-software.org>,
       "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it> <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it> <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org>
In-Reply-To: <4366A49F.3000101@rainbow-software.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zary ha scritto:

> Patrizio Bassi wrote:
>
>> Ray Lee ha scritto:
>>
>>> On Mon, 2005-10-31 at 18:04 +0100, Patrizio Bassi wrote:
>>>
>>>
>>>>> On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>>>>>
>>>>>
>>>>>> starting from 2.6.0 (2 years ago) i have the following bug.
>>>>>> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
>>>>>
>>>
>>>
>>>>>> fast summary:
>>>>>> when playing audio and using a bit the harddisk (i.e. md5sum of a
>>>>>> 200mb
>>>>>> file) i hear noises, related to disk activity. more hd is used,
>>>>>> more chicks
>>>>>> and ZZZZ noises happen.
>>>>>
>>>>>
>>>>> Does hdparm -i (or -I) show differences between the 2.4 kernels and
>>>>> 2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
>>>>> the best driver any more.
>>>>>
>>>>> You may also want to compare lspci -vv of your IDE controller and
>>>>> sound card between 2.4 and 2.6, and see if there are any differences.
>>>>>
>>>>> No guarantees, but this is where you'd start.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>> Ready to test any patch/solution.
>>>>>
>>>>>
>>>>>
>>>>> Try that. If nothing obvious appears in the examination, you may want
>>>>> to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
>>>>> reduce latency in the kernel, but also has a latency tracer that may
>>>>> be particularly useful for your problem. (Assuming it's a latency
>>>>> issue, and not a hardware misconfiguration due to 2.6 doing something
>>>>> wrong.)
>>>>
>
> I've seen something like this yesterday on ECS P6EXP-Me board (i440EX
> chipset) with onboard CMI8338 PCI sound chip. The sound was distorted
> when e.g. moving mouse in Windows. When I disabled "PCI 2.1 support"
> in BIOS, the problem disappeared in Windows. But when I booted Slax
> LiveCD, the same problem appeared - so I think that Linux enables
> something that's causing these problems with some PCI sound devices on
> these chipsets.
>
i played a bit with bios, but no luck.
considering that in my windows copy i have no problems, i'm sure it's
linux 2.6

update: can't use linux 2.4, i have nptl only and acpi problems too.
i'll play with timers and latency
