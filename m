Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWHAUk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWHAUk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWHAUk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:40:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60546 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751011AbWHAUk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:40:59 -0400
Date: Tue, 1 Aug 2006 16:40:23 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060801204023.GG7054@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
> 
> Currently there are 33 patches in my tree to do this.
> 
> The weirdest symptom I have had so far is that page faults did not
> trigger the early exception handler on x86_64 (instead I got a reboot).
> 
> There is one outstanding issue where I am probably requiring too much alignment
> on the arch/i386 kernel.  
> 
> Can anyone find anything else?
>

I am running into compilation failure on x86_64.

 
  SYSMAP System.map
  SYSMAP .tmp_System.map
  AS      arch/x86_64/boot/bootsect.o
In file included from include/asm/bitops.h:9,
                 from include/linux/bitops.h:10,
                 from include/linux/kernel.h:16,
                 from include/asm/system.h:5,
                 from include/asm/processor.h:19,
                 from include/asm/elf.h:11,
                 from include/linux/elf.h:8,
                 from arch/x86_64/boot/bootsect.S:20:
include/asm/alternative.h:73: error: syntax error in macro parameter list
include/asm/alternative.h:88: error: syntax error in macro parameter list
include/asm/alternative.h:127: error: syntax error in macro parameter list
In file included from include/asm/system.h:5,
                 from include/asm/processor.h:19,
                 from include/asm/elf.h:11,
                 from include/linux/elf.h:8,
                 from arch/x86_64/boot/bootsect.S:20:
include/linux/kernel.h:34: warning: "ALIGN" redefined
In file included from include/linux/kernel.h:12,
                 from include/asm/system.h:5,
                 from include/asm/processor.h:19,
                 from include/asm/elf.h:11,
                 from include/linux/elf.h:8,
                 from arch/x86_64/boot/bootsect.S:20:
include/linux/linkage.h:27: warning: this is the location of the previous definition
In file included from include/asm/system.h:5,
                 from include/asm/processor.h:19,
                 from include/asm/elf.h:11,
                 from include/linux/elf.h:8,
                 from arch/x86_64/boot/bootsect.S:20:
include/linux/kernel.h:216: error: syntax error in macro parameter list
include/linux/kernel.h:220: error: syntax error in macro parameter list
In file included from include/linux/sched.h:55,
                 from include/asm/compat.h:9,
                 from include/asm/elf.h:12,
                 from include/linux/elf.h:8,
                 from arch/x86_64/boot/bootsect.S:20:
include/linux/nodemask.h:229: error: detected recursion whilst expanding macro "find_first_bit"
include/linux/nodemask.h:235: error: detected recursion whilst expanding macro "find_next_bit"
include/linux/nodemask.h:254: error: detected recursion whilst expanding macro "find_first_zero_bit"
arch/x86_64/boot/bootsect.S:21: error: linux/elf_boot.h: No such file or directory
make[1]: *** [arch/x86_64/boot/bootsect.o] Error 1
make: *** [bzImage] Error 2

Thanks
Vivek

