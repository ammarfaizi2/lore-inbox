Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTIFEnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 00:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTIFEnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 00:43:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6232 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263561AbTIFEnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 00:43:02 -0400
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB003D42A54@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Sep 2003 22:42:36 -0600
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB003D42A54@fmsmsx406.fm.intel.com>
Message-ID: <m1vfs6o7cz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > I totally agree that it is reasonable to bypass setup.S.  But 
> > to do that reliably requires consensus that the 32bit entry point is 
> > stable.  That has not happen yet, and your patch did nothing to address that.
> I
> 
> > know it has to happen because I know the boot process, and what has to
> > happen to boot with a different x86 BIOS implementation.
> 
> Ok, so how do we know it is stable and how might one address that?  How have you
> addressed this with kexec?

Getting consensus among conservative people is a challenge.  I am slowly
working on it but I have been busy with other things.

> > Entering via the 32bit entry point has not been previously discussed.
> > H. Petern Anvin has not been convinced it should be a stable kernel
> > entry point.  
> 
> Why?  I've missed this argument.   
> 
> The documentation has not been updated.  A recent RedHat
> > kernel has even shipped with a different 32bit kernel entry point.
> 
> I'm afraid I haven't looked at kexec.  Do you employ the standard 32 bit entry
> point or do you actually go back to real mode or something in between?

I use it with the firm knowledge that kernel developers may change it if
the fancy takes them.  There are getting to be fewer and fewer reasons
why someone would want to change it but...

> > My hunch is that most of the EFI code should actually live in another
> > subarch.  I think the kernel has support for compiling in multiple
> > subarches.  If not it is simply because no one has gotten 
> > that far yet.
> 
> I can see how this could be useful and potentially consolidate the efi related
> code in ia64, the ia32 stuff I've posted, and any other architecture that
> supports efi in the future, but don't know about compiling in multiple subarchs.
> Comments on how this is done?

I haven't had a chance to really look at that yet.

Eric
