Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278732AbRKHWjd>; Thu, 8 Nov 2001 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKHWjW>; Thu, 8 Nov 2001 17:39:22 -0500
Received: from quark.didntduck.org ([216.43.55.190]:43532 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S278690AbRKHWjO>; Thu, 8 Nov 2001 17:39:14 -0500
Message-ID: <3BEB0986.BA2D5DFD@didntduck.org>
Date: Thu, 08 Nov 2001 17:39:02 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: David Chandler <chandler@grammatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <Pine.LNX.3.95.1011108162912.239A-100000@chaos.analogic.com> <3BEAFFC6.EAC56763@grammatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chandler wrote:
> 
> I get a seg fault on both 2.2 and 2.4 kernels by running the following
> one-line C program:
>         int main() { int k =  (int *)0x0; }
> 
> Debugging the offender,
>         int main() { int k =  (int *)0xc0000000; }
> is not very informative: single-stepping over the sole command just
> hangs, and you have to press Control-C to interrupt gdb, at which point
> you can single-step right into the same problem again.
> 
> When the program hangs, 'top' says that the CPU is fully utilized and
> the system is spending 80% of its time in the kernel and 20% in the
> offending process.
> 
> Have you not been able to duplicate it on a 2.4 kernel on x86?  If not,
> please tell me which 2.4 kernel correctly seg faults.

How about address 0xc0001000?  I have been unable to reproduce this on a
PII running 2.4.9, and an Athlon running 2.4.14.

--

				Brian Gerst
