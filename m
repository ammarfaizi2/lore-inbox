Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWFUOdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWFUOdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWFUOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:32:49 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:2972 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751635AbWFUOcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:32:43 -0400
Date: Wed, 21 Jun 2006 07:24:47 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060621142447.GA29389@frankl.hpl.hp.com>
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

I have released another version of the perfmon new code base package.
This version of the kernel patch is relative to 2.6.17.1.

The patch includes:
	- support for 32-bit mode AMD64 processors (Chuck Ebbert)
	- mini-argument buffers on stack optimization for read/write of PMU registers
	- fix user group permission checking which were ignored
	- fix a missing irqsave in perfmon_kapi.c

For the stack buffers there are per-arch constants that can be adjusted based
on stack size limitations. Look for PFM_ARCH_PM*_ARG.

I have also release a new libpfm, libpfm-3.2-060621, which includes:

	- support for 32-bit mode AMD64 processors
	- fix an opcode matching/range restriction limitation for Itanium2 PMC13
 	  and Montecito PMC41 registers.

This version of the library works with 2.6.17-rc6 and 2.6.17.1

Also a new version of pfmon, pfmon-3.2-060621, to take advantage of the update in libpfm:

	- support for 32-bit mode AMD64 processors
	- updated event name parsing to prepare for separate
	  event unit mask management (Kevin Corry)
	- fix the detection of unavailable PMC registers. it was causing crashes
	  when used with sampling.

Note that I have tested 32-bit compiled libpfm,pfmon running on an 64-bit AMD
perfmon kernel. I have not tested on a 32-bit AMD linux kernel because I don't
have such setup. I would appreciate any feedback on this.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

PS: I will post an incremental kernel patch and a diffstat on the perfmon mailing list.

-- 
-Stephane
