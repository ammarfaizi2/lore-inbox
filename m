Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKHXPp>; Thu, 8 Nov 2001 18:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKHXP0>; Thu, 8 Nov 2001 18:15:26 -0500
Received: from cayuga.grammatech.com ([209.4.89.66]:38414 "EHLO grammatech.com")
	by vger.kernel.org with ESMTP id <S278818AbRKHXPR>;
	Thu, 8 Nov 2001 18:15:17 -0500
Message-ID: <3BEB11FC.BF3D5E30@grammatech.com>
Date: Thu, 08 Nov 2001 18:15:08 -0500
From: David Chandler <chandler@grammatech.com>
Organization: GrammaTech, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <Pine.LNX.3.95.1011108162912.239A-100000@chaos.analogic.com> <3BEAFFC6.EAC56763@grammatech.com> <3BEB0986.BA2D5DFD@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0xc0001000 hangs the same way that 0xc0000000 does.  I have reproduced
this on a 2.4.9+UML kernel running in user-mode linux on top of a
Pentium-4 2.4.2-2(RedHat) host.  'top' says that 75% of CPU is going to
the system in that case also.

Please Cc: me on any replies.


David Chandler
--
_____
David L. Chandler.                              GrammaTech, Inc.
mailto:chandler@grammatech.com         http://www.grammatech.com



Brian Gerst wrote:
> 
> David Chandler wrote:
> >
> > Debugging the offender,
> >         int main() { int k =  (int *)0xc0000000; }
> > is not very informative: single-stepping over the sole command just
> > hangs, and you have to press Control-C to interrupt gdb, at which point
> > you can single-step right into the same problem again.
> >
> > When the program hangs, 'top' says that the CPU is fully utilized and
> > the system is spending 80% of its time in the kernel and 20% in the
> > offending process.
> >
> > Have you not been able to duplicate it on a 2.4 kernel on x86?  If not,
> > please tell me which 2.4 kernel correctly seg faults.
> 
> How about address 0xc0001000?  I have been unable to reproduce this on a
> PII running 2.4.9, and an Athlon running 2.4.14.
> 
> --
> 
>                                 Brian Gerst
