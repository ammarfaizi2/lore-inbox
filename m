Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTILSZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTILSWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:22:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16324 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261841AbTILSWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:22:23 -0400
Date: Fri, 12 Sep 2003 20:22:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       akpm@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030912182216.GK27368@fs.tum.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030910184414.7850be57.akpm@osdl.org> <20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F62098F.9030300@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 01:59:43PM -0400, Jeff Garzik wrote:
> Andi Kleen wrote:
> >The main reason I'm really against this is that currently the P4 kernels 
> >work
> >fine on Athlon. Just when is_prefetch is not integrated in them there will 
> >be an mysterious oops once every three months in the kernel in prefetch
> >on Athlon.
> 
> 
> Booting a P4 kernel _without_ CONFIG_X86_GENERIC on an Athlon would be a 
> user bug.

But even CONFIG_X86_GENERIC doesn't do what you expect. A kernel 
compiled for Athlon wouldn't run on a Pentium 4 even with 
CONFIG_X86_GENERIC.

Quoting arch/i386/Kconfig in -test5:

<--  snip  -->

config X86_USE_3DNOW
        bool
        depends on MCYRIXIII || MK7
        default y

<--  snip  -->

My patch in the mail

  RFC: [2.6 patch] better i386 CPU selection

tries to solve these problem with a different approach (the user selects 
all CPUs he wants to support).

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

