Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWBKJwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWBKJwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWBKJwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:52:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751391AbWBKJwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:52:03 -0500
Date: Sat, 11 Feb 2006 01:51:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix s390 build failure.
Message-Id: <20060211015114.28b06319.akpm@osdl.org>
In-Reply-To: <20060211094603.GA9316@osiris.boeblingen.de.ibm.com>
References: <20060210200425.GA11913@redhat.com>
	<Pine.LNX.4.64.0602101314082.19172@g5.osdl.org>
	<20060210212711.GD31949@redhat.com>
	<20060211094603.GA9316@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> On Fri, Feb 10, 2006 at 04:27:11PM -0500, Dave Jones wrote:
> > 
> > arch/s390/kernel/compat_signal.c:199: error: conflicting types for 'do_sigaction'
> > include/linux/sched.h:1115: error: previous declaration of 'do_sigaction' was here
> > 
> > Signed-off-by: Dave Jones <davej@redhat.com>
> > 
> > --- linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c~	2006-02-10 12:47:57.000000000 -0500
> > +++ linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c	2006-02-10 12:48:05.000000000 -0500
> > @@ -196,7 +196,4 @@ sys32_sigaction(int sig, const struct ol
> >  }
> >  
> > -int
> > -do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
> > -
> >  asmlinkage long
> >  sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
> > -
> 
> Hmm.. I sent the same patch earlier to Andrew already. To whom should I send
> simple compile fixes?

You can copy Linus - sometimes he applies things ;) If not, I'll catch it.

> Anyway, the patch s390-compat-signal-compile-fix.patch can be removed from
> the -mm tree.

That's fine - I'll autodrop it next time I sync with Linus.

I've been a bit sluggish with the s390 patches while waiting for you and
Christoph to sort things out.  I'm thinking of holding off on
s390-add-missing-validation-for-dasd-discipline-specific-ioctls.patch and
s390-cleanup-of-dasd-eer-module.patch.
