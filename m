Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVHXR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVHXR4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVHXR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:56:30 -0400
Received: from leyde.iplannetworks.net ([200.69.193.99]:10693 "EHLO
	proxy3.iplannetworks.net") by vger.kernel.org with ESMTP
	id S1751330AbVHXR43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:56:29 -0400
Message-ID: <430CB3EC.2000502@latinsourcetech.com>
Date: Wed, 24 Aug 2005 14:52:44 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel image in a Prep Boot on PowerPC
References: <430C8CB5.1050501@latinsourcetech.com> <20050824163100.GD1100@tuxdriver.com>
In-Reply-To: <20050824163100.GD1100@tuxdriver.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:

>On Wed, Aug 24, 2005 at 12:05:25PM -0300, Márcio Oliveira wrote:
>
>  
>
>>  I think the kernel is pointing to the wrong root partiotion. In a x86 
>>box, I can change the kernel root partition in the boot loader (root= 
>>parameter) or using the "rdev" command. In my case, the IBM Power 
>>doesn't have a boot loader (yaboot was replaced by the kernel image) and 
>>the powerpc64 system doesn't have the rdev command (from util-linux 
>>package, the same package on x86 systems have the rdev command!).
>>    
>>
>
>I don't know anything that will do this on a pre-built kernel.  But,
>you should look at CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE in your
>kernel configuration.  That will let you pre-configure the "root="
>command line option.
>  
>
Hi John,

The command rdev can change the default root partition on x86 linux 
systems with pre-built kernels.

About the CONFIG_CMDLINE in the kernel configuration, I found it in lots 
of files in the kernel source tree and I'd like to know which file I 
need to change this value (/usr/src/linux/arch/ppc64/defconfig ?).

>I don't know if ppc64 can use the zImage-style boot wrapper.  If it
>can, that would provide you with an option of modifying the command
>line at boot time if needed.
>  
>
According to this doc: 
http://www-128.ibm.com/developerworks/eserver/library/es-SW_RAID_LINUX.html, 
ppc64 can use zImage-style boot wrapper, so I'm trying it.

>Good luck!
>
>John
>  
>
Thanks John!

Márcio.
