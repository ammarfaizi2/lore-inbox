Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUIHORk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUIHORk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIHOOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:14:45 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:50414 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269140AbUIHONF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:13:05 -0400
Date: Wed, 8 Sep 2004 10:17:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of
 pm_idle
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575120967@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.53.0409080800270.15087@montezuma.fsmlabs.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575120967@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shaohua,

On Wed, 8 Sep 2004, Li, Shaohua wrote:

> Yes, preempt will cause oops in pc_idle. Attached patch should close the
> final race corner. 

Please try and inline your patches in future, i know it may be hard with 
your mail client but it makes commenting on patches easier.

		while (!need_resched()) {
+			void (*idle)(void) = NULL;
+			

You don't need to initialise variable `idle` here. Otherwise the rest 
looks fine with me.

Thanks,
	Zwane

