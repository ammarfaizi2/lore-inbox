Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUICDxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUICDxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268990AbUIBUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:21:16 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:31296 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268421AbUIBUR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:17:26 -0400
Date: Thu, 2 Sep 2004 22:19:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mart?n Chikilian <slack@efn.uncor.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird problem when compiling kernel
Message-ID: <20040902201945.GB15298@mars.ravnborg.org>
Mail-Followup-To: Mart?n Chikilian <slack@efn.uncor.edu>,
	linux-kernel@vger.kernel.org
References: <4135C57C.9080604@efn.uncor.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4135C57C.9080604@efn.uncor.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 09:50:04AM -0300, Mart?n Chikilian wrote:
> Hello linux-kernel:
> I'm running Linux Slackware 10.0, kernel 2.6.7. I compiled such kernel 
> when using Slackware 9.1, and after i *upgraded* to 10.0 and tried to 
> compile 2.6.8.1, i noticed that i couldn't do that. When i wanted to 
> modify my 2.6.7 configuration and tried to compile it again, i noticed 
> that i couldn't do it either.
> I tried with all flavors off gcc, binutils, etc
> So, there is my prob.
> Error is:
> *rm -rf .tmp_versions
> mkdir -p .tmp_versions
> make -f scripts/Makefile.build obj=scripts/basic
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=arch/i386/kernel 
> arch/i386/kernel/asm-offsets.s
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> make -f scripts/Makefile.build obj=init
> make -f scripts/Makefile.build obj=usr
>   ld -m elf_i386  -r -o usr/built-in.o
> ld: no input files
> scripts/Makefile.build:229: *** [usr/built-in.o] Error 1
> Makefile:600: *** [usr] Error 2
> --
> When make V=1.
> .config is in http://jumper.bounceme.net:81/slackatefn/.config
> 
> gcc version: 3.4.1, make: 3.80, binutils: 2.15.90.0.3
> I would appreciate any help/suggestion/hint.


Please try to do:
rm usr/*o
make V=1

and post output.

Also please check that you have gzip in your path.


Your .config was far away from a valid 2.6.8.1 .config??

	Sam
