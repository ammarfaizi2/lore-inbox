Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTLKGBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTLKGBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:01:37 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:25801 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S264353AbTLKGBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:01:35 -0500
Date: Thu, 11 Dec 2003 01:01:32 -0500
From: Raul Miller <moth@magenta.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211010132.F28449@links.magenta.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>; from donjr@maner.org on Wed, Dec 10, 2003 at 11:06:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:06:46PM -0600, Donald Maner wrote:
> The kernel you're using WAS compiled with CONFIG_HIGHMEM4G=y, correct?

No.


On Thu, Dec 11, 2003 at 04:13:25PM +1100, Nick Piggin wrote:
> Or ARCH=x86_64 ?

Yes.  Well, no... I don't see that option in my .config.  I
did specify the amd64 bit archictecture, but I don't know
what that means in .config terms.  Here's what's set under
"# Processor type and features":

CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

On Thu, Dec 11, 2003 at 04:48:51PM +1100, Nick Piggin wrote:
> At any rate, Raul, highmem shouldn't hurt your performance significantly
> with the 2.6 kernel. If it does then send a note to the list.

Ok, I guess I'll try that (tomorrow, unless I hear any better suggestions
before then).

[I thought highmem was something completely different -- that it declared
a watermark and memory above that watermark was treated differently.
However, I guess I understand that this might have the side effect of
bumping things around such that I get access to the memory.]

Thanks,

-- 
Raul Miller
moth@magenta.com
