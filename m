Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312826AbSDEOdp>; Fri, 5 Apr 2002 09:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312830AbSDEOdZ>; Fri, 5 Apr 2002 09:33:25 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:13586 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312826AbSDEOdY>;
	Fri, 5 Apr 2002 09:33:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Fri, 05 Apr 2002 14:29:23 +0100."
             <20020405142923.B7061@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 00:33:12 +1000
Message-ID: <8645.1018017192@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002 14:29:23 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Fri, Apr 05, 2002 at 10:52:43PM +1000, Keith Owens wrote:
>> On a smaller config (full config takes too long when single threaded).
>> 
>> kbuild 2.4:
>> 	make oldconfig dep bzImage modules	6:25
>> 	make bzImage modules (no changes)	0:22
>> 
>> kbuild 2.5:
>> 	make oldconfig installable		4:45
>> 	make installable (no changes)		0:16
>
>How does it compare in (ahem) 32-64MB machines?

You could always try it yourself, but ...

Same .config, on a Pentium III (Coppermine) 1090 Bogomips, 2.4.18 SMP
kernel booted with maxcpus=1, mem=32M.

kbuild 2.4:
 	make oldconfig dep bzImage modules     15:11
 	make bzImage modules (no changes)	0:33
 
kbuild 2.5:
 	make oldconfig installable		13:33
 	make installable (no changes)		 0:33

Even at 32MB, kbuild 2.5 is slightly faster.

