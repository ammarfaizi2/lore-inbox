Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVBJW5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVBJW5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVBJW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 17:57:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:51643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261877AbVBJW5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 17:57:05 -0500
Date: Thu, 10 Feb 2005 15:02:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm2
Message-Id: <20050210150208.315e9a76.akpm@osdl.org>
In-Reply-To: <1108075340.7687.212.camel@gaston>
References: <20050210023508.3583cf87.akpm@osdl.org>
	<1108075340.7687.212.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Thu, 2005-02-10 at 02:35 -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> > 
> > 
> > - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
> >   It seems that nothing else is going to come along and this is completely
> >   encapsulated.
> > 
> > - Various other stuff.  If anyone has a patch in here which they think
> >   should be in 2.6.11, please let me know.  I'm intending to merge the
> >   following into 2.6.11:
> > 
> > 	alpha-add-missing-dma_mapping_error.patch
> > 	fix-compat-shmget-overflow.patch
> > 	fix-shmget-for-ppc64-s390-64-sparc64.patch
> > 	binfmt_elf-clearing-bss-may-fail.patch
> > 	qlogic-warning-fixes.patch
> > 	oprofile-exittext-referenced-in-inittext.patch
> > 	force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
> > 	oprofile-arm-xscale1-pmu-support-fix.patch
> 
> Without the aty128fb and radeonfb updates, current 2.6.11 is a
> regression on pmac as it breaks sleep support on previously working
> laptops.

Is that worse than the risk of the large patch?

> If you don't intend to get at least
> try_to_acquire_console_sem() and aty128fb fix in, in which case i can
> send you a minimal radeonfb patch, then I'll have to make another patch
> for 2.6.11 that reverts some of the arch changes to re-enable sleep on
> those machines.

Ho hum.  PM and fbdev are regularly broken anyway.  Please always identify
the patches by name - it helps avoid mistakes.

These?

add-try_acquire_console_sem.patch
update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
radeonfb-update.patch
radeonfb-build-fix.patch

