Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUIPOwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUIPOwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPOwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:52:33 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:54239 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268101AbUIPOw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:52:28 -0400
Date: Thu, 16 Sep 2004 16:52:27 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>,
       GNU Libc Maintainers <debian-glibc@lists.debian.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `new' syscalls for m68k
Message-ID: <20040916145227.GB28893@MAIL.13thfloor.at>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
	uClinux list <uclinux-dev@uclinux.org>,
	GNU Libc Maintainers <debian-glibc@lists.debian.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409102250300.24607@anakin> <Pine.GSO.4.58.0409161016400.23693@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0409161016400.23693@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:23:08AM +0200, Geert Uytterhoeven wrote:
> On Fri, 10 Sep 2004, Geert Uytterhoeven wrote:
> > I'm updating the syscall table for m68k...
> >
> > Below is a patch that adds all syscalls that m68k is currently lacking
> > (compared to ia32). However, I'm wondering whether we need all of them:
> >   - Are sys_sched_[gs]etaffinity() needed for non-SMP?
> >   - I disabled [sg]et_thread_area() since sys_[gs]et_thread_area() are
> >     missing. Do we have to implement them, or should we use some other
> >     method for Thread Local Storage?
> >   - What about sys_vserver()?
> >   - What about sys_kexec_load()?
> >   - Any others we can/should drop?
> 
> My conclusion (so far). I will:
>   - drop sys_sched_[gs]etaffinity() (no SMP on m68k), and sys_kexec_load()
>   - reserve an entry for sys_vserver()

thanks,
Herbert

>   - add waitid() (2.6.9-rc2)
>   - rename p{read,write}64() to p{read,write} (cfr. m68knommu in 2.6.8.1-uc0)
> 
> Which leaves us with [sg]et_thread_area(): what do the glibc hackers have in
> mind for TLS on m68k?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
