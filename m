Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIZHwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIZHwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIZHwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:52:10 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:49170 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750706AbWIZHwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:52:09 -0400
Message-ID: <4518DC0B.10207@shadowen.org>
Date: Tue, 26 Sep 2006 08:51:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com>
In-Reply-To: <45185A93.7020105@google.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> http://test.kernel.org/abat/49037/debug/test.log.0   
> 
>   AS      arch/x86_64/boot/bootsect.o
>   LD      arch/x86_64/boot/bootsect
>   AS      arch/x86_64/boot/setup.o
>   LD      arch/x86_64/boot/setup
>   AS      arch/x86_64/boot/compressed/head.o
>   CC      arch/x86_64/boot/compressed/misc.o
>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file
> offset 0x804700c0.
> /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy:
> arch/x86_64/boot/compressed/vmlinux.bin: File truncated
> make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
> make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
> make: *** [bzImage] Error 2
> 09/25/06-09:13:48 Build the kernel. Failed rc = 2
> 09/25/06-09:13:49 build: kernel build Failed rc = 1
> 
> Wierd. Same box compiled 2.6.18 fine.

Pretty sure this isn't a space problem, as we have just checked space
before the build and I've taken no action since then.  Someone did
mention "tool chain issue" when it was first spotted.  Will check with
them and see why they thought that.

-apw
