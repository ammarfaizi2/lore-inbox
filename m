Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbQKAMWh>; Wed, 1 Nov 2000 07:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbQKAMWR>; Wed, 1 Nov 2000 07:22:17 -0500
Received: from ns.dce.bg ([212.50.14.242]:57360 "HELO home.dce.bg")
	by vger.kernel.org with SMTP id <S130391AbQKAMWN>;
	Wed, 1 Nov 2000 07:22:13 -0500
Message-ID: <3A000ADC.43DEB50C@dce.bg>
Date: Wed, 01 Nov 2000 14:21:48 +0200
From: Petko Manolov <petkan@dce.bg>
Organization: Deltacom Electronics
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: mdaljeet@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: system call handling
In-Reply-To: <CA25698A.00434741.00@d73mta05.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com wrote:
> 
> Hi,
> 
> By looking into the structure of GDT as used by linux kernel(file
> include/asm/desc.c, kernel ver 2.4), it appears as if linux kernel does not
> use the "call gate descriptors" for system call handling. Is this correct?

You're looking at wrong place. Look at linux/arch/i386/kernel/traps.c
 
> If it is correct then how does the system calls are handled by the kernel
> (basically how does the control gets transferred to kernel)? Does the CS of
> linux kernel handles the system calls? what are the advantages of using
> this scheme?

System calls in Linux are performed as an interrupt gate (0x80). It is
not
necessary to use call gate. On i386 arch both are almost identical.


	Petkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
