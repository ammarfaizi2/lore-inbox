Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292864AbSBVNux>; Fri, 22 Feb 2002 08:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292865AbSBVNun>; Fri, 22 Feb 2002 08:50:43 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37641 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292864AbSBVNuh>; Fri, 22 Feb 2002 08:50:37 -0500
Message-ID: <3C764C8E.6080008@evision-ventures.com>
Date: Fri, 22 Feb 2002 14:50:06 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <slrna7c631.icv.kraxel@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>> 1.  Kill the ide-probe-mod by merging it with ide-mod. There is *really*
>>      no reaons for having this stuff split up into two different
>>     modules unless you wan't to create artificial module dependancies 
>> and waste space
>>     of page boundaries during memmory allocation for the modules
>>
> 
> Ah, seems you are the one who broke modular ide in 2.5.5:
> 
> Older kernels:
>   insmod ide-mod, insmod ide-disk, insmod ide-probe-mod  => works.
> 
> 2.5.5:
>   insmod ide-mod, insmod ide-disk  => mounting /dev/hda2 doesn't work.
> 
>   Gerd

Well I will have to check this soon on a system booting out from SCSI.
Most propably it's an simple "load order" problem, where ide-disk should
call the probe code again. (But somehow ide-scsi, ide-cd and friends
do...)


