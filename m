Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbVKQAeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVKQAeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKQAeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:34:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:7300 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161043AbVKQAeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:34:03 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Sonny Rao <sonny.rao@gmail.com>
Cc: Olaf Hering <olh@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <ac0de0c00511161557o379fbc71le6d5c5e2ff9a314b@mail.gmail.com>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston>
	 <1131573556.25354.1.camel@localhost.localdomain>
	 <1131573693.24637.109.camel@gaston>
	 <1131574051.25354.3.camel@localhost.localdomain>
	 <20051116230820.GA29068@suse.de>
	 <1132183002.24066.90.camel@localhost.localdomain>
	 <ac0de0c00511161557o379fbc71le6d5c5e2ff9a314b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:33:55 -0800
Message-Id: <1132187635.24066.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 17:57 -0600, Sonny Rao wrote:
> On 11/16/05, Badari Pulavarty <pbadari@us.ibm.com> wrote:
>         On Thu, 2005-11-17 at 00:08 +0100, Olaf Hering wrote:
>         >  On Wed, Nov 09, Badari Pulavarty wrote:
>         >
>         > > On Thu, 2005-11-10 at 09:01 +1100, Benjamin Herrenschmidt
>         wrote:
>         > > > > I didn't have any luck on 2.6.14-git12 either.
>         > > > > I tried 64k page support on my P570.
>         > > > >
>         > > > > Here are the console messages:
>         > > >
>         > > > What distro do you use in userland ? Some older glibc
>         versions have a 
>         > > > bug that cause issues with 64k pages, though it
>         generally happens with
>         > > > login blowing up, not init ...
>         > >
>         > > SLES9 (could be SLES9 SP1).
>         >
>         > Can you double check? rpm -qi glibc | head should be
>         enough. 
>         > Would be bad if SP2 or SP3 does not work with 64k.
>         >
>         
>         I think I am using SLES9. Planning to update to SP3.
> 
>  
> Badari, the problem is with your toolchain.. 
> the binutils in SLES9 is too old (even in SP3)
> 
> The issue is that it cannot align something (the zero page I think) to
> 64kb .
> 
> SLES9 SP3 has "GNU ld version 2.15.90.0.1.1 20040303 (SuSE Linux)"
> 
> But I have to use binutils 2.15.94 to make a 64kb kernel boot
> properly 
> (I can give you the package offline if you need)

Thank you Sonny. I updated my binutils package and 64k pagesize
kernel works fine for me (atleast booted fine).

Thanks,
Badari

