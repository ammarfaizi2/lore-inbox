Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSA2Wd0>; Tue, 29 Jan 2002 17:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSA2WdD>; Tue, 29 Jan 2002 17:33:03 -0500
Received: from ns.suse.de ([213.95.15.193]:14095 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285424AbSA2Wbv>;
	Tue, 29 Jan 2002 17:31:51 -0500
Date: Tue, 29 Jan 2002 23:31:50 +0100
From: Andi Kleen <ak@suse.de>
To: adilger@turbolabs.com, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129233150.D12339@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain.suse.lists.linux.kernel> <E16VYD8-0003ta-00@the-village.bc.nu.suse.lists.linux.kernel> <p73aduwddni.fsf@oldwotan.suse.de> <20020129152426.Z763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020129152426.Z763@lynx.adilger.int>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 03:24:26PM -0700, Andreas Dilger wrote:
> On Jan 29, 2002  22:56 +0100, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > Lots of the stuff getting missed is tiny little fixes, obvious 3 or 4
> > > liners. The big stuff is not the problem most times.
> >
> > "Most times". For example the EA patches have badly failed so far, just
> > because Linus ignored all patches to add sys call numbers for a repeatedly
> > discussed  and stable API and nobody else can add syscall numbers on i386. 
> 
> But at times, keeping things external to the kernel for a good while isn't
> a bad thing either.  Basically, once code is part of the kernel, the API
> is much harder to change than if it was always an optional patch.
> 
> For example, the EA patches have matured a lot in the time that they have
> been external to the kernel (i.e. the move towards a common API with ext2
> and XFS).  Even so, the ext2 shared EA on-disk representation leaves a

The problem is that there are already 5-6 different incompatible system calls 
with either different numbers or different semantics in significant 
deployment in the wild. EA/ACLs is an important feature for
samba servers so they are rather popular. While it's IMHO ok to do limited
testing in private the critical threshold where incompatible system call
ABIs are just a big problem for linux has long been surpassed. 
One of the success linux/i386 had in the past was to maintain a very stable
kernel ABI, but at least in the EA space this archivement is currently
getting undermined badly. 

-Andi
