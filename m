Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVLUTDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVLUTDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLUTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:03:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45004 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751190AbVLUTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:03:51 -0500
Date: Wed, 21 Dec 2005 13:03:49 -0600
From: Mark Maule <maule@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/4] msi archetecture init hook
Message-ID: <20051221190349.GH9920@sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184342.5003.74247.39285@attica.americas.sgi.com> <20051221185346.GC2361@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221185346.GC2361@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 11:53:46AM -0700, Matthew Wilcox wrote:
> On Wed, Dec 21, 2005 at 12:42:36PM -0600, Mark Maule wrote:
> > Index: msi/include/asm-sparc/msi.h
> > ===================================================================
> > --- msi.orig/include/asm-sparc/msi.h	2005-12-13 12:22:42.785246074 -0600
> > +++ msi/include/asm-sparc/msi.h	2005-12-13 16:09:49.194541334 -0600
> > @@ -28,4 +28,6 @@
> >  			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
> >  }
> >  
> > +static inline int msi_arch_init(void)	{ return 0; }
> > +
> >  #endif /* !(_SPARC_MSI_H) */
> 
> As far as I can tell, you can't select MSI on Sparc, so this doesn't
> need to be here ...

Ok.  I'm a little confused on why we have asm-sparc/msi.h then.  Should I
yank it, or leave it for consistency and return -EINVAL so pci_enable_msi()
could fail somewhat gracefully on sparc ?

Mark
