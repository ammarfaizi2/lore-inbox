Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWJDOZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWJDOZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWJDOZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:25:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50886 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161045AbWJDOZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:25:24 -0400
Date: Wed, 4 Oct 2006 10:23:33 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061004142333.GA16218@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <m11wpoeewn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wpoeewn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:08:56AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > Increasingly the cobbled together boot protocol that
> > is bzImage does not have the flexibility to deal
> > with booting in new situations.
> >
> > Now that we no longer support the bootsector loader
> > we have 512 bytes at the very start of a bzImage that
> > we can use for other things.
> >
> > Placing an ELF header there allows us to retain
> > a single binary for all of x86 while at the same
> > time describing things that bzImage does not allow
> > us to describe.
> >
> > The existing bugger off code for warning if we attempt to
> > boot from the bootsector is kept but the error message is
> > made more terse so we have a little more room to play with.
> 
> Vivek for this first round can we please take out the ELF
> note processing.  Now that vmlinux has ELF notes of interest
> to the bootloader we really should be getting the ELF notes
> from there.
> 
> So the generation of the ELF notes needs to move into the
> vmlinux and then we need to copy them to ELF header.
> 
> If we just remove the ELF note munging code from this patch
> that should be a good first step in getting the ELF notes correct.

Hi Eric,

Sure. I will get rid if ELF note generation for bzImage ELF header.

But would that stop bootloaders out there from treating kernel as
an ELF executable?

I have got a FC5 machine with grub version .97 and everything seems
to work for me. So I am assuming that Andrew got a newer version of
Grub which is trying to load ther kernel as an ELF executable and then
running into the issues. 

Thanks
Vivek
