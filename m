Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVCNTt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVCNTt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVCNTt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:49:26 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:49161 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261772AbVCNTtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:49:19 -0500
Date: Mon, 14 Mar 2005 20:49:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: 2.6.11-bk10 build problems
Message-ID: <20050314194930.GB17373@mars.ravnborg.org>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kai@germaschewski.name
References: <1110829177.19340.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110829177.19340.8.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:39:37AM -0800, Dave Hansen wrote:
> I'm having some intermittent build problems on 2.6.11-bk10.  First of
> all, doing a 'make -j8 O=... install' errors out not being able to find
> a vmlinux:
> 
> $ make O=../mhp-build/i386-plain/ -j8 install
> make[3]: *** No rule to make target `vmlinux', needed by
> `arch/i386/boot/compressed/vmlinux.bin'.  Stop.
> make[2]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> make[1]: *** [install] Error 2
> make: *** [install] Error 2
> 
> Also, I just ran menuconfig, changed an option, and did another 'make
> install', and it went straight to the install script with no
> compiling.  
> 
> Note that these are with O=, so it might be just a separate build tree
> problem.
> 
> Any ideas?

On popular request 'make install' no longer try to update vmlinux.
This is to avoid errornous recompilation when installing the kernel
as root especially when fetching kernel via nfs where path may have
changed.

	Sam
