Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276381AbRJKPWx>; Thu, 11 Oct 2001 11:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJKPWo>; Thu, 11 Oct 2001 11:22:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40169 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276381AbRJKPW1>; Thu, 11 Oct 2001 11:22:27 -0400
Date: Thu, 11 Oct 2001 08:22:02 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roman Kagan <Roman.Kagan@itep.ru>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 APIC problems - please apply patch
Message-ID: <2061142806.1002788522@[10.10.1.2]>
In-Reply-To: <15301.19500.30733.197896@jaguar.itep.ru>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't claim I understand whether it is right or wrong, but the
> following patch can fix _my_ problem:

This is right ... mea culpa. I tried to fix things too fast.

On the other hand, I don't see why it wouldn't work ... and indeed
it did work for people who originally tested it, but it's not what I intended 
to do, and it's an unnecesary change from previous kernels.
 
> --- linux/include/asm-i386/smp.h.int_delivery	Wed Oct 10 13:36:11 2001
> +++ linux/include/asm-i386/smp.h	Wed Oct 10 18:17:06 2001
> @@ -31,7 +31,7 @@
>  #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
>  # endif
>  #else
> -# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
> +# define INT_DELIVERY_MODE 1     /* logical delivery */
>  # define TARGET_CPUS 0x01
>  #endif

Linus - can you add this fix? I intended to keep the UP+IO_APIC
setup as before.

Sorry,

Martin.

