Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRK3SsN>; Fri, 30 Nov 2001 13:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280960AbRK3Srh>; Fri, 30 Nov 2001 13:47:37 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61958 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280956AbRK3SrY>; Fri, 30 Nov 2001 13:47:24 -0500
Message-ID: <3C07D1E3.15F77C98@evision-ventures.com>
Date: Fri, 30 Nov 2001 19:37:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Brian Gerst <bgerst@didntduck.org>, Simon Turvey <turveysp@ntlworld.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Generating a function call trace
In-Reply-To: <Pine.LNX.4.40.0111301035490.1600-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Fri, 30 Nov 2001, Brian Gerst wrote:
> 
> > Davide Libenzi wrote:
> > >
> > > On Fri, 30 Nov 2001, Simon Turvey wrote:
> > >
> > > > Is it possible to arbitrarily generate (in a module say) a function call
> > > > trace?
> > >
> > > gcc has builtin macros to trace back or ( on x86 ) you can simply chain
> > > through %esp/%ebp
> >
> > That only works if you compile with frame pointers, which the kernel
> > turns off for performance reasons (due to register pressure on the x86).
> 
> I thought it was a general question not a kernel code one.
> Sure -fomit-frame-pointer is on inside the kernel.

With the , well exception, of the scheduler, which does the task
switching by
overwriting his own return address on the stack by the address of the
next jump point in a process, and needs the frame
pointer therefore ;-).
