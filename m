Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279925AbRKBB4i>; Thu, 1 Nov 2001 20:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279926AbRKBB43>; Thu, 1 Nov 2001 20:56:29 -0500
Received: from codepoet.org ([166.70.14.212]:35946 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S279925AbRKBB4U>;
	Thu, 1 Nov 2001 20:56:20 -0500
Date: Thu, 1 Nov 2001 18:56:22 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011101185622.A20668@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <3BE1271C.6CDF2738@mandrakesoft.com> <20011102124252.1032e9b2.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011102124252.1032e9b2.rusty@rustcorp.com.au>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 02, 2001 at 12:42:52PM +1100, Rusty Russell wrote:
> On Thu, 01 Nov 2001 05:42:36 -0500
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
> > Is this designed to replace sysctl?
> 
> Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.

As I've thought about this in the past, I realized that /proc 
is serving two purposes.  It is exporting the list of processes,
and it is also used to export kernel and driver information.

What we really need is for procfs to be just process stuff, and the
creation of a separate kernelfs nodev filesystem though which
the kernel can share all the gory details about the hardware,
drivers, phase of the moon, etc.   Since these serve two
fundamentally different tasks, doesn't it make sense to split
them into two separate filesystems?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
