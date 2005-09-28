Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVI1Wb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVI1Wb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVI1Wb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:31:58 -0400
Received: from palrel12.hp.com ([156.153.255.237]:3821 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751133AbVI1Wb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:31:57 -0400
Date: Wed, 28 Sep 2005 03:33:31 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-mm1 new perfmon2 kernel patch available
Message-ID: <20050928103331.GB3808@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <44BDAFB888F59F408FAE3CC35AB4704102225AA9@orsmsx409> <20050928040218.GB3170@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928040218.GB3170@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I am pleased to announce that I have released an  updated version
of new-perfmon2 code base. This patch is against 2.6.14-rc2-mm1.

This new releases includes:
	- several bug fixes
	- many performance improvements (a PMD read on Itanium2 is down to 645 cycles).
	- a lot of code simplifications
	- support for P4/Xeon 32-bit (e.g., family 15 model 2).
	  includes support for HyperThreading(HT).
	- a P4/Xeon 32-bit sampling format for Precise Event Based sampling (PEBS)

The patch is known to work for all Itanium processors, P6/Pentium M,
AMD X86-64, P4/Xeon 32-bit. I do not have a lot of user level support for P4 so
testing was limited. Hopefully some people on this list may help with this.
The EM64T is currently broken and must be updated to match the level of
the P4/Xeon 32-bit version. The ppc64 portion has not been tested at all,
it might not even compile.

For all PMU models, the mapping from PMC/PMD to actual PMU registers is
accessible through /proc/perfmon_map. That is useful for people porting
applications from other interfaces.

I encourage everybody to test this patch on their machine and report any
problems.

You can download the new patch from our project website at:

	http://www.sf.net/projects/perfmon2

as release: 2.6.14-rc2-mm1-050928

Enjoy,

-- 
-Stephane
