Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWBHCng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWBHCng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWBHCng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:43:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13830 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965182AbWBHCnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:43:35 -0500
Date: Wed, 8 Feb 2006 03:43:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Keith Owens <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060208024333.GL3524@stusta.de>
References: <20060208020832.GK3524@stusta.de> <200602080217.k182Hlg23826@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080217.k182Hlg23826@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 06:17:47PM -0800, Chen, Kenneth W wrote:
> Adrian Bunk wrote on Tuesday, February 07, 2006 6:09 PM
> > > CONFIG_IA64_GENERIC is a platform type choice, you can have platform
> > > type of DIG, HPZX1, SGI SN2, or all of the above.  DIG platform depends
> > > on ACPI, thus need ACPI on.  SGI altix is a numa box, thus, need NUMA
> > > on.  NEC, Fujitsu build numa machines with ACPI SRAT table, thus, need
> > > ACPI_NUMA on.  When you build a kernel to boot on all platforms, you
> > > have no choice but to turn on all of the above.  Processor type and SMP
> > > is different from platform type.  It does not have any dependency on
> > > platform type.  They are orthogonal choice.
> > 
> > This is interesting, considering that e.g. IA64_SGI_SN2=y, NUMA=n or 
> > IA64_DIG=y, ACPI=n are currently allowed configurations.
> 
> Right, that is what Matthew Wilcox said in earlier thread.
> 
> 
> > > > Keith said IA64_GENERIC should select all the options required in
> > > > order to run on all the IA64 platforms out there.
> > >                           ^^^^^^^^^^^^^^
> > > > This is what my patch does.
> > > 
> > > You patch does more than what you described and is wrong.  Selecting
> > > platform type should not be tied into selecting SMP nor should it tied
> > 
> > This was what Keith wanted.
> > 
> > It seems everyone thinks I am wrong, but when I'm implementing what one 
> > person suggests, other people say that what I am doing is wrong.
> 
> You have to digest what people say and *understand* why they said what they
> say. Checking earlier thread, Keith did not say "select CONFIG_ITANIUM
> for generic ia64 platforms".
>...

Keith suggested that IA64_GENERIC should select SMP, and this is what 
you disagreed with.

And I'm still interested in your suggestion for the 
IA64_GENERIC<->NUMA<->FLATMEM dependencies.

> - Ken

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

