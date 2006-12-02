Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424165AbWLBQ4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424165AbWLBQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424156AbWLBQ4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:56:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23557 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424165AbWLBQ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:56:21 -0500
Date: Sat, 2 Dec 2006 17:56:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, aia21@cantab.net
Subject: Re: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
Message-ID: <20061202165626.GO11084@stusta.de>
References: <20061128140840.f87540e8.randy.dunlap@oracle.com> <20061128164538.d95e8498.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128164538.d95e8498.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 04:45:38PM -0800, Andrew Morton wrote:
> On Tue, 28 Nov 2006 14:08:40 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > NTFS (=m) uses hweight32(), but that function is only linked
> > into the kernel image if it is used inside the kernel image,
> > not in loadable modules.  Let modules force HWEIGHT to be
> > built into the kernel image.  Otherwise build fails:
> > 
> >   Building modules, stage 2.
> >   MODPOST 94 modules
> > WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
> > 
> > Yes, I'd certainly prefer for this to be more automated rather than
> > forced by each module that needs it.
> 
> Perhaps we should just put it in lib-y and remove CONFIG_GENERIC_HWEIGHT.
>...

This will obviously not help in this case...

EXPORT_SYMBOL() in a lib-* is always a bug.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

