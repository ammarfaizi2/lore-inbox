Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269890AbRHJCCN>; Thu, 9 Aug 2001 22:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269891AbRHJCCC>; Thu, 9 Aug 2001 22:02:02 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:41741 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S269890AbRHJCBp>; Thu, 9 Aug 2001 22:01:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: kapm-idled shows 90+% cpu usage when idle
Date: Thu, 9 Aug 2001 22:01:55 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108100036.CAA09153@harpo.it.uu.se>
In-Reply-To: <200108100036.CAA09153@harpo.it.uu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010810020152Z269890-28344+3523@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 August 2001 20:36, Mikael Pettersson wrote:
> On Thu, 9 Aug 2001 19:33:42 -0400, safemode <safemode@speakeasy.net> wrote:
> >Is this a true usage reading or just some quirk that's supposed to happen?
> >I really doubt that this kernel daemon should really be using  cpu.  It
> > seems to respond with a higher cpu usage when i'm idle.  It immediately
> > goes away when something else uses cpu.   If you need any more info just
> > ask.   I'm
>
> Do you have CONFIG_APM_CPU_IDLE=y in your .config? If so, disable it.
>
> There was a thread about this problem some months ago. I found
> that on all of my APM-capable machines, including a Dell laptop,
> CONFIG_APM_CPU_IDLE=y had a negative effect. The kernel ended up
> in a tight loop performing tons of APM IDLE BIOS calls, since each
> BIOS call returned immediately without having idled the CPU.
>
> Leaving CONFIG_APM_CPU_IDLE unset lets the kernel use its own
> "HLT when idle" code. On my main development box, idle CPU
> temperature dropped >10 degrees C, and kapm-idled now uses 0% CPU.
>
> /Mikael

I've been told by others that this is exactly what's supposed to happen.  It 
acts like it's using cpu when it's idle and does it job that way.  I see no 
difference either way.   I'm using a KA7 motherboard and it says it supports 
apm and lspci shows what i pasted in the original post.  Oh well, it's not 
causing the cpu to generate more heat than it would be idle.  
