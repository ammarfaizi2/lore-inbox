Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVBPUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVBPUoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVBPUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:44:05 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:63435 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261865AbVBPUnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:43:46 -0500
Message-ID: <4213B084.4020800@tiscali.de>
Date: Wed, 16 Feb 2005 21:43:48 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Haven Skys <hskys@frontbridge.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Help: kernel option root=/dev/nfs failing 2.6.10
References: <005c01c51462$656c8b10$2401a8c0@internal.bigfish.com>
In-Reply-To: <005c01c51462$656c8b10$2401a8c0@internal.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven Skys wrote:

>Thanks.  Yes I have.
>Here are a couple configuration options I have set:
>
>CONFIG_IP_PNP=y
>CONFIG_IP_PNP_DHCP=y
>CONFIG_IP_PNP_BOOTP=y
>CONFIG_IP_PNP_RARP=y
>
>CONFIG_NFS_FS=y
>CONFIG_NFS_V3=y
>CONFIG_NFS_V4=y
>CONFIG_NFS_DIRECTIO=y
>CONFIG_NFSD=y
>CONFIG_NFSD_V3=y
>CONFIG_NFSD_V4=y
>CONFIG_NFSD_TCP=y
>CONFIG_ROOT_NFS=y
>
>Everything is textbook really.  I followed several different examples and
>still nothing works.
>
>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Matthias-Christian
>Ott
>Sent: Wednesday, February 16, 2005 11:09 AM
>To: Haven Skys
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: Help: kernel option root=/dev/nfs failing 2.6.10
>
>Haven Skys wrote:
>
>  
>
>>I am attempting to create network bootable system with 2.6.10 and nfs and
>>    
>>
>am
>  
>
>>having trouble.
>>
>>I am using grub and the boot goes without a hitch until the kernel attempts
>>to use the commands I've sent.
>>
>><SNIP from grub.conf>
>>bootp
>>root (nd)
>>kernel (nd)/redhat-2.6.10/kernel root=/dev/nfs ip=bootp
>>nfsroot=10.0.120.1:/diskless/redhat-2.6.10/
>>baseos
>></SNIP>
>>
>>Network booting machine X does fine until. It attempts to open the root
>>device.
>>
>><SNIP>
>>VFS: Cannot open root device "nfs" or unknown-block(0,255) Please append a
>>correct "root=" boot option Kernel panic - not syncing: VFS: Unable to
>>    
>>
>mount
>  
>
>>root fs on unknown-block(0,255) </SNIP>
>>
>>It looks like the kernel isn't recognizing the virtual device /dev/nfs but
>>I've enabled all the NFS options and everything is compiled into the
>>    
>>
>kernel.
>  
>
>>Any ideas?
>>
>>
>>Thanks
>>Haven
>>
>>
>>
>>
>>
>>
>>FrontBridge introduces Message Archive and Secure Email. Get leading
>>    
>>
>Enterprise Message Security services from FrontBridge. www.frontbridge.com.
>  
>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>> 
>>
>>    
>>
>Hi!
>I did you follow the "tutorial" in Documentation/nfsroot.txt?
>
>Matthias-Christian Ott
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>FrontBridge introduces Message Archive and Secure Email. Get leading Enterprise Message Security services from FrontBridge. www.frontbridge.com.
>
>
>
>
>  
>
Your config looks good. Try to give the kernel the "nfsroot=" parameters 
and try to boot from the harddisk to see if the client really gets the 
bootp information correctly.

Matthias-Christian Ott
