Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUKAJwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUKAJwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUKAJwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:52:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:60827 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261734AbUKAJwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:52:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16774.1839.343824.305232@suse.de>
Date: Mon, 1 Nov 2004 10:51:43 +0100
From: Egbert Eich <eich@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, linux-kernel@vger.kernel.org,
       idr@us.ibm.com, eich@suse.de
Subject: Re: status of DRM_MGA on x86_64
In-Reply-To: ak@suse.de wrote on , 30 October 2004 at 03:56:24 +0200 
References: <1099052450.11282.72.camel@hostmaster.org.suse.lists.linux.kernel>
	<1099061384.11918.4.camel@hostmaster.org.suse.lists.linux.kernel>
	<41829E39.1000909@us.ibm.com.suse.lists.linux.kernel>
	<1099097616.11918.26.camel@hostmaster.org.suse.lists.linux.kernel>
	<p734qkd0y0n.fsf@verdi.suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Thomas Zehetbauer <thomasz@hostmaster.org> writes:
 > 
 > > On Fre, 2004-10-29 at 12:47 -0700, Ian Romanick wrote:
 > > > The problem, which exists with most (all?) DRM drivers, is that data 
 > > > types are used in the kernel/user interface that have different sizes on 
 > > > LP32 and LP64.  If your kernel is 64-bit, you will have problems with 
 > > > 32-bit applications.
 > 
 > That was not the reason I disabled it. I reenabled it now in my tree.
 >   
 > > Then either all or no DRM drivers should be enabled on x86_64, the
 > > DRM_TDFX, DRM_R128, DRM_RADEON and DRM_SIS are not currently disabled. I
 > > vote for enabling all drivers that work with 64-bit applications.
 >  
 > > I wonder if this should be the first and only place where different
 > > kernel/userland bitness causes problems. How has this been solved
 > > elsewhere?
 > 
 > It was solved long ago for the Radeon driver by Egbert Eich.
 > But for some unknown reason the DRI people never merged his patches.
 > 

I solved it for RADEON, MGA and R128.
It would be interesting to solve this for the i915 driver, too,
and possibly some others.

That it hasn't been merged into DRI yet is a shame. Appearantly 
nobody has ever realized why this stuff is useful. Unfortunately
I don't have the time for lobbying it.
It's a very boring undertaking to have to port this from one DRI 
version to the next. 

Egbert.

