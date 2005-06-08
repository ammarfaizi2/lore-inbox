Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVFHW00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVFHW00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVFHW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:26:26 -0400
Received: from palrel12.hp.com ([156.153.255.237]:58263 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262129AbVFHW0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:26:19 -0400
Date: Wed, 8 Jun 2005 14:59:46 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: perfmon2 new code base Update 1
Message-ID: <20050608215945.GH21554@frankl.hpl.hp.com>
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

Hi,

I am happy to announce an updated version of the code for
the new perfmon code base. This update fixes several important
problems and incorporates many cleanups. I would like to thank
all the people who have provided feedback and I certainly
welcome more of it.

This update is relative to 2.6.12-rc6. Here is an excerpt
of the ChangeLog:
	* fixed Pentium M counter width to 40 (from invalid 32)
	* fixed in-flight overflow handling for non IA-64
	* fixed timeout-based set switching from non IA-64
	* removed unused pfm_arch_ callbacks
	* reformatted code to 80 column wherever possible
	* reformatted if/then/else
	* fixed pfm_arch_monitoring_is_active() for non IA-64
	* fixed race condition in pfm_do_interrupt_handler()
	* added generic carta_random32() routine
	* regrouped IA-64 old perfmon2 compatbility code in perfmon_compat.c
	* updated pfm_ovfl_msg_t with new fields for user level sampling
	* use custom nopage handler to remap kernel level sampling buffer

Again this is not for production nor mainline at this point. This is
for OS and tools developers. There are some known bugs on Pentium M
in particular and some features are still incomplete.

You can grab the package at:
	ftp://ftp.hpl.hp.com/pub/linux-ia64/perfmon-new-base-050608.tar.gz
	MD5SUM: b608274d1211c43b65c662136a0e6d1f

Enjoy,

-- 
-Stephane
