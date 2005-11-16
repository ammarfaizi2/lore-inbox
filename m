Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVKPVIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVKPVIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVKPVIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:08:25 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:47294 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S932604AbVKPVIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:08:24 -0500
Message-ID: <437B9FAC.4090809@qualcomm.com>
Date: Wed, 16 Nov 2005 13:07:56 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.14 X spinning in the kernel
References: <1132012281.24066.36.camel@localhost.localdomain>	<20051114161704.5b918e67.akpm@osdl.org>	<1132015952.24066.45.camel@localhost.localdomain> <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
In-Reply-To: <437A6609.4050803@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>
>>> On Mon, 2005-11-14 at 16:17 -0800, Andrew Morton wrote:
>>>
>>>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>>>
>>>>> My 2-cpu EM64T machine started showing this problem again on 2.6.14.
>>>>> On some reboots, X seems to spin in the kernel forever.
>>>>>
>>>>> sysrq-t output shows nothing.
>>>>>
>>>>> X             R  running task       0  3607   3589          3903
>>>>> (L-TLB)
>>>>>
>>>>> top shows:
>>>>> 3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X
>>>>>
>>>>>
>>>>> So, I wrote a module to do smp_call_function() on all CPUs
>>>>> to show stacks on them. CPU0 seems to be spinning in exit_mmap().
>>>>> I did this multiple times to collect stacks few times.
>>>>>
>>>>> Is this a known issue ?

I've seen similar problems on dual Opteron HP xw9300/Radeon 7000 PCI box with 2.6.11.12
and latest X from Fedora x86-64 YUM repos.
I haven't done any traces but it sounds like the same problem (ie X server is spinning).
Disabling DRI in xorg.conf fixed it for me.

Max
