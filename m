Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280275AbRKIXK5>; Fri, 9 Nov 2001 18:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280281AbRKIXKs>; Fri, 9 Nov 2001 18:10:48 -0500
Received: from pc3-redb4-0-cust118.bre.cable.ntl.com ([213.106.223.118]:49903
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S280275AbRKIXKj>; Fri, 9 Nov 2001 18:10:39 -0500
Date: Fri, 9 Nov 2001 23:10:37 +0000
From: Mark Zealey <mark@zealos.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011109231037.C25361@itsolve.co.uk>
In-Reply-To: <20011109223053.A964@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111092247070.14996-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111092247070.14996-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Fri, Nov 09, 2001 at 10:54:10PM +0000
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 10:54:10PM +0000, Riley Williams wrote:

> Hi Pavel.
> 
> >>>> According to your comments, you prefer (2).
> >>>> I most definitely prefer (1).
> 
> >>> Hmm, and if some malicious software insmods kernel module to
> >>> work around your printk()?
> 
> >> ...it gets "Port busy" when it tries to access the RTC ports that the
> >> RTC driver built into the kernel already has opened exclusively. At
> >> least, that's my understanding of the situation at present.
> 
> > It does not work that way. Userland does iopl(0), and then it just
> > bangs any port it wants to.
> 
> If any user can do that, then Linux is borken solid.
> 
> Just out of curiosity, what is wrong with the idea of having the kernel
> at iopl(0), any kernel modules at either iopl(1) or iopl(2) and apps at
> iopl(3) ??? There is obviously something, but I've no idea what.

Kernel stuff (kernel, modules) run at iopl(0). Only root programs can request
iopl(0) for itself, otherwise all hell would break loose (eg, user 'nobody'
writing to the hdd etc...)

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
