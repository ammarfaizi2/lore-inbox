Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSLPSKQ>; Mon, 16 Dec 2002 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLPSKQ>; Mon, 16 Dec 2002 13:10:16 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:8958 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S266997AbSLPSKP>; Mon, 16 Dec 2002 13:10:15 -0500
Message-ID: <3DFE18CC.10900@mvista.com>
Date: Mon, 16 Dec 2002 11:17:48 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Bourne <bourne@ToughGuy.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unmounting a busy RO-Filesystem
References: <3DFE789B.9020507@ToughGuy.net> <200212161313.gBGDDgs12643@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:

>On 16 December 2002 23:06, Bourne wrote:
>  
>
>>I have 3 partitions. /dev/hda3 for '/' , /dev/hda1 for /boot and
>>/dev/hda2 for swap.
>>
>>I boot & then i do a CTRL+ALT+SYSRQ+U.  '/' and '/boot' are now
>>remounted ReadOnly.
>>
>>1) cd '/boot'
>>2) umount /boot ----> This gives me an error "Device Busy"
>>    
>>
>
>How do you imagine unmounting a directory when you are in it? ;)
>  
>
This is possible with a kernel patch called forced unmount.  It will 
blow away the mount point even if there are files open in it or not. 
 The best part is it properly closes the superblock so the filesystem 
doesn't have to be fsck'ed.

>  
>

