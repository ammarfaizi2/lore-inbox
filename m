Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWBKJqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWBKJqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWBKJqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:46:18 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:20754 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751177AbWBKJqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:46:18 -0500
Date: Sat, 11 Feb 2006 10:46:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fix s390 build failure.
Message-ID: <20060211094603.GA9316@osiris.boeblingen.de.ibm.com>
References: <20060210200425.GA11913@redhat.com> <Pine.LNX.4.64.0602101314082.19172@g5.osdl.org> <20060210212711.GD31949@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210212711.GD31949@redhat.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 04:27:11PM -0500, Dave Jones wrote:
> 
> arch/s390/kernel/compat_signal.c:199: error: conflicting types for 'do_sigaction'
> include/linux/sched.h:1115: error: previous declaration of 'do_sigaction' was here
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c~	2006-02-10 12:47:57.000000000 -0500
> +++ linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c	2006-02-10 12:48:05.000000000 -0500
> @@ -196,7 +196,4 @@ sys32_sigaction(int sig, const struct ol
>  }
>  
> -int
> -do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
> -
>  asmlinkage long
>  sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
> -

Hmm.. I sent the same patch earlier to Andrew already. To whom should I send
simple compile fixes? I thought I'm supposed to send all patches to Andrew
first?!

Anyway, the patch s390-compat-signal-compile-fix.patch can be removed from
the -mm tree.

Thanks,
Heiko
