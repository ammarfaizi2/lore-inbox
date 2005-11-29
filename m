Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVK2XjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVK2XjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVK2XjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:39:22 -0500
Received: from ns.suse.de ([195.135.220.2]:21397 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbVK2XjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:39:21 -0500
Date: Wed, 30 Nov 2005 00:39:20 +0100
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129233920.GW19515@wotan.suse.de>
References: <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <1133305338.3271.30.camel@entropy> <20051129231750.GU19515@wotan.suse.de> <1133306966.3271.36.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133306966.3271.36.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if that's all you want them to use RDPMC 0 for, why not just make
> PMCs programmable from userspace?

First we need to have a cycle counter PMC anyways for the NMI watchdog.
So it can as well be used for other purposes.

And using virtual performance counters adds a large cost the 
context switch for changing the MSRs around. An always running counter
avoids this problem.

-Andi
