Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWASNu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWASNu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWASNu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:50:27 -0500
Received: from alpha.polcom.net ([83.143.162.52]:6802 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1161201AbWASNu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:50:26 -0500
Date: Thu, 19 Jan 2006 14:50:19 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG in tmpfs
In-Reply-To: <20060119031455.GA15738@kroah.com>
Message-ID: <Pine.LNX.4.63.0601191432200.8060@alpha.polcom.net>
References: <Pine.LNX.4.63.0601190027320.8060@alpha.polcom.net>
 <20060119031455.GA15738@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Greg KH wrote:

> On Thu, Jan 19, 2006 at 01:14:56AM +0100, Grzegorz Kulewski wrote:
>> Hi,
>>
>> I managed to get something like this:
>>
>> kernel BUG at mm/shmem.c:836!
>> Jan 17 23:31:42 kangur [4312977.009000] CPU:    0
>> Jan 17 23:31:42 kangur [4312977.009000] EIP:    0060:[<b014a429>]
>> Tainted: P      VLI
>
> Can you duplicate this on a 2.6.15 or newer kernel, without a closed
> source driver loaded?

1. Well, as I said in my message I am not able to reproduce this on demand 
at all. It is the first time it ever happened to me in two months. If 
somebody is interested I can try very hardly to reproduce it but I would 
not expect success.

2. As to the tainted kernel. Well, I know it is tainted (by something 
like madwifi or nvidia loaded by coldplug and not even used from bootup). 
So this is very unlikely that this is the cause. But of course I can not 
guarantee that. But because of #1 -  I am not able to reproduce it with 
untainted kernel - I sent it to this list. Maybe it will make some bells 
ring in some smart head, especially if that head knows how those functions 
and data structures are supposed to work. If no - well - what could I do 
more?

I don't have infrastructure for making 24/7 stress tests of tmpfs (or 
anything other). But maybe if somebody has some spare machines he could 
try doing it because I am seeing different oopses/crashes/bugs in tmpfs on 
different kernel (on x86 and x86-64) from time to time. They are _very_ 
hard to reproduce and are probably also fixed from time to time (maybe by 
other not related changes not because somebody spoted bug in real life). 
Something like making whole system compiles and upgrades in a loop till 
error happens will proably be enough to catch most such errors after some 
time and doing it continously could prevent any regressions in newer 
kernels. All I could do is to try compiling that gcc 3 to 5 times a day 
with all proprietary modules not loaded (and that means real pain on 
desktop system btw).


Thanks,

Grzegorz Kulewski
