Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVAOHSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVAOHSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVAOHSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:18:30 -0500
Received: from cantor.suse.de ([195.135.220.2]:41453 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262230AbVAOHS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:18:26 -0500
Date: Sat, 15 Jan 2005 08:18:25 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, rusty@rustcorp.com.au, manpreet@fabric7.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050115071825.GA1576@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <20050114222841.5edf7812.akpm@osdl.org> <20050115064315.GF22863@wotan.suse.de> <20050114225457.611cea19.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114225457.611cea19.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't get it.  By the time the secondaries enter the idle loop, they've
> already run init_timers_cpu() anyway.  You patch doesn't address a


The notifier uns only after smp_prepare_cpus and then all the synchronization
is long done. 

> secondary taking a timer interrupt prior to the BP having run
> init_timers(), does it?

It initializes the timer of a CPU before it is even touched. 

-Andi

