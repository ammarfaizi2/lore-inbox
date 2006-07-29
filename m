Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWG2Qf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWG2Qf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWG2Qf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:35:28 -0400
Received: from mail.suse.de ([195.135.220.2]:14531 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751307AbWG2Qf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:35:27 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Date: Sat, 29 Jul 2006 18:35:54 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <20060729075414.GA16118@redhat.com>
In-Reply-To: <20060729075414.GA16118@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291835.54379.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 09:54, Dave Jones wrote:
> On Sat, Jul 29, 2006 at 03:00:06AM +0000, Linux Kernel wrote:
>  > commit c97d20a6c51067a38f53680d9609b4cf2867d077
>  > tree 59867ac01d1b752ba7e520e33f9f84cade6d024e
>  > parent b783fd925cdd56d24d164e5bdcb072f2a67aedf4
>  > author Andi Kleen <ak@suse.de> Fri, 28 Jul 2006 14:44:57 +0200
>  > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 29 Jul 2006
>  > 09:28:00 -0700
>  >
>  > [PATCH] i386: Do backtrace fallback too
>  >
>  > Similar patch to earlier x86-64 patch. When the dwarf2 unwinder fails
>  > dump the left over stack with the old unwinder.
>  >
>  > Also some clarifications in the headers.
>  >
>  > Signed-off-by: Andi Kleen <ak@suse.de>
>  > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>  >
>  >  arch/i386/kernel/traps.c |   17 ++++++++++++++---
>  >  1 files changed, 14 insertions(+), 3 deletions(-)
>
> Hmm, this breaks the build for me..

Hmm, it definitely builds here. Ah do you have UNWIND_INFO
disabled? 


> 	print_symbol("DWARF2 unwinder stuck at %s\n",
> 		UNW_PC(info.regs));
>
> be using %p ?

Yes good catch.

-Andi

