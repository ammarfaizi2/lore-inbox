Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbRGHRJj>; Sun, 8 Jul 2001 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbRGHRJT>; Sun, 8 Jul 2001 13:09:19 -0400
Received: from ns.suse.de ([213.95.15.193]:40197 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266933AbRGHRJL>;
	Sun, 8 Jul 2001 13:09:11 -0400
Date: Sun, 8 Jul 2001 19:09:11 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vibol Hou <vhou@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
In-Reply-To: <20010709050418.A28809@weta.f00f.org>
Message-ID: <Pine.LNX.4.30.0107081907440.28660-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Chris Wedgwood wrote:

>     Actually you merged that with Linus a few revisions back iirc.
> I don't see it for K7/AMD:

> cw:tty5@tapu(kernel)$ grep machine_check\(struct\ pt bluesmoke.c
> static void intel_machine_check(struct pt_regs * regs, long error_code)

There is no K7 specific implementation. It's the same as the Intel MSRs.

>From the comment in the file:

        case X86_VENDOR_AMD:
            /*
             *  AMD K7 machine check is Intel like
             */
            if(c->x86 == 6)
                intel_mcheck_init(c);
            break;


regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

