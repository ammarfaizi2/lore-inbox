Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTDLT3g (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTDLT3g (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:29:36 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:39058
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263384AbTDLT3d (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 15:29:33 -0400
To: "T. Weyergraf" <kirk@colinet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 alpha compile failure
References: <kirk-1030412154541.A0214377@hydra.colinet.de>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 12 Apr 2003 21:42:00 +0200
In-Reply-To: <kirk-1030412154541.A0214377@hydra.colinet.de>
Message-ID: <yw1xllyfv6yf.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"T. Weyergraf" <kirk@colinet.de> writes:

> kernel 2.5.67 fails to compile on alpha ( DP264, SMP ):
> 
> [...]
>   gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sys -DKBUILD_MODNAME=sys -c -o kernel/sys.o kernel/sys.c
> kernel/sys.c:226: conflicting types for `sys_sendmsg'
> include/linux/socket.h:245: previous declaration of `sys_sendmsg'
> kernel/sys.c:227: conflicting types for `sys_recvmsg'
> include/linux/socket.h:246: previous declaration of `sys_recvmsg'
> make[1]: *** [kernel/sys.o] Error 1
> make: *** [kernel] Error 2
> 
> Obviously, commenting-out those declarations fixes the compile problem and the rest of the
> build passes just fine.
> This problem is new to me. 2.5.64 and 65 do not have it.
> 
> My question is: Is commenting-out the declarations the Correct Way (TM) ?
> I don't think so ...

See my message with subject "[PATCH] Fix cond_syscall macro on Alpha".

-- 
Måns Rullgård
mru@users.sf.net
