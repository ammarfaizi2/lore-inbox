Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263666AbUJ3CCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUJ3CCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUJ3B7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:59:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:61390 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261214AbUJ3B5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:57:37 -0400
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org, idr@us.ibm.com, eich@suse.de
Subject: Re: status of DRM_MGA on x86_64
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	<1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	<41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	<1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2004 03:56:24 +0200
In-Reply-To: <1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
Message-ID: <p734qkd0y0n.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer <thomasz@hostmaster.org> writes:

> On Fre, 2004-10-29 at 12:47 -0700, Ian Romanick wrote:
> > The problem, which exists with most (all?) DRM drivers, is that data 
> > types are used in the kernel/user interface that have different sizes on 
> > LP32 and LP64.  If your kernel is 64-bit, you will have problems with 
> > 32-bit applications.

That was not the reason I disabled it. I reenabled it now in my tree.
  
> Then either all or no DRM drivers should be enabled on x86_64, the
> DRM_TDFX, DRM_R128, DRM_RADEON and DRM_SIS are not currently disabled. I
> vote for enabling all drivers that work with 64-bit applications.
 
> I wonder if this should be the first and only place where different
> kernel/userland bitness causes problems. How has this been solved
> elsewhere?

It was solved long ago for the Radeon driver by Egbert Eich.
But for some unknown reason the DRI people never merged his patches.

-Andi
