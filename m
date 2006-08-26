Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHZWZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHZWZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHZWZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 18:25:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbWHZWZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 18:25:27 -0400
Date: Sat, 26 Aug 2006 15:25:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060826152500.34f56d01.akpm@osdl.org>
In-Reply-To: <20060826220525.GA27933@elte.hu>
References: <20060824102618.GA2395@in.ibm.com>
	<20060824091704.cae2933c.akpm@osdl.org>
	<20060825095008.GC22293@redhat.com>
	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
	<20060826220525.GA27933@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 00:05:25 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > I personally doubt that it's the case that we'd want to accelerate 
> > inclusion - very few things actually do CPU hotplug, and right now the 
> > only way to even hit the sequences in normal use is literally just the 
> > "suspend under SMP" case that hasn't historically worked very well 
> > anyway, but was what made at least me personally aware of the problems 
> > ;^).
> 
> there's also bootup on SMP that is technically a series of hot-cpu-add 
> events. That already tests some aspects of it. Maybe we should turn 
> shutdown into the logical reverse: into a series of hot-cpu-remove 
> events?
> 

Would be logical, but we would want to avoid making CONFIG_HOTPLUG_CPU a
requirement for SMP. 
