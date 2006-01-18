Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWARU7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWARU7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWARU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:59:00 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:23695 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030457AbWARU66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:58:58 -0500
Date: Wed, 18 Jan 2006 12:56:30 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net
Subject: 2.6.16-rc1 perfmon2 new code base with Montecito support + libpfm available
Message-ID: <20060118205630.GC19020@frankl.hpl.hp.com>
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
This release is relative to 2.6.16-rc1.

Due to the addition of the migrate_pages() system call, all perfmon
system calls have been shifted by one. As a consequence, you must
relink your applications using the new version of libpfm which
is also released today: libpfm-3.2-060118.

This new kernel patch includes several important changes:

	- added support for the Dual-Core Itanium 2 (Montecito) processor

	- working support for MIPS5K and MIPS20k (by Phil Mucci)

	- lots of cleanups in the PMU description modules. Some common
	  functionalities moved into core (masking of reserved fields)

	- PFM_REGFL_NEMUL64 managed from perfmon core

The new version of the library, libpfm, includes the following changes:

	- added support for MIPS5K, MIPS20K

	- added pfm_get_event_counter() interface with man page

	- added support for compiling using a 32-bit ABI on a 64-bit OS
	  (not available on all platforms, see config.mk)

	- reworked all standalone examples

	- cleanups and fixes in the generic examples

The two packages can be downloaded from the SourceForge website at:

	http://www.sf.net/projects/perfmon2

I will be posting the patches directly to LKML for
review very shortly.

Enjoy,

-- 
-Stephane
