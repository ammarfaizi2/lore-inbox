Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752376AbWKBTau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbWKBTau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbWKBTau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:30:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752359AbWKBTat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:30:49 -0500
Date: Thu, 2 Nov 2006 11:30:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
In-Reply-To: <20061102190450.GB23489@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0611021129470.25218@g5.osdl.org>
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
 <20061101161723.f132d208.akpm@osdl.org> <20061102190450.GB23489@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2006, Dipankar Sarma wrote:
> 
> IMO, the right thing to do would be to convert lock_cpu_hotplug() to
> a get_cpu_hotplug()/put_cpu_hotplug() type semantics and use a more
> scalable implementation underneath (as opposed to a global
> semaphore/mutex).

Yes, I think Gautham's patch-series basically did exactly that, no? Except 
it kept the old name.

		Linus
