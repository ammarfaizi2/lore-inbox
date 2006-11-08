Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423682AbWKHUuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682AbWKHUuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423712AbWKHUuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:50:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63158 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423699AbWKHUuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:50:16 -0500
Date: Wed, 8 Nov 2006 15:49:48 -0500
From: Alan Cox <alan@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, alan@redhat.com,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Michael Kerrisk <mtk-manpages@gmx.net>
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Message-ID: <20061108204948.GC20284@devserv.devel.redhat.com>
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:00:10PM -0700, Eric W. Biederman wrote:
> Now that I know there are a few real users the only sane way to
> proceed with deprecation is to push the time limit out to a year or
> two work and work with distributions that have big testing pools like
> fedora core to find these last remaining users.

Some early boot code needs to know the kernel version and
it needs to do it before /proc is mounted and potentially in order
to run mount. In places it has its role but only in places.

> diff --git a/init/Kconfig b/init/Kconfig
> index c8b2624..e85e554 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -304,7 +304,7 @@ config UID16
>  
>  config SYSCTL_SYSCALL
>  	bool "Sysctl syscall support" if EMBEDDED
> -	default n
> +	default y
>  	select SYSCTL
>  	---help---
>  	  Enable the deprecated sysctl system call.  sys_sysctl uses
> -- 
> 1.4.2.rc3.g7e18e-dirty

Acked-by: Alan Cox <alan@redhat.com>
