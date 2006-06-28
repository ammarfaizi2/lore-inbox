Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWF1UtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWF1UtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWF1UtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:49:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19975 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751519AbWF1UtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:49:24 -0400
Date: Wed, 28 Jun 2006 22:49:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: [2.6 patch] i386: KEXEC must depend on (!SMP && X86_LOCAL_APIC)
Message-ID: <20060628204922.GM13915@stusta.de>
References: <20060628165533.GJ13915@stusta.de> <m14py5fajw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m14py5fajw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 11:35:15AM -0600, Eric W. Biederman wrote:
> 
> Adrian Bunk <bunk@stusta.de> writes:
> > This patch fixes the following issue with CONFIG_SMP=y and 
> > CONFIG_X86_VOYAGER=y:
> >
> > <--  snip  -->
> >
> > ...
> >   CC      arch/i386/kernel/crash.o
> > arch/i386/kernel/crash.c: In function ‘crash_nmi_callback’:
> > arch/i386/kernel/crash.c:113: error: implicit declaration of function
> > ‘disable_local_APIC’
> >
> > <--  snip  -->
> 
> I think the patch below more correctly captures the dependency.
> 
> In truth that call to disable_local_APIC() is a bug but the kernel
> isn't ready yet to boot in apic only mode, so it remains until
> the apic initialization can be moved into init_IRQ.
> 
> Does this sound good?

It does compile (I can't test it due to lack of hardware).

> Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

