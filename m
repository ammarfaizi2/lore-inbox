Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTCMT6z>; Thu, 13 Mar 2003 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbTCMT6z>; Thu, 13 Mar 2003 14:58:55 -0500
Received: from havoc.daloft.com ([64.213.145.173]:22466 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262528AbTCMT6w>;
	Thu, 13 Mar 2003 14:58:52 -0500
Date: Thu, 13 Mar 2003 15:09:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, davej@suse.de, alan@redhat.com,
       torvalds@transmeta.com
Subject: Re: [PATCH] cpu/hw_random cleanups
Message-ID: <20030313200934.GA17643@gtf.org>
References: <20030313184343.GA7246@gtf.org> <3E70E4B8.2010600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E70E4B8.2010600@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 12:06:16PM -0800, H. Peter Anvin wrote:
> Jeff Garzik wrote:
> >For x86 experts, the new cpu cap words are what needs looking over.
> >For example, I wonder if storing Intel's cpuid(0x00000001) ecx
> >register output is wise on older Intel cpus.  I worry about garbage
> >appearing there.  Is that a false worry?
> >
> 
> Yes; it should be completely safe.

noted


> >===== arch/i386/kernel/cpu/centaur.c 1.7 vs edited =====
> >--- 1.7/arch/i386/kernel/cpu/centaur.c	Tue Mar 11 21:35:40 2003
> >+++ edited/arch/i386/kernel/cpu/centaur.c	Thu Mar 13 13:31:08 2003
> >@@ -256,9 +256,10 @@
> > 	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
> > 		set_bit(X86_FEATURE_CENTAUR_EFF, c->x86_capability);
> > 
> 
> There is also no need to set a special feature bit for the existence of 
> the feature flags.  If they are not present the additional capability 
> word will simply be zero.

Thanks, fixed.

	Jeff



