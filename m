Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRKRWGL>; Sun, 18 Nov 2001 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281477AbRKRWGC>; Sun, 18 Nov 2001 17:06:02 -0500
Received: from jalon.able.es ([212.97.163.2]:1498 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S280132AbRKRWFs>;
	Sun, 18 Nov 2001 17:05:48 -0500
Date: Sun, 18 Nov 2001 23:05:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Message-ID: <20011118230540.A2042@werewolf.able.es>
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E165ZRi-000718-00@mauve.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sun, Nov 18, 2001 at 22:25:50 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011118 James A Sutherland wrote:
>On Sunday 18 November 2001 9:12 pm, war wrote:
>> It is amazing that I could run all of that stuff, because:
>>
>> When I have swap on, and if I run all of those programs, 200-400MB of
>> swap is used.
>
>Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out 
>to disk - even without "swap space". Disabling swapspace simply forces the 
>kernel to swap out more code, since it cannot swap out any data.
>

Sure ??? Where ?? What disk space uses it to swap pages to ?

>(This is why you can still get "disk thrashing" without any swap - in fact, 
>it's more likely in this case than it is with some swap added - you are just 
>forcing your binaries to take more of the swapping load instead.)
>

You get thrashing because you don have anything cached. So you can get a point
(fill all your space with apps and data) where each file read is _REALLY_ a
disk read, not just a transfer from cache (that is what usually happens).

>
>So: with swapspace, the kernel swaps out a few hundred Mb of unused data, to 
>make room for more code. Without it, the kernel is forced to swap out code 
>pages instead. The big news here is...?
>

You swap out pages, not data or code. Kernel does not care if the page contains
code or data. Try (on a swap enabled box) this: open mozilla or staroffice (a
big gui app), let it open and don't use it, fill your ram with other apps and
try to pull down a menu from mozilla. It has an unusual delay, the time to get
mozilla CODE pages back from swap. That is why a system with no swap is more
responsive.

Yes, a box without swap runs faster, but if you *don't do anything* with it. The test
shown in previous mails had a ton of apps opened *doing nothing*. Try do do
a grep several times on the kernel source tree for example in that scenario.
Or a kernel build. They will be dog slow (all the tries). Try the same on
a box with swap, the second time much things are cached and it flies.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre6-beo #1 SMP Sun Nov 18 10:25:01 CET 2001 i686
