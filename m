Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVBJWnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVBJWnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 17:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVBJWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 17:43:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:54207 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261876AbVBJWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 17:43:35 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050210023508.3583cf87.akpm@osdl.org>
References: <20050210023508.3583cf87.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 09:42:20 +1100
Message-Id: <1108075340.7687.212.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 02:35 -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> 
> 
> - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
>   It seems that nothing else is going to come along and this is completely
>   encapsulated.
> 
> - Various other stuff.  If anyone has a patch in here which they think
>   should be in 2.6.11, please let me know.  I'm intending to merge the
>   following into 2.6.11:
> 
> 	alpha-add-missing-dma_mapping_error.patch
> 	fix-compat-shmget-overflow.patch
> 	fix-shmget-for-ppc64-s390-64-sparc64.patch
> 	binfmt_elf-clearing-bss-may-fail.patch
> 	qlogic-warning-fixes.patch
> 	oprofile-exittext-referenced-in-inittext.patch
> 	force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
> 	oprofile-arm-xscale1-pmu-support-fix.patch

Without the aty128fb and radeonfb updates, current 2.6.11 is a
regression on pmac as it breaks sleep support on previously working
laptops. If you don't intend to get at least
try_to_acquire_console_sem() and aty128fb fix in, in which case i can
send you a minimal radeonfb patch, then I'll have to make another patch
for 2.6.11 that reverts some of the arch changes to re-enable sleep on
those machines.

Ben.


