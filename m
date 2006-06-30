Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWF3QKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWF3QKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWF3QKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:10:17 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:4802 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751423AbWF3QKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:10:15 -0400
Date: Fri, 30 Jun 2006 09:02:03 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630160203.GH22381@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <200606301541.22928.ak@suse.de> <20060630141248.GC22381@frankl.hpl.hp.com> <200606301633.35818.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301633.35818.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

As a first step, I am looking at implementing a TIF_DEBUG
for x86-64. AFAIK, debug registers must not be inherited on
fork().

In copy_thread(), I do not see the place where the child's
debug registers (or just debugreg7) are cleared to avoid
reloading the parents values in __switch_to() if debugreg7
is not 0. I believe the debug registers values are copied
in dup_task_struct().

Am I missing something?

--
-Stephane
