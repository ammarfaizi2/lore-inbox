Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVAGUaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVAGUaC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVAGU3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:29:15 -0500
Received: from alog0359.analogic.com ([208.224.222.135]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261591AbVAGU12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:27:28 -0500
Date: Fri, 7 Jan 2005 15:27:05 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
In-Reply-To: <20050107170712.GK29176@logos.cnet>
Message-ID: <Pine.LNX.4.61.0501071519330.21405@chaos.analogic.com>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Marcelo Tosatti wrote:

> On Fri, Jan 07, 2005 at 04:59:22PM +0100, Lukasz Trabinski wrote:
>> Hello
>>
>>
>> http://isec.pl/vulnerabilities/isec-0021-uselib.txt
>>
>> [...]
>> Locally  exploitable  flaws  have  been found in the Linux binary format
>> loaders'  uselib()  functions  that  allow  local  users  to  gain  root
>> privileges.
>> [...]
>> Version:   2.4 up to and including 2.4.29-rc2, 2.6 up to and including 2.6.10
>> [...]
>>
>> It's was fixed by Marcelo on 2.4.29-rc1. Thank's :)
>> What about 2.6.X? Is any patch available? I don't see any changes
>> around binfmt_elf in 2.6.10-bk10?
>
> 2.6.10-ac contains a version of the fix.
>
> Attached is what going to be merged in mainline, most likely.
>
>

FYI, the provided source-code won't build with the 2.6.x kernel
because one of the structures is no longer defined. However,
building on 2.4.20 and attempting to exploit the alleged bug
results in:

Script started on Fri 07 Jan 2005 03:22:24 PM EST
LINUX> ./isec

[+] SLAB cleanup    child 1 VMAs 0
[+] moved stack bfffe000, task_size=0xc0000000, map_base=0xbf800000
[+] vmalloc area 0xef800000 - 0xffffd000

[-] FAILED: try again (No such device) 
Killed
LINUX> ./isec

[+] SLAB cleanup    child 1 VMAs 0
[+] moved stack bfffe000, task_size=0xc0000000, map_base=0xbf800000
[+] vmalloc area 0xef800000 - 0xffffd000

[-] FAILED: try again (No such device) 
Killed
LINUX> exit

Script done on Fri 07 Jan 2005 03:22:45 PM EST


.... Nothing. It just doesn't do what it's claimed to do....
So, maybe the exploit __can__ happen under rare circumstances,
but I wouldn't worry too much about it at the present time.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
