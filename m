Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUCRVXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbUCRVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:23:24 -0500
Received: from zero.aec.at ([193.170.194.10]:34055 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262951AbUCRVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:23:22 -0500
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
References: <1B0Ls-lY-27@gated-at.bofh.it> <1B42z-3Lx-5@gated-at.bofh.it>
	<1B4Fh-4sQ-3@gated-at.bofh.it> <1B86P-8gq-69@gated-at.bofh.it>
	<1Bars-2s6-29@gated-at.bofh.it> <1BaKU-2Lg-49@gated-at.bofh.it>
	<1BaKX-2Lg-61@gated-at.bofh.it> <1BaUR-2V0-41@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 22:23:18 +0100
In-Reply-To: <1BaUR-2V0-41@gated-at.bofh.it> (Ingo Molnar's message of "Thu,
 18 Mar 2004 20:00:37 +0100")
Message-ID: <m3r7vponnd.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> x86-64 has a VDSO page as well, [...]
>
> hm, i'm not sure this is the case. It does have a vsyscall page but
> doesnt fill out AT_SYSINFO. ia64 seems to have something like a vdso,
> passed down via AT_SYSINFO.

Yes, the x86-64 64bit vsyscalls predate all the vDSO work and haven't
been updated. It has a vDSO for 32bit programs though.

I guess it would be not that much work to add it for 64bit too. 
I would not be opposed to it if somebody sends me patches. 

This means my only objection is that an dwarf2 unwind table written
without the .cfi_* support in the assembler is incredibly ugly and
unmaintainable. I really don't want to have more such ugly tables.  I
guess it would be best to force an binutils update for dwarf2
information.

-Andi

