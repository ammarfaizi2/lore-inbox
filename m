Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284297AbSABV0E>; Wed, 2 Jan 2002 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286853AbSABVZs>; Wed, 2 Jan 2002 16:25:48 -0500
Received: from tourian.nerim.net ([62.4.16.79]:4112 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S284807AbSABVZa>;
	Wed, 2 Jan 2002 16:25:30 -0500
Message-ID: <3C337AC8.2020900@free.fr>
Date: Wed, 02 Jan 2002 22:25:28 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: xsebbi@gmx.de, Linux <linux-kernel@vger.kernel.org>
Subject: Re: system.map
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022028.04945@xsebbi.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Roth wrote:

>>Hi all
>>
> 
> hello,
> 
> 
>>Why sometimes I don't need to copy the system.map to
>>/boot when I update the kernel
>>and the system also can boot?
>>
> 
>>Is it correct?
>>
> 
> yes, this is correct. I think this System.map contains only some useful 
> information about modules for the kernel.

 > [...]

"man klogd", "man ksymoops".

Short:
System.map is an ordered (by address) list of (kernel address, ?type?, 
and syscall name).
Module syscalls are dynamic by nature so there's a kernel interface for 
exporting symbols to user utilities needing their addresses (see 
/proc/ksyms).

You don't need System.map to boot. But user space apps like ps (can show 
the current syscall used by a process), klogd (for clean GPF reports), 
ksymoops (mainly as a cross-check with vmlinux symbols) use it and 
search it in numerous places : with or without `-uname -r` appended (at 
least in / /boot /usr/src/linux).

LB.

