Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWEQRYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWEQRYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWEQRYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:24:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25749 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750753AbWEQRY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:24:27 -0400
Message-ID: <446B5BC7.7080105@zytor.com>
Date: Wed, 17 May 2006 10:22:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de> <446A2243.6050109@zytor.com> <446ACCCF.1030406@gmail.com> <446B4BDD.9090208@zytor.com> <446B5AB0.8050703@gmail.com>
In-Reply-To: <446B5AB0.8050703@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
> H. Peter Anvin wrote:
>> Jim Cromie wrote:
>>>>
>>> Ok, it built clean, but broke on boot.
>>>
>>
>> What does the full command line look like?
>>
>>     -hpa
>>
> I presume you mean the kernel boot-line, since last post included the 
> 'Running ipconfig'
> 
> Ive been banging at the kernel with permutations of the following 
> pxelinux stanza.
> 
> LABEL   I 2.6.17-rc4-mm1-sk
>  MENU LABEL    ^i.  2.6.17-rc4-mm1-sk
>  KERNEL        vmlinuz-2.6.17-rc4-mm1-sk
>  APPEND        console=ttyS0,115200n81 root=/dev/nfs 
> nfsroot=/nfshost/truck 
> ip=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
> panic=5
> 
> I think the problem lies with picking up a decent 'rootpath', since that
> part of the output is always empty, for all variations tried so far..
> 

Okay, this is probably a result of specifying the NFS server in the ip= 
option and the nfsroot not having a server.  I will try to debug this 
and straighten it out.

	-hpa
