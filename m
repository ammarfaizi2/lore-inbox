Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbRERN3m>; Fri, 18 May 2001 09:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbRERN3c>; Fri, 18 May 2001 09:29:32 -0400
Received: from [203.237.41.6] ([203.237.41.6]:13953 "EHLO bellini.kjist.ac.kr")
	by vger.kernel.org with ESMTP id <S262309AbRERN3Y>;
	Fri, 18 May 2001 09:29:24 -0400
Message-ID: <3B05232F.8C49D2A5@kjist.ac.kr>
Date: Fri, 18 May 2001 22:27:11 +0900
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
Organization: KJIST, Dept of Info. & Commun.
X-Mailer: Mozilla 4.75 [ko] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, ko
MIME-Version: 1.0
To: ja@ssi.bg, linux-kernel@vger.kernel.org
Subject: NETDEV WATCHDOG (Re: locked 3c905B with 2.4.5pre2)
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: locked 3c905B with 2.4.5pre2
> 
> From: Julian Anastasov (ja@ssi.bg)
> Date: Thu May 17 2001 - 04:22:15 EST
> 
>    * Next message: Karsten Keil: "Re: patch-2.2.19.gz"
>    * Previous message: David Wilson: "RE: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?"
>    * In reply to: Andrew Morton: "Re: locked 3c905B with 2.4.5pre2"
>    * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> 
>   ------------------------------------------------------------------------
> 
>         Hello,
> 
> On Thu, 17 May 2001, Andrew Morton wrote:
> 
> > > eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
> >
> > This is a failure of the APIC interrupt controller in
> > the 2.4 kernel. You'll need to boot your kernel with
> > the `noapic' LILO option. Or run -ac kernels, which
> > have a software workaround which fixes the problem.
> 
>         Yes, it seems noapic solved the problem with the lockup :(
> 
> > Rumour has it that the APIC fix will be merged into Linus' tree
> > very soon. It needs to be - one of the more important ethernet
> > drivers is basically unviable on x86 SMP in 2.4.
> 
>         Agreed :) The performance sucks without apic.
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>
> -
I used to get NETDEV WATCHDOG eth0:timeout error on 
Alpha SMP, too, with the tulip card.  Definitely, Alpha
has nothing to do with the x86 APIC.  Since then, I switched to
3C905B.

I suspect that NETDEV WATCHDOG error covers a broad class of 
network errors.

Does anyone know more about this?

Thank you

-- 
G. Hugh Song
