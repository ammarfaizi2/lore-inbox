Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265976AbRGHUkM>; Sun, 8 Jul 2001 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbRGHUkC>; Sun, 8 Jul 2001 16:40:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265976AbRGHUjy>; Sun, 8 Jul 2001 16:39:54 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
Date: 8 Jul 2001 13:39:29 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9iage1$1c6$1@cesium.transmeta.com>
In-Reply-To: <20010709050418.A28809@weta.f00f.org> <Pine.LNX.4.30.0107081907440.28660-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0107081907440.28660-100000@Appserv.suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Mon, 9 Jul 2001, Chris Wedgwood wrote:
> 
> >     Actually you merged that with Linus a few revisions back iirc.
> > I don't see it for K7/AMD:
> 
> > cw:tty5@tapu(kernel)$ grep machine_check\(struct\ pt bluesmoke.c
> > static void intel_machine_check(struct pt_regs * regs, long error_code)
> 
> There is no K7 specific implementation. It's the same as the Intel MSRs.
> 
> From the comment in the file:
> 
>         case X86_VENDOR_AMD:
>             /*
>              *  AMD K7 machine check is Intel like
>              */
>             if(c->x86 == 6)
>                 intel_mcheck_init(c);
>             break;
> 
> 

Note that I released a patch to make bluesmoke a lot more generic
quite a while ago.  Linus was in the "I don't want to even hear about
anything but critical bugfixes" mode at that point, so it didn't get
integrated.

If anyone is interested, it is at:

http://www.kernel.org/pub/linux/kernel/people/hpa/bluesmoke-2.4.0-test11-pre5-3.diff.gz

Let me know if you want me to bring it forward.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
