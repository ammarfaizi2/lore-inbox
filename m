Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDEPs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDEPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWDEPs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:48:29 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:27585 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750921AbWDEPs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:48:28 -0400
Date: Wed, 5 Apr 2006 08:43:19 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net
Subject: 2.6.17-rc1 perfmon2 new code base + libpfm available
Message-ID: <20060405154319.GD6232@frankl.hpl.hp.com>
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
This release is relative to 2.6.17-rc1

There were, once again, new system calls added. As such a new libpfm is
necessary.

This new kernel patch includes several changes:

	- Merged i386 and x86_64 perfmon.c architecture specific codes

	- Merged PMU description modules for em64t and p4.

	- support for automatic loading of PMU description modules if
	  CONFIG_KMOD=y. Make sure you run make modules_install

	- MIPS patches are back and are applied onto the mainline kernel

This release uses the new/mod patch breakdown for all architectures.
To apply, you can simply do:
	cat ../perfmon-new-base-060405/*.diff | patch -p1 

The new version of the library, libpfm, includes the following changes:

	- updated to match 2.6.17-rc1 new system call numbers

	- modified pfmlib.h to use 64-bit integer for generic PMC register
	  (submitted by Kevin Corry from IBM)

I have finally created a minimal home page for the project. So now
you can access the latest news and files from:

	http://perfmon2.sf.net

I received notification from SF.net, that the libpfm package has been installed
into our CVS repository. It should become visible fairly quickly now. Once this
happens, I will update the tree to include this new version of the library.

Enjoy,

-- 
-Stephane
