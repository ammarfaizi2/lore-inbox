Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVCNUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVCNUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCNUg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:36:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53909 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261900AbVCNUfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:35:15 -0500
Date: Mon, 14 Mar 2005 12:34:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: 2.6.11-bk10 build problems
Message-ID: <566920000.1110832470@flay>
In-Reply-To: <20050314194930.GB17373@mars.ravnborg.org>
References: <1110829177.19340.8.camel@localhost> <20050314194930.GB17373@mars.ravnborg.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, March 14, 2005 20:49:30 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:

> On Mon, Mar 14, 2005 at 11:39:37AM -0800, Dave Hansen wrote:
>> I'm having some intermittent build problems on 2.6.11-bk10.  First of
>> all, doing a 'make -j8 O=... install' errors out not being able to find
>> a vmlinux:
>> 
>> $ make O=../mhp-build/i386-plain/ -j8 install
>> make[3]: *** No rule to make target `vmlinux', needed by
>> `arch/i386/boot/compressed/vmlinux.bin'.  Stop.
>> make[2]: *** [arch/i386/boot/compressed/vmlinux] Error 2
>> make[1]: *** [install] Error 2
>> make: *** [install] Error 2
>> 
>> Also, I just ran menuconfig, changed an option, and did another 'make
>> install', and it went straight to the install script with no
>> compiling.  
>> 
>> Note that these are with O=, so it might be just a separate build tree
>> problem.
>> 
>> Any ideas?
> 
> On popular request 'make install' no longer try to update vmlinux.
> This is to avoid errornous recompilation when installing the kernel
> as root especially when fetching kernel via nfs where path may have
> changed.

That's frigging annoying. It's worked that way for ages, and all our
scripts assume it works. 

Andrew, can we back that out?

M.
