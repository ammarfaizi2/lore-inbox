Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALDue>; Thu, 11 Jan 2001 22:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRALDuR>; Thu, 11 Jan 2001 22:50:17 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:45529 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132637AbRALDt5>; Thu, 11 Jan 2001 22:49:57 -0500
Message-ID: <3A5E7EC4.39CC7298@Home.net>
Date: Thu, 11 Jan 2001 22:49:24 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] 2.4.1-pre2 - Undefined symbol `__buggy_fxsr_alignment' - 
 (FIXED)
In-Reply-To: <3A5E4B1D.5EF1B0EB@Home.net> <3A5E7DB2.A7126A68@Home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

errrr i think it was just fixed in pre3 ;-)

+       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
+               extern void __buggy_fxsr_alignment(void);
+               __buggy_fxsr_alignment();
+       }


> GCC 2.95.2 -> PGCC 2.95.2(3?) patched. 2.4.0 compiles fine
>
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
>
> make: *** [vmlinux] Error 1
>
> On compiling (and recompiling) i get this fatal error. This function
> does not exist anymore?
>
> Anyone else having this problem?
>
> Shawn Starr.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
