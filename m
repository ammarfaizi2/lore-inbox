Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269958AbRHJRhe>; Fri, 10 Aug 2001 13:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269962AbRHJRhY>; Fri, 10 Aug 2001 13:37:24 -0400
Received: from [63.194.239.202] ([63.194.239.202]:15090 "EHLO
	mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S269958AbRHJRhM>; Fri, 10 Aug 2001 13:37:12 -0400
Date: Fri, 10 Aug 2001 10:36:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled shows 90+% cpu usage when idle
Message-ID: <20010810103649.D28914@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200108100036.CAA09153@harpo.it.uu.se> <20010810020152Z269890-28344+3523@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010810020152Z269890-28344+3523@vger.kernel.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, 9 Aug 2001 19:33:42 -0400, safemode <safemode@speakeasy.net> wrote:
> > >Is this a true usage reading or just some quirk that's supposed to happen?
> > >I really doubt that this kernel daemon should really be using  cpu.  It
> > > seems to respond with a higher cpu usage when i'm idle.  It immediately
> > > goes away when something else uses cpu.   If you need any more info just
> > > ask.   I'm
> >

> On Thursday 09 August 2001 20:36, Mikael Pettersson wrote:
> > Do you have CONFIG_APM_CPU_IDLE=y in your .config? If so, disable it.
> >
> > There was a thread about this problem some months ago. I found
> > that on all of my APM-capable machines, including a Dell laptop,
> > CONFIG_APM_CPU_IDLE=y had a negative effect. The kernel ended up
> > in a tight loop performing tons of APM IDLE BIOS calls, since each
> > BIOS call returned immediately without having idled the CPU.
> >
> > Leaving CONFIG_APM_CPU_IDLE unset lets the kernel use its own
> > "HLT when idle" code. On my main development box, idle CPU
> > temperature dropped >10 degrees C, and kapm-idled now uses 0% CPU.
> >
> > /Mikael
> 

On Thu, Aug 09, 2001 at 10:01:55PM -0400, safemode wrote:
> I've been told by others that this is exactly what's supposed to happen.  It 
> acts like it's using cpu when it's idle and does it job that way.  I see no 
> difference either way.   I'm using a KA7 motherboard and it says it supports 
> apm and lspci shows what i pasted in the original post.  Oh well, it's not 
> causing the cpu to generate more heat than it would be idle.  

If you don't see any benefit, I'd disable it just because of the modified
results from top...
