Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVHITF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHITF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHITF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:05:57 -0400
Received: from kirby.webscope.com ([204.141.84.57]:23173 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1750793AbVHITF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:05:56 -0400
Message-ID: <42F8FE87.5010809@m1k.net>
Date: Tue, 09 Aug 2005 15:05:43 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: klasyk99@poczta.onet.pl, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: my kernel sometimes did a crash, but no panic
References: <4zEQ3-7Le-21@gated-at.bofh.it> <E1E2Z5U-0004ji-Nt@be1.lrz>
In-Reply-To: <E1E2Z5U-0004ji-Nt@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>Klasyk <klasyk99@poczta.onet.pl> wrote:
>  
>
>>my kernel sometimes did a crash, but no panic
>>Keyboard hunged up :(
>>Network were working and I can log in. Without the keybord - it
>>generally worked.
>>
>>In logs:
>>for example:
>>
>>Aug  6 15:30:02 o kernel: Unable to handle kernel NULL pointer
>>dereference at virtual address 00
>>000000
>>Aug  6 15:30:02 o kernel:  printing eip:
>>Aug  6 15:30:02 o kernel: c026b0d9
>>Aug  6 15:30:02 o kernel: *pde = 3588d001
>>Aug  6 15:30:02 o kernel: Oops: 0000 [#1]
>>Aug  6 15:30:02 o kernel: Modules linked in: ip_nat_irc
>>    
>>
>[...]
>  
>
>>4 ieee1394 loop via-agp bt878 tuner tvaudio bttv video-buf
>>    
>>
>                                              ^^^^
>It's probably the same problem I had.
>
>There is a recent patch enabling the no_overlay=1 parameter and some PCI
>quirks to autotune this option. Please try that and, if your board isn't
>autodetected, the lspci -vvv output and the exact name of your MB chipset.
>
>I temporarily uploaded the patch to
>http://7eggert.dyndns.org/l/scratch/v4l_bttv_no_overlay_linus.patch
>  
>
I don't know if this is the same problem... Let's hope that it IS the 
same problem, because the fix that Bodo speaks of has already been 
included in 2.6.13-rc6:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=00dd1e433967872f3997a45d5adf35056fdf2f56;f=drivers/media/video/bttv-driver.c

Please test again using Kernel 2.6.13-rc6 and let us know if the problem 
persists.

-- 
Michael Krufky


