Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVATPzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVATPzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVATPzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:55:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45586 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262160AbVATPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:51:00 -0500
Date: Thu, 20 Jan 2005 16:50:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/29] x86_64-kexec
Message-ID: <20050120155054.GD3170@stusta.de>
References: <x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com> <x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com> <x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com> <x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com> <kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com> <x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com> <x86-kexec-11061198971773@ebiederm.dsl.xmission.com> <x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com> <x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com> <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 12:31:37AM -0700, Eric W. Biederman wrote:
>...
> --- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/crash.c	Wed Dec 31 17:00:00 1969
> +++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/crash.c	Tue Jan 18 23:14:06 2005
>...
> +note_buf_t crash_notes[NR_CPUS];
>...

After your patches, this global variable stays completely unused
on x86_64 (for the i386 version, you added a usage).

cu
Adrian

BTW: Is external usage for crash_notes planned, or can it become static 
     on both architectures?

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

