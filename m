Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWBGWx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWBGWx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWBGWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:53:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21252 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932468AbWBGWx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:53:26 -0500
Date: Tue, 7 Feb 2006 23:53:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Keith Owens <kaos@sgi.com>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] IA64_GENERIC shouldn't select other stuff
Message-ID: <20060207225325.GE3524@stusta.de>
References: <20060207221157.GA3524@stusta.de> <9883.1139351831@ocs3> <20060207224344.GF1601@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207224344.GF1601@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:43:44PM -0700, Matthew Wilcox wrote:
> On Wed, Feb 08, 2006 at 09:37:11AM +1100, Keith Owens wrote:
> > A generic IA64 kernel requires (at least) the ACPI and NUMA options in
> > order to run on all the IA64 platforms out there.  Omitting those
> > options and relying on the user to set them by hand is going to cause
> > more problems.
> 
> I'm not sure about that.  If the user selects a specific type of machine,
> ACPI doesn't get selected for them -- even when it's needed to boot.
> It's certainly inconsistent and should be fixed one way or the other.

And PCI is never selected for him with IA64_GENERIC.

I see the point for a catch-all option for processor-specific stuff, but 
it can't be a replacement for allyesconfig.

AFAIR your defconfig was intended for the "runs everywhere" case (with 
the exception that in this case the bug that CONFIG_ITANIUM is not set 
is still unfixed - would you accept a patch to fix this?).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

