Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbVLOKrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbVLOKrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbVLOKrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 05:47:22 -0500
Received: from palrel12.hp.com ([156.153.255.237]:24013 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1422646AbVLOKrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 05:47:21 -0500
Date: Thu, 15 Dec 2005 02:46:04 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-git3 perfmon2 new code base + libpfm available
Message-ID: <20051215104604.GA16937@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released a new version of the perfmon base package.
This release is relative to 2.6.15-rc5-git3.

I have also updated the library, libpfm-3.2, to match the kernel
level changes. 

This new kernel patch includes several important changes:

  - pfm_create_context() interface has changed. The sampling
    buffer format argument is now passed explicitly instead
    of relying on it being contiguous to pfarg_ctx_t.

  - code in perfmon/perfmon.c has been split into 8 
    different files for improved maintainability. Each
    file implements one specific function. Perfmon.c
    remains the core.

  - fixed several important bugs for i386 and x86_64 for
    Intel P4/Xeon (simple counting was returning 0).

  - added support for virtual PMD (read/write)

  - added notion of read-only PMD

  - Split Pentium M/P 6 PMU description in preparation for
    Pentium M LBR support

  - Added support for reference counting on PMU description
    and Sampling buffer modules to avoid panic in case
    module is removed while being used.

  - On i386/X86_64, added code to handle the NMI watchdog
    when it is using the Local APIC. We now use
    reserve_lapic_nmi() and release_lapic_nmi().

  - various other cleanups and bug fixes

You MUST use libpfm-3.2-051215 with this kernel due to
interface change for pfm_create_context().

As usual, you can download the latest packages from the
SourceForge website at:

	http://www.sf.net/projects/perfmon2

I will be posting the patches directly to LKML for
review very shortly.

Enjoy,
-- 

-Stephane
