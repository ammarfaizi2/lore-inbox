Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVHHLTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVHHLTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHHLTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:19:32 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:2204 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750754AbVHHLTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:19:31 -0400
Message-ID: <42F7419E.3060905@aitel.hist.no>
Date: Mon, 08 Aug 2005 13:27:26 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@picard.cistron.nl>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X trouble.
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <20050805150506.703e804f.akpm@osdl.org> <dd5f2j$fj7$1@news.cistron.nl>
In-Reply-To: <dd5f2j$fj7$1@news.cistron.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:

>Andrew Morton  <akpm@osdl.org> wrote:
>  
>
>>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>>    
>>
>>>2.6.13-rc5 seemed to kill a scsi disk (sdb) for me, where 2.6.13-rc4-mm1
>>>have no problems with the same disk.
>>>      
>>>
>
>Sort of same with me:
>2.6.12-mm1 runs for _weeks_ where others keep crashing:
>
>  
>
>>The latest -git kernel (or 2.6.13-rc6 if it's there) with APCI enabled is
>>the one to test, please.
>>    
>>
>
>no rc6 yet, i did however experience the following:
>
>reboot   system boot  2.6.12-mm1       Sun Aug  7 18:20          (00:36)
>dth      pts/1        zaphod.dth.net   Sun Aug  7 15:41 - crash  (02:38)
>reboot   system boot  2.6.13-rc5-git5  Sun Aug  7 14:04          (04:52)
>reboot   system boot  2.6.13-rc5-git4  Sun Aug  7 10:05          (03:43)
>reboot   system boot  2.6.13-rc5-git3  Fri Aug  5 16:55         (1+17:07)
>
>git3 lasted near 2 days
>git4 ran for nearly 5 hours than i upgraded to
>git5 didn't last longer than 2.5 hours
>
>Fortunatly some info was found in the log files.
>What i dont "get" is that ethernet also goes down when the scsi
>controller goes bezerk.
>I'm pretty sure it's not a hardware problem since 2.6.12-mm1 survives
>and brings this usenet host in the worldwide top 1000.
>  
>
Interesting. 
I have no idea what the core problem is, but one problem will often lead
to others.  My scsi problem froze some apps that couldn't be paged in
from the "failing" disk, for example.

Something going wrong in the kernel can delay other devices for too long,
maybe your network driver was hit by nasty latency in the middle of 
something
as the scsi controller reset itself.  It may also be memory scribbling.

I sometimes gets x lockups with rc5.  Sometimes they just lock one display,
sometimes the whole machine locks solid necessitating a reset. sysrq+B
did not work, on either keyboard.

rc5 is no good for amd64, and it doesn't need power management to go wrong.

Helge Hafting
