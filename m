Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUBVC6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUBVC6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:58:17 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:8382 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261654AbUBVC6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:58:13 -0500
Message-ID: <40381AC2.2020607@cyberone.com.au>
Date: Sun, 22 Feb 2004 13:58:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <20040222021710.GD703@holomorphy.com> <4038168C.1000404@matchmail.com>
In-Reply-To: <4038168C.1000404@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> William Lee Irwin III wrote:
>
>> William Lee Irwin III wrote:
>>
>>>> Similar issue here; I ran out of filp's/whatever shortly after 
>>>> booting.
>>>
>>
>>
>> On Sat, Feb 21, 2004 at 06:03:14PM -0800, Mike Fedyk wrote:
>>
>>> So Nick Piggin's VM patches won't help with this?
>>
>>
>>
>> I think they're in -mm, and I'd call the vfs slab cache shrinking stuff
>> a vfs issue anyway because there's no actual VM content to it, apart
>> from the code in question being driven by the VM.
>
>
> Hmm, that's news to me.  Maybe that's a newer patch.  I haven't been 
> reading the list much for the last month or so...
>
> Nick had a patch that was supposed to help 2.6 with low memory 
> situations to bring it on a par with 2.4 in that respect.  ISTR 
> "active recycling" being mentioned about it...
>

Just an aside, it is hard to get 2.6 "on par" with 2.4 because 2.6 is
often much fairer (although it can still be badly unfair - if we ever
want to fix that we'd probably need per process mm).

There are quite a lot sorts of low memory situations you can get into.
My (and Nikita's) patches don't help the one you're probably in. They
don't put more pressure on slab.

