Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbUC3SrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUC3SrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:47:13 -0500
Received: from fmr06.intel.com ([134.134.136.7]:61328 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263814AbUC3SrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:47:07 -0500
From: Mark Gross <mgross@linux.co.intel.com>
Organization: Intel
To: "Justin Piszcz" <jpiszcz@hotmail.com>, mgross@linux.co.intel.com
Subject: Re: Linux Kernel 2.6.4 - APIC Errors
Date: Tue, 30 Mar 2004 10:45:54 -0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Law10-F51AWiZAtGYkN0001a59c@hotmail.com> <200403301042.23600.mgross@linux.intel.com>
In-Reply-To: <200403301042.23600.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301045.54537.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 10:42, Mark Gross wrote:
> You stinker ;)
>
> I replied to your email off list cuz I used to work with Al about 100 years
> ago in Utica NY.
>
> I did trace the source of the kprint to the apic code. 
> arch/i386/kernel/apic.c; smp_error_interrupt 0x40 is APIC error bit 6
> "Illegal register addres" from the code comments.
>
> The interrupt handler gets installed through some tricky BS code, see
> include/asm-i386/mach-arch/entry_arch.h using a macro BUILD_INTERRUPT that
> insalls the error_interrupt by prefixing the "smp_" at compile time.
>
> I'd say something strange is going on with some driver touching the APIC,
> but I'm no expert.

ummm, thats "	   6: Received illegal vector "  You have noise on your hardware.

--mgross

