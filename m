Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268470AbTBWOXL>; Sun, 23 Feb 2003 09:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTBWOXL>; Sun, 23 Feb 2003 09:23:11 -0500
Received: from mail.ithnet.com ([217.64.64.8]:40978 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S268470AbTBWOXK>;
	Sun, 23 Feb 2003 09:23:10 -0500
Date: Sun, 23 Feb 2003 15:33:16 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030223153316.262a201e.skraw@ithnet.com>
In-Reply-To: <200302061451.h16Epl0Z001134@pc.skynet.be>
References: <20030202153009$2e0d@gated-at.bofh.it>
	<20030205181006$107c@gated-at.bofh.it>
	<20030205181006$7bb8@gated-at.bofh.it>
	<20030205181006$455c@gated-at.bofh.it>
	<20030205181006$5dba@gated-at.bofh.it>
	<20030205181006$3358@gated-at.bofh.it>
	<200302061451.h16Epl0Z001134@pc.skynet.be>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Feb 2003 15:51:47 +0100
Hans Lambrechts <hans.lambrechts@skynet.be> wrote:

> Stephan von Krawczynski wrote:
> 
> <---snip--->
> 
> > 
> >            CPU0       CPU1
> >   0:      71158          0    IO-APIC-edge  timer
> >   1:        941          0    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >  12:      33166          0    IO-APIC-edge  PS/2 Mouse
> >  15:          4          0    IO-APIC-edge  ide1
> >  17:       1732          0   IO-APIC-level  ide2, ide3
> >  18:       3423          0   IO-APIC-level  eth0, eth1
> >  21:       8177          0   IO-APIC-level  eth2
> >  22:     112943          0   IO-APIC-level  aic7xxx
> >  23:         16          0   IO-APIC-level  aic7xxx
> >  25:         74          0   IO-APIC-level  HiSax
> >  26:          0          0   IO-APIC-level  EMU10K1
> > NMI:          0          0
> > LOC:      71085      71059
> > ERR:          0
> > MIS:          0
> > 
> > ??
> > (kernel 2.4.21-pre4)
> 
> Stephan,
> this patch should fix the interrupt problem.
> 
> Marcelo, please apply.
> 
> Greetings,
> Hans Lambrechts
> 
> 
> --- linux/include/asm-i386/smpboot.h    2003-01-20 16:45:13.000000000 +0100
> +++ linux/include/asm-i386/smpboot.h.orig       2003-01-20 
> 16:44:05.000000000 +0100
> @@ -116,6 +116,6 @@
>         return cpu_online_map;
>  }
>  #else
> -#define target_cpus() (0xFFFFFFFF)
> +#define target_cpus() (0x01)
>  #endif
>  #endif

I am sorry, but this patch is:
a) already included in 2.4.21-pre4 (which I run)
b) does therefore obviously not help

Any other suggestions? 


-- 
Regards,
Stephan
