Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUL2Noo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUL2Noo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 08:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUL2Noo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 08:44:44 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:48667 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261345AbUL2Noa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 08:44:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=okldJZ73ip0xWSH7ibjr0JzK+/dKjBdmCw28zkpQ0biqVFfulb5t/+Ak7HCH/kDw0YfleKphOr/X3agS/Ts6RzE7E8ey91ZulL29xz61e7Gx5b/bSnTHhxP4QvqWpdR6GJ1NUpz+tEaMFNrrDH2ne2h6DaRYWshz1PHdsdTMODc=
Message-ID: <41D2B4B4.6090608@gmail.com>
Date: Wed, 29 Dec 2004 14:44:20 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Knoblich <stkn@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: b44 ifconfig fails with ENOMEM
References: <200412290557.29114.stkn@gentoo.org>
In-Reply-To: <200412290557.29114.stkn@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Knoblich wrote:

>Hi,
>
>ifconfig eth0 192.168.1.2 up returns the following error message:
>
>laptop ~ # ifconfig eth0 192.168.1.2 up
>SIOCSIFFLAGS: Cannot allocate memory
>SIOCSIFFLAGS: Cannot allocate memory
>
>output of dmesg:
>
>ifconfig: page allocation failure. order:8, mode:0x21
> [<c01382f2>] __alloc_pages+0x1d2/0x3a0
> [<c01384df>] __get_free_pages+0x1f/0x40
> [<c010923a>] dma_alloc_coherent+0xca/0x100
> [<e00dec87>] b44_alloc_consistent+0xc7/0x1a0 [b44]
> [<e00df1a1>] b44_open+0x21/0xd0 [b44]
> [<c035e3ae>] schedule+0x2be/0x4e0
> [<c02e0445>] dev_open+0x85/0xa0
> [<c02e1953>] dev_change_flags+0x53/0x130
> [<c031ec17>] devinet_ioctl+0x257/0x5b0
> [<c0320f36>] inet_ioctl+0x66/0xb0
> [<c02d76c9>] sock_ioctl+0xd9/0x2b0
> [<c0162215>] sys_ioctl+0xd5/0x220
> [<c0107417>] do_syscall_trace+0x47/0x90
> [<c0102f43>] syscall_call+0x7/0xb
> 
>there's plenty of free memory available:
>
>laptop ~ # free
>             total       used       free     shared    buffers     cached
>Mem:        506320     499728       6592          0      20036     274712
>-/+ buffers/cache:     204980     301340
>Swap:       987988       3144     984844
>
>unloading and reloading the module didn't help, only a reboot fixed it (after 
>~36hours uptime)
>  
>
same problem here. i left my laptop on for a longer time and ifconfig 
failed too
kernel backtrace same as above. kernel looked like it didn't swap out 
some memory.
lots of swap free no phys mem free. i dont know if this helps.
reloading the module didn't help too.
if you want more info please let me know
