Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTJOKkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJOKkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:40:21 -0400
Received: from gprs146-98.eurotel.cz ([160.218.146.98]:34177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262633AbTJOKkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:40:12 -0400
Date: Wed, 15 Oct 2003 12:40:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/proc/array.c Compile Error
Message-ID: <20031015104000.GA446@elf.ucw.cz>
References: <Pine.LNX.4.44.0310141204150.28049-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310141204150.28049-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As of this morning, I'm getting a neat compile error in fs/proc/array.c: 
> 
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:392: Unrecognizable insn:
> (insn/i 711 995 989 (parallel[
>             (set (reg:SI 0 eax)
>                 (asm_operands ("") ("=a") 0[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 37))
>             (set (reg:SI 1 edx)
>                 (asm_operands ("") ("=d") 1[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 37))
>             (clobber (reg:QI 19 dirflag))
>             (clobber (reg:QI 18 fpsr))
>             (clobber (reg:QI 17 flags))
>         ] ) -1 (insn_list 705 (nil))
>     (nil))
> fs/proc/array.c:392: confused by earlier errors, bailing out
> 
> 
> The GCC version I'm using is 
> 
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> 
> Any ideas? 

Well, thats compiler internal error (I've seen lots of those during
x86-64 development). Either fix your compiler (hard), or add
"volatile"'s to the variables in function until it stops.

								Pavel
PS: Do you have diff between "linux-power" tree and linus available
somewhere? On http://developer.osdl.org/~mochel/patches/ latest I see
is -test5-mm3.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
