Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWASDcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWASDcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWASDcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:32:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4755 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030483AbWASDb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:31:59 -0500
Date: Wed, 18 Jan 2006 21:31:31 -0600
From: Mark Maule <maule@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm1: ia64 compile error
Message-ID: <20060119033131.GR3331@sgi.com>
References: <20060118005053.118f1abc.akpm@osdl.org> <20060119031155.GH19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119031155.GH19398@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, I discovered this last night for generic builds.  I'm fixing up the MSI
patches and will send them out in the morning.

sn2_defconfig and zx1_defconfig builds work, more generic ones do not.

Sorry 'bout that.

Mark

On Thu, Jan 19, 2006 at 04:11:55AM +0100, Adrian Bunk wrote:
> On Wed, Jan 18, 2006 at 12:50:53AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm4:
> >...
> > +gregkh-pci-pci-msi-vector-targeting-abstractions.patch
> >...
> >  PCI tree updates
> >...
> 
> This patch breaks the ia64 defconfig:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/ia64/dig/machvec.o
> In file included from arch/ia64/dig/machvec.c:3:
> include/asm/machvec_init.h:32: error: 'ia64_msi_init' undeclared here (not in a function)
> make[1]: *** [arch/ia64/dig/machvec.o] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
