Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271016AbTGPR5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270974AbTGPRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:53:44 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:1428 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271001AbTGPRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:51:29 -0400
Date: Wed, 16 Jul 2003 19:05:35 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: John Levon <levon@movementarian.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH] Use of Performance Monitoring Counters based on Model number
Message-ID: <20030716180535.GB26192@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Levon <levon@movementarian.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D0F9@fmsmsx405.fm.intel.com> <20030716171956.GC19910@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716171956.GC19910@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:19:56PM +0100, John Levon wrote:

 > > Attached is a small patch to make Linux kernel use of performance
 > > monitoring MSRs based on known processor models. Future processor
 > > implementation models may not support the same MSR layout.
 > If you're going to do this you should fix up arch/i386/oprofile/ to
 > error out similarly at least

It'd also be nice to let the user know why things aren't working
instead of silent failure. A simple

	printk (KERN_INFO "Performance counter support for this CPU not yet added.\n");

Should do the trick.

		Dave
