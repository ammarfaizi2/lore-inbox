Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWAJUxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWAJUxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWAJUxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:53:23 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:41880 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932495AbWAJUxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:53:23 -0500
Date: Tue, 10 Jan 2006 12:53:17 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 64-bit vs 32-bit userspace/kernel benchmark? Was: Athlon 64
 X2cpuinfooddities
In-Reply-To: <43C41DFD.9000507@mnsu.edu>
Message-ID: <Pine.LNX.4.62.0601101250440.5425@qynat.qvtvafvgr.pbz>
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> 
 <p73r77gx36u.fsf@verdi.suse.de>  <9a8748490601091812x24aefae3oc0c6750c5321c3ab@mail.gmail.com>
  <200601100336.31677.ak@suse.de> <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>
 <43C417A5.6070104@mnsu.edu> <Pine.LNX.4.62.0601101232420.5425@qynat.qvtvafvgr.pbz>
 <43C41DFD.9000507@mnsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Jeffrey Hundstad wrote:

> Date: Tue, 10 Jan 2006 14:50:05 -0600
> David Lang wrote:
>
>> On Tue, 10 Jan 2006, Jeffrey Hundstad wrote:
>> 
>>> 
>>>> On 1/10/06, Andi Kleen <ak@suse.de> wrote:
>>>> 
>>>>> On Tuesday 10 January 2006 03:12, Jesper Juhl wrote:
>>>>> 
>>> ...
>>> 
>>>>> Ah - how legacy.
>>>>> 
>>>>> 
>>>> Yeah, but since my distro of choice is 32bit only and I don't much
>>>> feel like porting it myself or using an unofficial port (slamd64) I'm
>>>> sticking with a 32bit userspace. And as long as userspace is pure
>>>> 32bit there doesn't seem to be much point in building a 64bit kernel.
>>>> And I only have 2GB of RAM, so I don't have a use for the larger 64bit
>>>> address space.
>>>> I also don't run any apps that do a lot of math on >32bit numbers, so
>>>> there's not much gain there either.
>>>> I guess I would bennefit from the extra GPR's, but then I would at the
>>>> same time loose a bit by all pointers being 64bit - both lose some
>>>> disk space due to larger binaries and I'd have increased memory use
>>>> and less efficient L1/L2 cache use.
>>>> 
>>>> I don't think there would actually be much gain for me in switching to
>>>> a 64bit kernel with a 64bit userspace atm.
>>>> But if I'm wrong I'd of course love to hear about it :)
>>>> 
>>>> 
>>> 
>>> Has anyone done any actual benchmark tests that show 64-bit vs 32-bit 
>>> environments/distributions with Athlon64 processors.  If so, I love to see 
>>> the results.  I too elected to stick with 32-bit, using the same 
>>> reasoning/guessing above.
>> 
>> 
>> remember that benchmarks are all dependant on your workload, but on some of 
>> my workloads (lots of fork-based network services) I've seen a 50%+ 
>> increase by switching from a 32 bit to 64 bit kernel with 32 bit userspace, 
>> and a further 50%+ increase by switching to a 64 bit userspace.
>> 
>
> Thanks for your response.  I'm prob. being stupid here... but does "increase" 
> here mean faster or slower?

increase means faster.

>> remember that on amd64 systems 64 bit programs have access to twice as many 
>> registers as 32 bit programs. This can be more of a win then the extra 
>> pointer size is a loss.
>
>
> If you've done other "standard" type of benchmarks between the two please 
> post your results.  Also, is there a big hit by using a nearly pure 32-bit 
> environment + the rare 64-bit program when needed?

I haven't done other benchmarks myself, but I have seen some database 
benchmarks (MySQL and Postgres) on the net that showed a doubling of the 
database performance when going from pure 32 bit to pure 64 bit.

I don't see any reason why there would be a direct performance penalty in 
a mixed environment (other then the fact that you may end up eating up 
some ram by having 32bit and 64 bit shared libraries loaded at the same 
time)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

