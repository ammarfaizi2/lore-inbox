Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272671AbRILG24>; Wed, 12 Sep 2001 02:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272676AbRILG2r>; Wed, 12 Sep 2001 02:28:47 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:15372 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S272671AbRILG2d>; Wed, 12 Sep 2001 02:28:33 -0400
Date: Wed, 12 Sep 2001 07:28:53 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Message-ID: <20010912072853.A479@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010912082935.A391@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010912082935.A391@localhost>; from vdb@mail.ru on Wed, Sep 12, 2001 at 08:29:35AM +0400
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 08:29:35AM +0400, Dmitry Volkoff wrote:
> >I don't have any problems with the kernel, but if I'm compiling (say) the
> >kernel or any large program, user-mode apps like gcc, make, etc all
> >randomly segfault on me.
> >
> >I'm running a Duron 800 on a Asus A7V133 mobo - and no bios version I've
> >tried has made a bit of difference yet :p
> 
> Same things here. I'm also experiencing random segfaults with kernels 
> 2.4.10pre[47]. My motherbord is Chaintech CT-7AIA2 (kt133A/686A), Duron 600.
> I did'nt see such things with kernels 2.4.[78]. The problem persists even 
> after recompiling kernel with K6-III optimisation. Note, this motherboard
> was rock solid and I never had any problems with athlon-optimised kernels
> prior to 2.4.9.
> 

A colleague purchased a number of A7V133s all of which exhibited seg faults
in make and gcc. make reproducibly seg faulted in vfork(). This was
with 2.2.18 kernels compiled for i586. We next tried a 2.4.8 kernel
built for i686 and the problem persisted, though less reproducibly. The
kernel reports 'Applying VIA southbridge workaround', but it looks
like we need another fix.

Most of the BIOS options had no effect, but changing the 'PCI latency'
setting from 32 to 64 seems to have fixed it, fingers crossed.

P.

-- 
+--------------------------------------------------+
| Peter Horton      | pdh@colonel-panic.org        |
| Software Engineer | http://www.colonel-panic.org |
+--------------------------------------------------+
