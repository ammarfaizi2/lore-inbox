Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbSIUIEf>; Sat, 21 Sep 2002 04:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275885AbSIUIEf>; Sat, 21 Sep 2002 04:04:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32497 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262535AbSIUIEf>;
	Sat, 21 Sep 2002 04:04:35 -0400
Message-ID: <3D8C2928.EC37FEC7@mvista.com>
Date: Sat, 21 Sep 2002 01:09:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Mikael Pettersson <mikpe@csd.uu.se>, Daniel Jacobowitz <dan@debian.org>,
       Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org> <20020919192434.GA3286@nevyn.them.org> <15754.12963.763811.307755@kim.it.uu.se> <3D8ADD05.999E4A5C@mvista.com> <20020920231946.B27148@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Fri, Sep 20, 2002 at 01:32:05AM -0700, george anzinger wrote:
> > So, is there a problem?  Yes, neither the call stub macros
> > in asm/unistd.h nor those in glibc bother to list the used
> > registers beyond the third ":".
> 
> No, this is not the real problem.  The real problem is that if
> the program receives a signal during a system call, the kernel
> will return all the way up to entry.S, deliver the signal and
> then restart the syscall.
> 
> Except the syscall will restart with the corrupted registers.
> 
> Hilarity ensues.
> 
I submit that BOTH of these are problems.  And only  the
kernel can fix the latter.

-g
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
