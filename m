Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWFMWAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWFMWAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFMWAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:00:21 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:58833 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932302AbWFMWAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:00:20 -0400
Date: Tue, 13 Jun 2006 14:52:51 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net
Subject: 2.6.17-rc6 new perfmon code base + libpfm available
Message-ID: <20060613215251.GB5407@frankl.hpl.hp.com>
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
This version of the kernel patch is relative to 2.6.17-rc6.

The patch includes:
	- moved all set/multiplexing related code into a dedicated file,
	  name perfmon_sets.c.

	- cleaned a lot of code (for style, dead code)

	- switch all lists to use list.h 

	- fix locking bugs in perfmon_syscalls.c

	- simplified PMU description tables with macros to improve
	  readability and extensibility

	- updated Kconfig structure as per Roman's feedback

	- changed the pfarg_setinfo structure to include 2 new
	  bitfields to report list of available PMU registers

As a consequence of the small API change, you need to update to
libpfm-3.2-060613.

Also new in libpfm-3.2-060613:
	- integrated common code to manage separate event unit masks
	  by Kevin Corry (IBM). With this code we now have an API to
	  handle complicated unit mask combinations on processors such
	  as P4, for instance.

	- updated detect_pmcs.c to use the new pfm_getinfo_evtsets()
	  to retrieve the list of unavalaible pmc registers.

	- updated all examples to use the new detect_pmcs code.

This version of the library ONLY works with 2.6.17-rc6 and higher.


You can grab the new packages at our web site:

	 http://perfmon2.sf.net
-- 
-Stephane
