Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVJRQPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVJRQPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVJRQPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:15:16 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:37083 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750910AbVJRQPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:15:14 -0400
Date: Mon, 17 Oct 2005 21:15:56 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: updated perfmon new code base package available
Message-ID: <20051018041556.GJ3614@frankl.hpl.hp.com>
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

Hello everyone,

I have released an updated version of the perfmon new code base package.
This release is relative to 2.6.14-rc4-mm1. I have also updated the library,
libpfm-3.2, to match the kernel level changes.

Kernel-package features:
------------------------
	- preliminary support for MIPS R5000 by Phil Mucci
	- on X86-64, P6, P4 32-bits, the PMC enable bits are now
	  under the control of the users. Pfm_start/pfm_stop do not
	  touch them anymore. That means applications must set them.
	- simplified arch-specific interface (merged calls)
	- simplified PMU description tables (removed dep_pmc[])

I now have a compilation environment for PPC64 and MIPS64, as such
I have verified that the patches for those architectures compile,
no actual testing has been done, though.

For MIPS, the patch is relative to the www.linux-mips.org GIT
tree as they still maintain a separate tree. The common perfmon
patch does apply cleanly even though the MIPS tree is sligthly
behind (see README.mips).

For libpfm-3.2, the updates is to reflect the changes for the
enable bits for P6, X86-64. The P4 standalone programs, and
PEBS examples have also been  updated for enable bits. Note
that the PEBS support does not seem to work when Hyperthreading
is enabled. I have not yet tracked this one down, any volunteer?

You can grab both packages at our SourceForge web site:
	
	http://www.sf.net/projects/perfmon2

You must download:
	- 2.6.14-rc4-mm1-051017
	- libpfm-3.2-051018

Enjoy,

-- 
-Stephane
